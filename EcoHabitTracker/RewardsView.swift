//
//  RewardsView.swift
//  EcoHabitTracker
//
//  Created by Maria Rodriguez on 10/21/24.
//


import SwiftUI

struct RewardsView: View {
    @EnvironmentObject var viewModel: ChallengesViewModel

    var body: some View {
        VStack {
            Image(systemName: "trophy.fill")
                .resizable()
                .scaledToFit()
                .foregroundColor(.yellow)
                .frame(width: 40, height: 40)

            Text("Your Rewards")
                .font(.largeTitle)
                .bold()

            Text("Current Points: \(viewModel.points)")
                .font(.subheadline)

            VStack(alignment: .leading, spacing: 10) {
                Text("How to Earn Points:")
                    .font(.headline)
                    .padding(.top, 20)

                Text("• Complete challenges")
                Text("• Build sustainable habits")
                Text("• Help save the planet!")
            }
            .padding(.top, 20)
            .padding(.horizontal, 30)

            Spacer()

            VStack {
                Image(systemName: "leaf.fill")
                    .resizable()
                    .scaledToFit()
                    .frame(height: 50)
                    .foregroundColor(Color.green.opacity(0.7))
                
                Text("Keep earning points!")
                    .font(.headline)
                    .multilineTextAlignment(.center)
                    .padding(.top, 5)

                Text("Every eco-friendly action you take helps!")
                    .font(.body)
                    .multilineTextAlignment(.center)
                    .padding(.bottom, 20)
            }
            .padding()
            .background(Color.white)
            .cornerRadius(15)
            .shadow(color: .gray.opacity(0.5), radius: 10, x: 0, y: 5)
            .overlay(
                RoundedRectangle(cornerRadius: 15)
                    .stroke(Color.green, lineWidth: 1)
            )
            .padding(.horizontal, 30)

            Spacer()
        }
        .padding(.top, 20)
    }
}

struct RewardsView_Previews: PreviewProvider {
    static var previews: some View {
        RewardsView()
            .environmentObject(ChallengesViewModel())
    }
}
