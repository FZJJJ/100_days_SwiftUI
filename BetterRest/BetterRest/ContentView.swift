//
//  ContentView.swift
//  BetterRest
//
//  Created by FZJ on 2024/4/17.
//

import CoreML
import SwiftUI

struct ContentView: View {
    @State private var wakeUp = defaultWakeUpTime
    @State private var sleepAmount = 8.0
    @State private var coffeeAmount = 0
    
    @State private var alertTitle = ""
    @State private var alertMessage = ""
    @State private var showingAlert = false
    
    static var defaultWakeUpTime: Date {
        var components = DateComponents()
        components.hour = 7
        components.minute = 0
        return Calendar.current.date(from: components) ?? Date.now
    }
    
    var body: some View {
        NavigationStack {
            Form {
                Section("Wake up time") {
                    Text("When do you want to wake up?")
                    DatePicker("Enter your time", selection: $wakeUp, displayedComponents:
                            .hourAndMinute)
                    .labelsHidden()
                }
                Section("sleep amount") {
                    Text("How long do you want to sleep")
                    Stepper("\(sleepAmount.formatted()) hours", value: $sleepAmount, in: 5...12, step: 0.5)
                }
                Section("coffee takein") {
                    Text("The coffee takein")
//                    Stepper("^[\(coffeeAmount) cup](inflect:true)", value: $coffeeAmount, step: 1)
                    Picker("coffee takein", selection: $coffeeAmount) {
                        ForEach(0..<11) {
                            Text("^[\($0) cup](inflect:true)")
                        }
                    }
                }
            }
            .font(.headline)
            .navigationTitle("BetterRest")
            .toolbar {
                Button("calculate", action: calculateBedTime)
                    .buttonStyle(BorderedButtonStyle())
            }
            .alert(alertTitle, isPresented: $showingAlert) {
                Button("ok"){}
            } message: {
                Text(alertMessage)
            }
        }
    }
    func calculateBedTime () {
        do {
            let config = MLModelConfiguration()
            let model = try SleepCalculator(configuration: config)
            
            let components = Calendar.current.dateComponents([.hour, .minute], from: wakeUp)
            let hour = (components.hour ?? 0) * 3600
            let minute = (components.minute ?? 0) * 60
            
            let prediction = try model.prediction(wake: Double(hour + minute), estimatedSleep: sleepAmount, coffee: Double(coffeeAmount))
            let sleepTime = wakeUp - prediction.actualSleep
            
            alertTitle = "Your predicted sleep time is..."
            alertMessage = sleepTime.formatted(date: .omitted, time: .shortened)
            
        } catch {
            alertTitle = "Error!"
            alertMessage = "There's something wrong"
        }
        showingAlert = true
    }
}

#Preview {
    ContentView()
}
