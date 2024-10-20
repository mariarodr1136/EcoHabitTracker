//
//  ChallengesViewModel.swift
//  EcoHabitTracker
//
//  Created by Maria Rodriguez on 10/19/24.
//


import SwiftUI
import Combine

class ChallengesViewModel: ObservableObject {
    @Published var activeChallenges: [ChallengeModel] = []
    @Published var points: Int = 0
    @Published var challenges: [ChallengeModel] = sampleChallenges
    
    func startChallenge(_ challenge: ChallengeModel) {
        if let index = challenges.firstIndex(where: { $0.id == challenge.id }) {
            challenges[index].isStarted = true
            
            // Check if the challenge is completed and add points accordingly
            if challenge.isStarted {
                points += 50 // Add points when a challenge is completed
            }
        }
        
        // Update the activeChallenges property
        activeChallenges = challenges.filter { $0.isStarted }
    }
}
