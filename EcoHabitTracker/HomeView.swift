// HomeView.swift
// EcoHabitTracker
//
// Created by Maria Rodriguez on 10/19/24.
//

import SwiftUI

struct HomeView: View {
    @EnvironmentObject var viewModel: ChallengesViewModel
    @State private var selectedChallenge: ChallengeModel? = nil
    @State private var showModal: Bool = false
    
    // Array of tips
    let tips = [
        "Turn off lights when you leave a room",
        "Use a reusable water bottle instead of buying plastic bottles",
        "Take shorter showers to conserve water",
        "Use public transportation or carpool when possible",
        "Recycle paper, plastic, and glass",
        "Use energy-efficient light bulbs",
        "Unplug electronics when not in use",
        "Start a compost bin for food scraps",
        "Use cloth bags instead of plastic bags for shopping",
        "Plant trees or start a small garden"
    ]
    
    // Select a random tip
    var randomTip: String {
        tips.randomElement() ?? "Stay eco-friendly!"
    }

    var body: some View {
        VStack(spacing: 0) {
            Text("Welcome to EcoHabit Tracker!")
                .font(.title3)
                .padding(.top, 13)

            // Display total points
            Text("Your Points: \(viewModel.points)") // Display points
                .font(.headline)
                .padding(.top, 10)

            Text("Completed Challenges:")
                .font(.title2)
                .padding(.top, 20)

            // Display active challenges
            ScrollView {
                VStack(spacing: 10) {
                    ForEach(viewModel.activeChallenges) { challenge in
                        Button(action: {
                            selectedChallenge = challenge
                            showModal.toggle()
                        }) {
                            ChallengeCard(challenge: challenge)
                        }
                    }
                }
                .padding()
            }
            .padding(.top, 10)

            // Tip of the Day section
            Text("Tip of the Day:")
                .font(.title2)
                .padding(.top, -20)
            
            Text(randomTip) // Display random tip
                .font(.body)
                .padding(.all, 10)
                .background(Color.green.opacity(0.1)) // Optional background color for emphasis
                .cornerRadius(10)
                .padding(.horizontal)
        }
        .padding(.horizontal)
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .sheet(item: $selectedChallenge) { challenge in
            ChallengeDetailView(challenge: challenge) { startedChallenge in
                viewModel.startChallenge(startedChallenge)
            }
        }
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
            .environmentObject(ChallengesViewModel()) // Provide an empty ChallengesViewModel
    }
}
