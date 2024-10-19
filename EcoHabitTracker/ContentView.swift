//
//  ContentView.swift
//  EcoHabitTracker
//
//  Created by Maria Rodriguez on 10/12/24.
//

import SwiftUI

struct ContentView: View {
    @StateObject private var challengesViewModel = ChallengesViewModel()
    
    var body: some View {
        TabView {
            // Home Tab
            HomeView()
                .tabItem {
                    Image(systemName: "house.fill")
                    Text("Home")
                }

            // Challenges Tab
            ChallengesView()
                .tabItem {
                    Image(systemName: "star.fill")
                    Text("Challenges")
                }

            // Tips Tab
            TipsView()
                .tabItem {
                    Image(systemName: "lightbulb.fill")
                    Text("Tips")
                }
        }
        .environmentObject(challengesViewModel)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
            .environmentObject(ChallengesViewModel())
    }
}
