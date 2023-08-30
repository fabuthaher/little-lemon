//
//  little_lemon_capstoneApp.swift
//  little-lemon-capstone
//
//  Created by pwc on 26/08/2023.
//

import SwiftUI

@main
struct little_lemon_capstoneApp: App {
    let persistenceController = PersistenceController.shared

    var body: some Scene {
        WindowGroup {
            OnboardingView().environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}
