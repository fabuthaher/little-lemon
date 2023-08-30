//
//  Home.swift
//  little-lemon-capstone
//
//  Created by pwc on 28/08/2023.
//

import SwiftUI

struct HomeView: View {
    let persistence = PersistenceController.shared

    var body: some View {
        TabView {
            MenuView()
                .environment(\.managedObjectContext, persistence.container.viewContext)
                .tabItem {
                    Label("Menu", systemImage: "list.dash")
                }
            
            UserProfileView() // Initialize UserProfileView
                .tabItem {
                    Label("Profile", systemImage: "square.and.pencil")
                }
        } .navigationBarBackButtonHidden(true)
        
    }
}

struct Home_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
    }
}
