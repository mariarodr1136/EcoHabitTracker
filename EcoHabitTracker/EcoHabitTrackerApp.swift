//
//  EcoHabitTrackerApp.swift
//  EcoHabitTracker
//
//  Created by Maria Rodriguez on 10/12/24.
//

import SwiftUI

// Main Application
@main
struct EcoHabitTrackerApp: App {
    @StateObject private var viewModel = ChallengesViewModel() // Initialize the ViewModel

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environmentObject(viewModel) // Inject the ViewModel into the environment
        }
    }
}
