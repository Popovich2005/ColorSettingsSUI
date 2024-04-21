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
    
    @State private var isAlertPresented = false
    
    @State private var inputValueRed: String = ""
    @State private var inputValueGreen: String = ""
    @State private var inputValueBlue: String = ""
    
    var body: some View {
        ZStack {
            Color.cyan
                .ignoresSafeArea()
                .onTapGesture {
                    hideKeyBoard()
                    validateValues()
                    setSliderValues()
                }
                .toolbar {
                    ToolbarItem(placement: .keyboard) {
                        HStack {
                            Spacer()
                            Button("Done") {
                                validateValues()
                                setSliderValues()
                                hideKeyBoard()
                            }
                            .foregroundStyle(.blue)
                        }
                    }
                }
                .alert("Wrong format", isPresented: $isAlertPresented,
                       actions: {}) {
                    Text("Please enter valid RGB values in range 0...255")
                }
            
            VStack(spacing: 20) {
                ColorView(sliderValueRed: $sliderValueRed,
                          sliderValueGreen: $sliderValueGreen,
                          sliderValueBlue: $sliderValueBlue
                )
                
                ColorSliderView(sliderValue: $sliderValueRed, inputValue: $inputValueRed)
                    .tint(.red)
                
                ColorSliderView(sliderValue: $sliderValueGreen, inputValue: $inputValueGreen)
                    .tint(.green)
                
                ColorSliderView(sliderValue: $sliderValueBlue, inputValue: $inputValueBlue)
                
                Spacer()
            }
            .padding()
        }
    }
    
    private func hideKeyBoard() {
        UIApplication
            .shared
            .sendAction(#selector(UIResponder
                .resignFirstResponder), to: nil, from: nil, for: nil)
    }
    
    private func validateValues() {
        guard (0...255).contains(Double(inputValueRed) ?? 0),
              (0...255).contains(Double(inputValueGreen) ?? 0),
              (0...255).contains(Double(inputValueBlue) ?? 0) else {
            isAlertPresented = true
            inputValueRed = String(format: "%.0f", sliderValueRed)
            inputValueGreen = String(format: "%.0f", sliderValueGreen)
            inputValueBlue = String(format: "%.0f", sliderValueBlue)
            return
        }
    }
    
    private func setSliderValues() {
        guard let valueRed = Double(inputValueRed),
              let valueGreen = Double(inputValueGreen),
              let valueBlue = Double(inputValueBlue) else {
            return
        }
        sliderValueRed = valueRed
        sliderValueGreen = valueGreen
        sliderValueBlue = valueBlue
    }
}

#Preview {
    ContentView()
}

struct ColorSliderView: View {
    @Binding var sliderValue: Double
    @Binding var inputValue: String
    
    var body: some View {
        HStack {
            Text(lround(sliderValue).formatted()).foregroundStyle(.white)
            
            Slider(value: $sliderValue, in: 0...255, step: 1)
            
            TextField("", text: $inputValue, onEditingChanged: { _ in
            }, onCommit: {
                if let value = Double(inputValue) {
                    sliderValue = value
                }
            })
            .keyboardType(.numberPad)
            .multilineTextAlignment(.center)
            .frame(width: 50, height: 30)
            .background(.white)
            .overlay(
                RoundedRectangle(cornerRadius: 4)
                    .stroke(lineWidth: 2)
                    .foregroundStyle(.blue)
            )
            .onAppear {
                inputValue = String(format: "%.0f", sliderValue)
            }
        }
        .onChange(of: sliderValue) { _, newValue in
            inputValue = "\(Int(newValue))"
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
