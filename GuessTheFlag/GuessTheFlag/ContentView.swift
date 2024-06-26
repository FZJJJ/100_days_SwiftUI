//
//  ContentView.swift
//  GuessTheFlag
//
//  Created by FZJ on 2024/4/12.
//

import SwiftUI

struct FlagImage: ViewModifier {
    var text: String
    
    func body(content: Content) -> some View {
        Image(text)
            .clipShape(.capsule(style: .circular))
            .shadow(radius: 10)
    }
}

extension View {
    func FlagImaged(text: String) -> some View {
        modifier(FlagImage(text: text))
    }
}


struct ContentView: View {
    @State private var countries = ["estonia", "germany", "us", "uk", "ireland", "poland", "russia", "spain", "france", "monaco", "italy"].shuffled()
    
    @State private var correctAnswer = Int.random(in: 0...2)
    @State private var showingScore = false
    @State private var showingGameOver = false
    @State private var scoreTitle = ""
    @State private var score = 0
    @State private var round = 0
    @State private var flagsRotation = [false, false, false]
    @State private var flagsFadeOut = [false, false, false]

    
    let gameRound = 3
    var body: some View {
        ZStack {
            RadialGradient(stops:[
                .init(color: .mint, location: 0.3),
                .init(color: .red, location: 0.3)
            ],center: .top,startRadius: 200, endRadius: 600)
            .ignoresSafeArea()
            
            VStack {
                Spacer()
                
                Text("Guess the Flag")
                    .foregroundStyle(.white)
                    .font(.largeTitle.weight(.bold))
                
                VStack(spacing: 30) {
                    VStack {
                        Text("Tap the flag of")
                            .foregroundStyle(.secondary)
                            .font(.subheadline.weight(.bold))
                        Text(countries[correctAnswer])
                            .foregroundStyle(.black)
                            .font(.largeTitle.weight(.semibold))
                    }
                    
                    ForEach(0..<3) {number in
                        Button {
                            flagTapped(number)
                            animation(number)
                        } label: {
                            FlagImaged(text: countries[number])
                        }
                        .rotation3DEffect(flagsRotation[number] ? .degrees(360) : .degrees(0), axis: (x:0, y:1, z:0))
                        .animation(.linear(duration: 0.8), value: flagsRotation)
                        .opacity(flagsFadeOut[number] ? 0.1 : 1)
                        .animation(.easeInOut(duration: 0.8), value: flagsFadeOut)
                    }
                }
                .frame(maxWidth: .infinity)
                .padding(.vertical, 20)
                .background(.regularMaterial)
                .clipShape(.rect(cornerRadius: 20))
                .padding(30)
                
                Spacer()
                
                Text("Your score is \(score)")
                    .foregroundStyle(.white)
                    .font(.title.bold())
                
                Spacer()
            }
        }
        .alert(scoreTitle, isPresented: $showingScore) {
            Button("Continue", action: askQuestion)
        } message: {
            Text("Your score is \(score)")
        }
        .alert("Game over!", isPresented: $showingGameOver) {
            Button("Restart", action: reset)
        } message: {
            Text("Your final score is \(score)")
        }
    }
    
    func flagTapped (_ number: Int) {
        if number == correctAnswer {
            scoreTitle = "Correct!"
            score += 1
        } else {
            scoreTitle = "Wrong! It's \(countries[correctAnswer]) flag!"
        }
        round += 1
        if(round < gameRound) {
            showingScore = true
        } else {
            showingGameOver = true
        }
    }
    
    func animation(_ num: Int) {
        let array = [0, 1, 2]
        for index in array.indices {
            if index == num {
                flagsRotation[index] = true
            } else {
                flagsFadeOut[index] = true
            }
        }
    }
    
    func askQuestion () {
        countries.shuffle()
        correctAnswer = Int.random(in: 0...2)
        flagsRotation = [false, false, false]
        flagsFadeOut = [false, false, false]
    }
    
    func reset() {
        countries.shuffle()
        correctAnswer = Int.random(in: 0...2)
        showingGameOver = false
        round = 0
        score = 0
        flagsRotation = [false, false, false]
        flagsFadeOut = [false, false, false]
    }
}

#Preview {
    ContentView()
}
