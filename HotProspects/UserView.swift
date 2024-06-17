//
//  UserView.swift
//  HotProspects
//
//  Created by FZJ on 2024/6/17.
//

import SwiftUI

struct UserView: View {
    
    let filter: FilterType
    
    @State private var sortDescrptors: [SortDescriptor<Prospect>] = []
    var body: some View {
        NavigationStack {
            ProspectView(filter: filter,sortDescriptors: sortDescrptors)
                .toolbar {
                    ToolbarItem(placement: .topBarTrailing) {
                        Menu("Sort", systemImage: "arrow.up.arrow.down") {
                            Picker("Sorting", selection: $sortDescrptors) {
                                Text("Sort by name")
                                    .tag([SortDescriptor(\Prospect.name)])
                                
                                Text("Sort by recent")
                                    .tag([] as [SortDescriptor<Prospect>])
                                
                            }
                            
                        }
                    }
                }
        }
    }
}

#Preview {
    UserView(filter: .none)
}
