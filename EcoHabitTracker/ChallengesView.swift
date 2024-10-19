//
//
//  ChallengesView.swift
//  EcoHabitTracker
//
//  Created by Maria Rodriguez on 10/18/24.
//

import SwiftUI

struct ChallengesView: View {
    @EnvironmentObject var viewModel: ChallengesViewModel
    @State private var selectedChallenge: ChallengeModel? = nil
    @State private var showModal: Bool = false
    @State private var selectedCategory: ChallengeCategory = .all

    var body: some View {
        NavigationView {
            VStack {
                // Category selection
                ScrollView(.horizontal, showsIndicators: false) {
                    HStack(spacing: 16) {
                        ForEach(ChallengeCategory.allCases, id: \.self) { category in
                            Text(category.rawValue)
                                .padding(.vertical, 10)
                                .padding(.horizontal, 20)
                                .background(selectedCategory == category ? Color.green : Color.gray.opacity(0.2))
                                .foregroundColor(.white)
                                .clipShape(Capsule())
                                .onTapGesture {
                                    selectedCategory = category
                                }
                        }
                    }
                    .padding()
                }
                
                // Challenges list
                ScrollView {
                    VStack(spacing: 16) {
                        ForEach(filteredChallenges) { challenge in
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
            }
            .navigationBarTitle("Fun Challenges", displayMode: .inline)
            .sheet(item: $selectedChallenge) { challenge in
                ChallengeDetailView(challenge: challenge) { startedChallenge in
                    viewModel.startChallenge(startedChallenge)
                }
            }
        }
    }
    
    var filteredChallenges: [ChallengeModel] {
        if selectedCategory == .all {
            return viewModel.challenges
        } else {
            return viewModel.challenges.filter { $0.category == selectedCategory }
        }
    }
}

struct ChallengeCard: View {
    let challenge: ChallengeModel
    
    var body: some View {
        VStack(spacing: 0) {
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
            
            if challenge.isStarted {
                Text("Active Challenge")
                    .foregroundColor(.white)
                    .font(.subheadline)
                    .padding(8)
                    .background(Color.gray)
                    .cornerRadius(8)
                    .padding(.top, 5)
                    .padding(.bottom, 14)
            }
        }
        .background(Color.white)
        .clipShape(RoundedRectangle(cornerRadius: 15))
        .overlay(
            RoundedRectangle(cornerRadius: 15)
                .stroke(Color.white, lineWidth: 0.5)
        )
        .shadow(radius: 5)
        .padding(.horizontal)
        .padding(.bottom, challenge.isStarted ? 16 : 8) // Add space below if active
    }
}


struct ChallengeDetailView: View {
    @Environment(\.presentationMode) var presentationMode
    @State private var challenge: ChallengeModel
    @State private var showCongratulations = false
    var onChallengeUpdated: (ChallengeModel) -> Void

    init(challenge: ChallengeModel, onChallengeUpdated: @escaping (ChallengeModel) -> Void) {
        _challenge = State(initialValue: challenge)
        self.onChallengeUpdated = onChallengeUpdated
    }

    var body: some View {
        VStack(spacing: 20) {
            ScrollView {
                VStack(spacing: 16) {
                    Image(challenge.imageName)
                        .resizable()
                        .scaledToFit()
                        .frame(height: 200)
                        .clipped()
                    
                    categoryIcon
                        .font(.system(size: 40))
                        .foregroundColor(.green)
                    
                    Text(challenge.title)
                        .font(.largeTitle)
                        .bold()
                        .multilineTextAlignment(.center)
                    
                    Text(challenge.description)
                        .font(.body)
                        .multilineTextAlignment(.center)
                    
                    Text("Why is it good for the planet?")
                        .font(.headline)
                        .padding(.top)
                        .multilineTextAlignment(.center)
                    Text(challenge.benefits)
                        .font(.body)
                        .multilineTextAlignment(.center)
                    
                    Text("Your Challenge:")
                        .font(.headline)
                        .padding(.top)
                        .multilineTextAlignment(.center)
                    Text(challenge.kidChallenge)
                        .font(.body)
                        .multilineTextAlignment(.center)
                }
                .padding()
            }
            
            Button(action: {
                challenge.isStarted = true
                onChallengeUpdated(challenge)
                showCongratulations = true
            }) {
                Text(challenge.isStarted ? "Active Challenge" : "Start My Eco Adventure!")
                    .font(.headline)
                    .foregroundColor(.white)
                    .padding()
                    .frame(maxWidth: .infinity)
                    .background(challenge.isStarted ? Color.gray : Color.green)
                    .cornerRadius(10)
            }
            .disabled(challenge.isStarted)
            .padding(.horizontal)
            .padding(.bottom, 20)
        }
        .padding(.bottom, 65) 
        .background(Color.white)
        .sheet(isPresented: $showCongratulations) {
            CongratulationsView(challengeTitle: challenge.title) {
                presentationMode.wrappedValue.dismiss()
            }
        }
        .ignoresSafeArea()
    }
    
    var categoryIcon: some View {
        switch challenge.category {
        case .water:
            return Image(systemName: "drop.fill")
        case .energy:
            return Image(systemName: "bolt.fill")
        case .recycling:
            return Image(systemName: "arrow.3.trianglepath")
        case .transportation:
            return Image(systemName: "car.fill")
        case .nature:
            return Image(systemName: "leaf.fill")
        case .all:
            return Image(systemName: "globe.americas.fill")
        }
    }
}

struct CongratulationsView: View {
    let challengeTitle: String
    let onDismiss: () -> Void
    
    var body: some View {
        VStack(spacing: 20) {
            Image(systemName: "star.fill")
                .font(.system(size: 80))
                .foregroundColor(.yellow)
            
            Text("Congratulations!")
                .font(.largeTitle)
                .bold()
            
            Text("You've started your eco adventure with the \(challengeTitle) challenge!")
                .font(.title2)
                .multilineTextAlignment(.center)
                .padding()
            
            Text("Remember, every small action counts. You're making a difference!")
                .font(.body)
                .multilineTextAlignment(.center)
                .padding()
            
            Button(action: onDismiss) {
                Text("Back to Challenges")
                    .font(.headline)
                    .foregroundColor(.white)
                    .padding()
                    .frame(maxWidth: .infinity)
                    .background(Color.green)
                    .cornerRadius(10)
            }
            .padding(.horizontal)
        }
        .padding()
        .background(Color.white)
    }
}

// ... (rest of the code remains the same)

extension Color {
    static var random: Color {
        return Color(
            red: .random(in: 0...1),
            green: .random(in: 0...1),
            blue: .random(in: 0...1)
        )
    }
}

enum ChallengeCategory: String, CaseIterable {
    case all = "All"
    case water = "Water"
    case energy = "Energy"
    case recycling = "Recycling"
    case transportation = "Transportation"
    case nature = "Nature"
}

var sampleChallenges = [
    ChallengeModel(
        imageName: "reusablebags",
        title: "Use Reusable Bags",
        isSystemImage: false,
        category: .recycling,
        description: "Plastic bags can harm animals and pollute our oceans. By using reusable bags, we can help keep our planet clean and safe for all creatures!",
        benefits: "Using reusable bags reduces plastic waste, saves energy, and protects wildlife. It's a simple way to make a big difference!",
        kidChallenge: "For one week, remember to bring your own reusable bag whenever you go shopping with your family. Count how many times you use it!"
    ),
    ChallengeModel(
        imageName: "conservewater",
        title: "Water Wizard",
        isSystemImage: false,
        category: .water,
        description: "Water is precious! By using less water, we can help save this important resource for everyone and everything on Earth.",
        benefits: "Saving water helps protect rivers and lakes, saves energy used to clean and transport water, and ensures there's enough for all living things.",
        kidChallenge: "This week, try to take shorter showers. Set a timer for 5 minutes and see if you can finish before it goes off!"
    ),
    ChallengeModel(
        imageName: "gosolar",
        title: "Solar Explorer",
        isSystemImage: false,
        category: .energy,
        description: "The sun gives us free, clean energy! Learning about solar power helps us understand how we can use this amazing resource.",
        benefits: "Solar energy is clean, renewable, and doesn't produce harmful gases. It helps fight climate change and can be used almost anywhere!",
        kidChallenge: "Build a simple solar oven using a pizza box and aluminum foil. Try to melt a marshmallow in it on a sunny day!"
    ),
    ChallengeModel(
        imageName: "saveelectricity",
        title: "Energy Detective",
        isSystemImage: false,
        category: .energy,
        description: "Saving electricity is like giving the Earth a big hug! It helps reduce pollution and conserve valuable resources.",
        benefits: "Using less electricity means we burn less fossil fuels, which helps keep our air clean and reduces climate change.",
        kidChallenge: "Become an energy detective in your home! Count how many lights and electronics you can turn off when not in use for a day."
    ),
    ChallengeModel(
        imageName: "carpool",
        title: "Carpool Captain",
        isSystemImage: false,
        category: .transportation,
        description: "Sharing rides is fun and good for the planet! It means fewer cars on the road, which helps keep our air clean.",
        benefits: "Carpooling reduces air pollution, saves fuel, and can even help make new friends! It's a great way to travel and care for the Earth.",
        kidChallenge: "Next time you go to school or an activity, try to carpool with a friend. Keep a log of how many times you carpool in a month!"
    ),
    ChallengeModel(
        imageName: "recyclewaste",
        title: "Recycling Hero",
        isSystemImage: false,
        category: .recycling,
        description: "Recycling is like giving trash a second chance to be useful! It helps save resources and reduce waste in landfills.",
        benefits: "Recycling conserves natural resources, saves energy, reduces pollution, and helps protect wildlife habitats.",
        kidChallenge: "Create a recycling station at home with different bins for paper, plastic, and metal. Help your family sort the recyclables for a week!"
    ),
    ChallengeModel(
        imageName: "plantatree",
        title: "Tree Champion",
        isSystemImage: false,
        category: .nature,
        description: "Trees are like superheroes for our planet! They clean the air, provide homes for animals, and make oxygen for us to breathe.",
        benefits: "Planting trees helps fight climate change, prevents soil erosion, provides habitat for wildlife, and makes our neighborhoods beautiful!",
        kidChallenge: "Plant a small tree or a seed in your yard or a pot. Take care of it and watch it grow over time. Name your tree!"
    ),
    ChallengeModel(
        imageName: "noplastic",
        title: "Plastic Buster",
        isSystemImage: false,
        category: .recycling,
        description: "Single-use plastics can harm animals and pollute our environment. By avoiding them, we can help keep our planet clean and safe!",
        benefits: "Reducing plastic use helps protect marine life, reduces pollution in oceans and landfills, and saves energy used to produce plastics.",
        kidChallenge: "For one week, try to avoid using single-use plastics like straws or plastic water bottles. Keep a tally of how many times you say 'No thanks!' to plastic."
    )
]

struct ChallengeModel: Identifiable {
    let id = UUID()
    let imageName: String
    let title: String
    let isSystemImage: Bool
    let category: ChallengeCategory
    let description: String
    let benefits: String
    let kidChallenge: String
    var isStarted: Bool = false // New property
}

struct ChallengesView_Previews: PreviewProvider {
    static var previews: some View {
        ChallengesView()
            .environmentObject(ChallengesViewModel())
    }
}
