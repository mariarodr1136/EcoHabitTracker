//
//  ContentView.swift
//  EcoHabitTracker
//
//  Created by Maria Rodriguez on 10/12/24.
//

import SwiftUI

struct ContentView: View {
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
    }
}

// Sample Views for each tab
struct HomeView: View {
    var body: some View {
        Text("Welcome to EcoHabit Tracker")
            .font(.largeTitle)
            .padding()
    }
}

struct TipsView: View {
    var body: some View {
        Text("Sustainable Tips")
            .font(.largeTitle)
            .padding()
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}