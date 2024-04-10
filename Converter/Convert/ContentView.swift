//
//  ContentView.swift
//  Convert
//
//  Created by FZJ on 2024/4/10.
//

import SwiftUI

struct ContentView: View {
    @State private var inputUnit = "meter"
    @State private var outputUnit = "meter"
    @State private var inputLength = 0.0
    
    private var outputLength: Double {
        if inputUnit == "meter" && outputUnit == "kilometer" {
            return inputLength * 0.001
        }
        else if inputUnit == "meter" && outputUnit == "inch" {
            return inputLength * 3.28084
        }
        else if inputUnit == "meter" && outputUnit == "yard" {
            return inputLength * 1.0936
        }
        else if inputUnit == "meter" && outputUnit == "mile" {
            return inputLength * 0.000621
        }
        else if inputUnit == "kilometer" && outputUnit == "meter" {
            return inputLength * 1000
        }
        else if inputUnit == "kilometer" && outputUnit == "inch" {
            return inputLength * 1000 * 3.28084
        }
        else if inputUnit == "kilometer" && outputUnit == "yard" {
            return inputLength * 1000 * 1.0936
        }
        else if inputUnit == "kilometer" && outputUnit == "mile" {
            return inputLength * 1000 * 0.000621
        }
        else if inputUnit == "inch" && outputUnit == "meter" {
            return inputLength / 3.28084
        }
        else if inputUnit == "inch" && outputUnit == "kilometer" {
            return inputLength / 3280.84
        }
        else if inputUnit == "inch" && outputUnit == "yard" {
            return inputLength / 3.28084 * 1.0936
        }
        else if inputUnit == "inch" && outputUnit == "mile" {
            return inputLength / 3.28084 * 0.000621
        }
        else if inputUnit == "yard" && outputUnit == "meter" {
            return inputLength / 1.0936
        }
        else if inputUnit == "yard" && outputUnit == "kilometer" {
            return inputLength / 1093.6
        }
        else if inputUnit == "yard" && outputUnit == "inch" {
            return inputLength / 1.0936 * 3.28084
        }
        else if inputUnit == "yard" && outputUnit == "mile" {
            return inputLength / 1.0936 * 0.000621
        }
        else if inputUnit == "mile" && outputUnit == "meter" {
            return inputLength / 0.000621
        }
        else if inputUnit == "mile" && outputUnit == "kilometer" {
            return inputLength / 0.621
        }
        else if inputUnit == "mile" && outputUnit == "inch" {
            return inputLength / 0.000621 * 3.28084
        }
        else if inputUnit == "mile" && outputUnit == "yard" {
            return inputLength / 0.000621 * 1.0936
        }
        else {
            return inputLength
        }
    }
    
    private let units = ["meter", "kilometer", "inch", "yard", "mile"]
    
    var body: some View {
        NavigationStack {
            Form {
                Section("select input unit") {
                    Picker("InputUnit", selection: $inputUnit) {
                        ForEach(units, id: \.self) {
                            Text($0)
                        }
                    }
                    Picker("OutputUnit", selection: $outputUnit) {
                        ForEach(units, id: \.self) {
                            Text($0)
                        }
                    }
                }
                
                Section("enter your length value") {
                    TextField("input length", value: $inputLength, format: .number)
                        .keyboardType(.decimalPad)
                }
                
                Section("converted length") {
                    Text(outputLength, format: .number)
                }
            }
            .navigationTitle("Length Converter")
            .navigationBarTitleDisplayMode(.inline)
        }
    }
}

#Preview {
    ContentView()
}
