//
//  ContentView.swift
//  WordScramble
//
//  Created by FZJ on 2024/4/20.
//

import SwiftUI

struct ContentView: View {
    @State private var usedWords = [String]()
    @State private var newWord = ""
    @State private var rootWord = ""
    
    @State private var errorTitle = ""
    @State private var errorText = ""
    @State private var showingError = false
    
    @State private var score = 0.0
    
    var body: some View {
        NavigationStack {
            VStack {
                HStack {
                    Text("Your score is")
                        .font(.headline)
                    Text(score, format: .number)
                        .font(.title)
                }
                List {
                    Section {
                        TextField("Enter your word", text: $newWord)
                            .textInputAutocapitalization(.never)
                    }
                    
                    Section {
                        ForEach(usedWords, id: \.self) { word in
                            HStack {
                                Image(systemName: "\(word.count).circle")
                                Text(word)
                            }
                        }
                    }
                    .listStyle(.sidebar)
                }
                .navigationTitle(rootWord)
                .onSubmit(addNewWord)
                .onAppear(perform:startGame)
                .alert(errorTitle, isPresented: $showingError) {
                    Button("ok"){}
                } message: {
                    Text(errorText)
                }
                .toolbar {
                    Button("restart", action: restart)
                }

            }
        }
    }
    
    func isUnique(word:String) -> Bool {
        !usedWords.contains(word)
    }
    
    func isPossible(word:String) -> Bool {
        var tempWord = rootWord
        for letter in word {
            if let pos = tempWord.firstIndex(of: letter) {
                tempWord.remove(at: pos)
            } else {
                return false
            }
        }
        return true
    }
    
    func isReal(word: String) -> Bool {
        let checker = UITextChecker()
        let range = NSRange(location: 0, length: word.utf16.count)
        let misspelledRange = checker.rangeOfMisspelledWord(in: word, range: range, startingAt: 0, wrap: false, language: "en")
        return misspelledRange.location == NSNotFound
    }
    
    func lengthConstrain(word: String) -> Bool{
        return (word.count > 2 && word.count < rootWord.count)
    }
    
    func addNewWord () {
        let word = newWord.lowercased().trimmingCharacters(in: .whitespacesAndNewlines)
        guard word.count > 0 else {return}
        guard isUnique(word: word) else {
            error(title: "word used already", text: "Pleas choose another word")
            return
        }
        guard isPossible(word: word) else {
            error(title: "word isn't in the rootword", text: "Please choose carefully")
            return
        }
        guard isReal(word: word) else {
            error(title: "word isn't exist", text: "Please choose a real word")
            return
        }
        guard lengthConstrain(word: word) else {
            error(title: "word's length is not good", text: "Please use 3 and more letters and can not use the root word")
            return
        }
        withAnimation {
            usedWords.insert(word, at: 0)
        }
        score += 2.0 + 0.5 * Double(word.count)
        newWord = ""
    }
    
    func error(title:String, text:String) {
        errorTitle = title
        errorText = text
        showingError = true
    }
    
    func startGame() {
        if let startWordsUrl = Bundle.main.url(forResource: "start", withExtension: "txt") {
            if let startWords = try? String(contentsOf: startWordsUrl) {
                let allWords = startWords.components(separatedBy: "\n")
                rootWord = allWords.randomElement() ?? "silkworm"
                return
            }
        }
       fatalError("could not load start.txt from bundle.")
    }
    
    func restart() {
        usedWords.removeAll()
        startGame()
        score = 0
    }
}

#Preview {
    ContentView()
}
