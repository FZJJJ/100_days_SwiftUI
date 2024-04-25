//
//  ContentView.swift
//  Edutainment
//
//  Created by FZJ on 2024/4/24.
//

import SwiftUI

struct ContentView: View {
    
    @State private var numberRange = 5
    @State private var questionNumber = 0
    @State private var questionNumbers = [5, 10, 15, 20]
    @State private var ans = 0
    @State private var score = 0
    @State private var currentIndex = 0
    @State private var questions = [String]()
    @State private var answers = [Int]()
    
    @State private var showingGameOver = false
    @State private var gameOverTile = ""
    @State private var gameOverMessage = ""

    struct Question {
        var num1: Int
        var num2: Int
        var ques: String {
            "\(String(self.num1)) x \(String(self.num2))"
        }
        var answer: Int {
            self.num1 * self.num2
        }
    }
    
    var body: some View {
        VStack {
            HStack {
                Text("The number range is \(numberRange)")
                Spacer()
                Stepper("Change the number range", value: $numberRange, in: 2...12)
                    .labelsHidden()
            }
            Picker("Pick the question number", selection: $questionNumber) {
                ForEach(questionNumbers, id: \.self) {
                    Text("\($0) questions")
                }
            }
            .pickerStyle(.automatic)
            
            Button("Start", action: start)
            
            List {
//                ForEach(questions, id: \.self) {
//                    Text($0)
//                }
                ForEach(questions.indices, id: \.self) { index in
                    Text(questions[index])
                        .foregroundColor(index == currentIndex ? .red : .primary)
                }
            }
            TextField("Enter your answer", value: $ans, format: .number)
                .keyboardType(.numberPad)
            HStack {
                Button("confirm", action: enter)
                    .disabled(showingGameOver)
                Button("restart", action: restart)
            }
            Text("Your current score is \(score)")
            
        }
        .padding()
        .alert(gameOverTile, isPresented: $showingGameOver) {
            Button("ok"){}
        } message: {
            Text(gameOverMessage)
        }
    }
    func start(){
        questions.removeAll()
        answers.removeAll()
        for _ in 0..<questionNumber {
            let q = Question(num1: Int.random(in: 0...numberRange), num2: Int.random(in: 0...numberRange))
            questions.append(q.ques)
            answers.append(q.answer)
        }
    }
    func enter() {
        if currentIndex < questionNumber-1 {
            if ans == answers[currentIndex] {
                score += 1
            }
            currentIndex += 1
        } else {
            if ans == answers[currentIndex] {
                score += 1
            }
            showingGameOver = true
            gameOverTile = "Game over!"
            gameOverMessage = "Please press restart to paly again"
            currentIndex = 0
        }
    }
    
    func restart() {
        questions.removeAll()
        answers.removeAll()
        start()
        showingGameOver = false
        currentIndex = 0
        score = 0
    }
}

#Preview {
    ContentView()
}
