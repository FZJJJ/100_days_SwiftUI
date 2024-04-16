//
//  ContentView.swift
//  FingerGuessingGame
//
//  Created by FZJ on 2024/4/16.
//

import SwiftUI

struct ContentView: View {
    let choices = ["📄", "✊", "✂️"]
    let winChoices = ["✂️", "📄", "✊"]
    let loseChoices = ["✊", "✂️", "📄"]
    let maxRound = 3
    
    @State private var goal = Bool.random()
    @State private var choice = Int.random(in: 0...2)
    
    @State private var scoreTitle = ""
    @State private var showingScore = false
    @State private var showingGameOver = false
    @State private var score = 0
    @State private var round = 0
    
    var winOrlose: String {
        goal ? "win" : "lose"
    }

    var body: some View {
        ZStack {
            LinearGradient(colors: [.black, .white], startPoint: .top, endPoint: .bottom)
                .ignoresSafeArea()
            VStack {
                Spacer()
                VStack(spacing: 20) {
                    HStack {
                        Text("Your goal is to")
                        Text(winOrlose)
                            .foregroundColor(.red)
                            .font(.largeTitle)
                            .fontWeight(.heavy)
                    }
                    Text("The app's choice is")
                    Text(choices[choice])
                        .font(.system(size: 60))
                }
                .font(.title)
                .fontWeight(.heavy)
                .foregroundColor(.white)
                Spacer()
                
                HStack(spacing: 30){
                    ForEach(0..<3) { number in
                        Button(){
                            tapped(number)
                        } label: {
                            Text(choices[number])
                        }
                    }
                    .font(.system(size: 50))
                }
                .alert(scoreTitle, isPresented: $showingScore) {
                    Button("Continue", action: Continuer)
                } message: {
                    Text("Your score is \(score)")
                }
                .alert(scoreTitle, isPresented: $showingGameOver) {
                    Button("Restart", action: Restart)
                } message: {
                    Text("Your final score is \(score)")
                }
                
                Spacer()
                
                Text("Your current score is \(score)")
                    .font(.title)
                    .fontWeight(.bold)
                
                Spacer()
            }
        }
        
    }
    func tapped(_ num: Int) {
        round += 1
        let isCorrect = (winOrlose == "win" && choices[num] == winChoices[choice]) || (winOrlose == "lose" && choices[num] == loseChoices[choice])
        
        if round < maxRound {
            scoreTitle = isCorrect ? "Correct!" : "Wrong!"
            showingScore = true
        } else {
            scoreTitle = isCorrect ? "Correct and Game Over!" : "Wrong and Game Over!"
            showingGameOver = true
        }
        
        if isCorrect {
            score += 1
        }
    }

    func Continuer() {
        choice = Int.random(in: 0...2)
        goal = Bool.random()
        showingScore = false
    }
    func Restart() {
        score = 0
        round = 0
        choice = Int.random(in: 0...2)
        goal = Bool.random()
    }
}

#Preview {
    ContentView()
}
