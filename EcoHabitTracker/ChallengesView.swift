//
//  ChallengesView.swift
//  EcoHabitTracker
//
//  Created by Maria Rodriguez on 10/18/24.
//

import SwiftUI

struct ChallengesView: View {
    @State private var selectedChallenge: ChallengeModel? = nil
    @State private var showModal: Bool = false
    @State private var selectedCategory: ChallengeCategory = .all

    var body: some View {
        NavigationView {
            VStack {
                // Horizontally scrolling tab view with custom styles
                ScrollView(.horizontal, showsIndicators: false) {
                    HStack(spacing: 16) {
                        // Loop through all challenge categories
                        ForEach(ChallengeCategory.allCases, id: \.self) { category in
                            Text(category.rawValue)
                                .padding(.vertical, 10) // Add padding for vertical space
                                .padding(.horizontal, 20) // Add padding for horizontal space
                                .background(selectedCategory == category ? Color.green : Color.gray.opacity(0.2))
                                .foregroundColor(.white)
                                .clipShape(Capsule()) // Make the tabs "bubbly"
                                .onTapGesture {
                                    // Update the selected category when a tab is tapped
                                    selectedCategory = category
                                }
                        }
                    }
                    .padding()
                }
                
                ScrollView {
                    VStack(spacing: 16) {
                        // Filter and display challenges based on the selected category
                        ForEach(filteredChallenges) { challenge in
                            Button(action: {
                                // Set the selected challenge and show the modal when clicked
                                selectedChallenge = challenge
                                showModal.toggle()
                            }) {
                                ChallengeCard(challenge: challenge)
                            }
                            .sheet(isPresented: $showModal) {
                                // Show the challenge details in a modal when the challenge is selected
                                if let challenge = selectedChallenge {
                                    ChallengeDetailView(challenge: challenge, showModal: $showModal)
                                        .presentationDetents([.large, .large])
                                        .presentationDragIndicator(.visible)
                                }
                            }
                        }
                    }
                    .padding()
                }
            }
            .navigationBarTitle("Challenges", displayMode: .inline)
        }
    }
    
    // Computed property to filter challenges based on the selected category
    var filteredChallenges: [ChallengeModel] {
        if selectedCategory == .all {
            return sampleChallenges
        } else {
            return sampleChallenges.filter { $0.category == selectedCategory }
        }
    }
}

struct ChallengeCard: View {
    let challenge: ChallengeModel
    
    var body: some View {
        VStack(spacing: 0) {
            // Image section for the challenge card
            ZStack(alignment: .bottom) {
                if challenge.isSystemImage {
                    Image(systemName: challenge.imageName)
                        .resizable()
                        .scaledToFill()
                        .frame(height: 120)
                        .clipped()
                } else {
                    Image(challenge.imageName)
                        .resizable()
                        .scaledToFill()
                        .frame(height: 120)
                        .clipped()
                }
            }
            
            // Title section for the challenge card
            VStack(spacing: 0) {
                Divider()
                    .background(Color.white)
                    .frame(height: 2)
                
                Text(challenge.title)
                    .font(.headline)
                    .padding(.vertical, 8)
                    .frame(maxWidth: .infinity)
                    .background(Color.white)
                    .foregroundColor(.black)
            }
        }
        .background(Color.white)
        .clipShape(RoundedRectangle(cornerRadius: 15))
        .overlay(
            RoundedRectangle(cornerRadius: 15)
                .stroke(Color.white, lineWidth: 0.5)
        )
        .shadow(radius: 5)
        .frame(height: 150)
        .padding(.horizontal)
    }
}

struct ChallengeDetailView: View {
    let challenge: ChallengeModel
    @Binding var showModal: Bool
    
    var body: some View {
        VStack {
            ScrollView {
                VStack(alignment: .leading, spacing: 16) {
                    // Image for the challenge detail view
                    Image(challenge.imageName)
                        .resizable()
                        .scaledToFit()
                        .frame(height: 200)
                        .clipped()
                    
                    // Title and description for the challenge detail view
                    Text(challenge.title)
                        .font(.largeTitle)
                        .bold()
                    
                    Text("Details about \(challenge.title)...")
                        .font(.body)
                    
                    // Add any additional information or views specific to each challenge here
                }
                .padding()
            }
        }
        .background(Color.white)
        .ignoresSafeArea()
    }
}

// Enum to define challenge categories
enum ChallengeCategory: String, CaseIterable {
    case all = "All"
    case water = "Water"
    case energy = "Energy"
    case recycling = "Recycling"
    case transportation = "Transportation"
    case nature = "Nature"
}

// Updated sample data with categories
let sampleChallenges = [
    ChallengeModel(imageName: "reusablebags", title: "Use Reusable Bags", isSystemImage: false, category: .recycling),
    ChallengeModel(imageName: "conservewater", title: "Conserve Water", isSystemImage: false, category: .water),
    ChallengeModel(imageName: "gosolar", title: "Go Solar", isSystemImage: false, category: .energy),
    ChallengeModel(imageName: "saveelectricity", title: "Save Electricity", isSystemImage: false, category: .energy),
    ChallengeModel(imageName: "carpool", title: "Carpool More Often", isSystemImage: false, category: .transportation),
    ChallengeModel(imageName: "recyclewaste", title: "Recycle Waste", isSystemImage: false, category: .recycling),
    ChallengeModel(imageName: "plantatree", title: "Plant a Tree", isSystemImage: false, category: .nature),
    ChallengeModel(imageName: "noplastic", title: "Avoid Single-Use Plastics", isSystemImage: false, category: .recycling)
]

// ChallengeModel struct to define the properties of each challenge
struct ChallengeModel: Identifiable {
    let id = UUID()
    let imageName: String
    let title: String
    let isSystemImage: Bool
    let category: ChallengeCategory
}
