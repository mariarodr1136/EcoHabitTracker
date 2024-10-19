//
//  ChallengesViewModel.swift
//  EcoHabitTracker
//
//  Created by Maria Rodriguez on 10/19/24.
//


import SwiftUI

class ChallengesViewModel: ObservableObject {
    @Published var challenges: [ChallengeModel] = sampleChallenges
    
    func startChallenge(_ challenge: ChallengeModel) {
        if let index = challenges.firstIndex(where: { $0.id == challenge.id }) {
            challenges[index].isStarted = true
        }
    }
    
    var activeChallenges: [ChallengeModel] {
        challenges.filter { $0.isStarted }
    }
}