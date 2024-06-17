//
//  EditProspectView.swift
//  HotProspects
//
//  Created by FZJ on 2024/6/17.
//

import SwiftData
import SwiftUI

struct EditProspectView: View {
    @Bindable var prospect: Prospect
    
    var body: some View {
        NavigationStack {
            VStack {
                Form {
                    TextField("name", text: $prospect.name)
                    TextField("emailAddress", text: $prospect.emailAddress)
                    Toggle("Contacted?", isOn: $prospect.isContacted)
                }
            }
            .navigationTitle("Prospect Details")
        }
    }
}

#Preview {
    EditProspectView(prospect: Prospect(name: "fzj", emailAddress: "w2", isContacted: true))
}
