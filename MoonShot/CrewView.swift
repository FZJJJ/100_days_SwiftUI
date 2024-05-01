//
//  CrewView.swift
//  MoonShot
//
//  Created by FZJ on 2024/5/1.
//

import SwiftUI

struct CrewView: View {
    
    struct CrewNumber {
        let role: String
        let astronaut: Astronaut
    }
    
    let crew: [CrewNumber]
    let mission: Mission
    
    init(mission: Mission, astronauts: [String: Astronaut]) {
        self.mission = mission
        self.crew = mission.crew.map { member in
            if let astronaut = astronauts[member.name] {
                return CrewNumber(role: member.role, astronaut: astronaut)
            } else {
                fatalError("Missing \(member.name)")
            }
        }
    }
    var body: some View {
        ScrollView(.horizontal, showsIndicators: false) {
            HStack {
                ForEach(crew, id:\.role) { crewMember in
                    NavigationLink {
                        AstronuatView(astronaut: crewMember.astronaut)
                    } label: {
                        HStack {
                            Image(crewMember.astronaut.id)
                                .resizable()
                                .frame(width: 104, height: 72)
                                .clipShape(.capsule)
                                .overlay(
                                    Capsule()
                                        .strokeBorder(.white, lineWidth: 1)
                                )
                            
                            VStack(alignment: .leading) {
                                Text(crewMember.astronaut.name)
                                    .foregroundStyle(.white)
                                    .font(.headline)
                                Text(crewMember.role)
                                    .foregroundStyle(.white.opacity(0.5))
                            }
                        }
                        .padding(.horizontal)
                    }
                }
            }
        }
    }
}

#Preview {
    let missions: [Mission] = Bundle.main.decode("missions.json")
    let astronauts: [String: Astronaut] = Bundle.main.decode("astronauts.json")
    return CrewView(mission: missions[1], astronauts: astronauts)
        .preferredColorScheme(.dark)
}
