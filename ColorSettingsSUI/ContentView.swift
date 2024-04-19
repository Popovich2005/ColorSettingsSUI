//
//  ContentView.swift
//  ColorSettingsSUI
//
//  Created by Алексей Попов on 19.04.2024.
//

import SwiftUI

struct ContentView: View {
    @State private var sliderValueRed = Double.random(in: 0...255)
    @State private var sliderValueGreen = Double.random(in: 0...255)
    @State private var sliderValueBlue = Double.random(in: 0...255)

    var body: some View {
        ZStack {
            Color.cyan
                .ignoresSafeArea()
            
            VStack(spacing: 20) {
                ColorView(sliderValueRed: $sliderValueRed,
                          sliderValueGreen: $sliderValueGreen,
                          sliderValueBlue: $sliderValueBlue
                )
                
                ColorSliderView(sliderValue: $sliderValueRed)
                    .tint(.red)
                ColorSliderView(sliderValue: $sliderValueGreen)
                    .tint(.green)
                ColorSliderView(sliderValue: $sliderValueBlue)
                    .tint(.blue)
                
                Spacer()
            }
            .padding()
        }
    }
}

#Preview {
    ContentView()
}

struct ColorSliderView: View {
    @Binding var sliderValue: Double
    
    var body: some View {
        HStack {
            Text(lround(sliderValue).formatted()).foregroundStyle(.white)
            Slider(value: $sliderValue, in: 0...255, step: 1)

        }
    }
}

struct ColorView: View {
    @Binding var sliderValueRed: Double
    @Binding var sliderValueGreen: Double
    @Binding var sliderValueBlue: Double
    
    var body: some View {
        Rectangle()
            .frame(width: 300, height: 200)
            .foregroundStyle(Color(red: sliderValueRed / 255,
                                   green: sliderValueGreen / 255,
                                   blue: sliderValueBlue / 255)
            )
            .clipShape(.rect(cornerRadius: 15))
            .overlay(
                RoundedRectangle(cornerRadius: 15)
                    .stroke(.white, lineWidth: 4)
            )
    }
}
