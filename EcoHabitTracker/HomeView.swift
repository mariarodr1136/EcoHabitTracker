//
//  HomeView.swift
//  EcoHabitTracker
//
//  Created by Maria Rodriguez on 10/19/24.
//

import SwiftUI

struct HomeView: View {
    @EnvironmentObject var viewModel: ChallengesViewModel
    @State private var selectedChallenge: ChallengeModel? = nil
    @State private var showModal: Bool = false

    var body: some View {
        VStack(spacing: 0) {
            Text("Welcome to EcoHabit Tracker!")
                .font(.largeTitle)
                .padding(.top, 10)

            Text("Active Challenges")
                .font(.title2)
                .padding(.top, 20)

            // Display active challenges
            ScrollView {
                VStack(spacing: 16) {
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
            .environmentObject(ChallengesViewModel())
    }
}
