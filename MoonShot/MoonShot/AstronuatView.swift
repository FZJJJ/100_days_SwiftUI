//
//  AstronuatView.swift
//  MoonShot
//
//  Created by FZJ on 2024/4/29.
//

import SwiftUI

struct AstronuatView: View {
    let astronaut: Astronaut
    
    var body: some View {
        ScrollView {
            VStack {
                Image(astronaut.id)
                    .resizable()
                    .scaledToFit()
                
                Text(astronaut.description)
                    .padding()
            }
        }
        .background(.darkBackground)
        .navigationTitle(astronaut.name)
        .navigationBarTitleDisplayMode(.inline)
    }
}

#Preview {
    let astronauts: [String: Astronaut] = Bundle.main.decode("astronauts.json")
    return AstronuatView(astronaut: astronauts["aldrin"]!)
        .preferredColorScheme(.dark)
}
