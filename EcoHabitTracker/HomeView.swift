import SwiftUI

struct HomeView: View {
    @EnvironmentObject var viewModel: ChallengesViewModel
    @State private var selectedChallenge: ChallengeModel? = nil
    @State private var showModal: Bool = false
    @State private var currentChallengeIndex: Int = 0
    
    let tips = [
        "Turn off lights when leaving a room!",
        "Use a reusable water bottle!",
        "Take quicker showers to save water!",
        "Walk, bike, or carpool with friends!",
        "Recycle paper, plastic, and glass!",
        "Use energy-saving light bulbs!",
        "Unplug electronics when not using them!",
        "Start a compost for food scraps!",
        "Bring a cloth bag when shopping!",
        "Plant trees or grow a garden!"
    ]
    
    let facts = [
        "Recycling one aluminum can saves enough energy to play your favorite video game for 3 hours!",
        "Turning off the water while brushing your teeth can save enough water to fill 64 water bottles every day!",
        "Composting your fruit peels and veggie scraps helps plants grow big and strong, like superheroes for the Earth!",
        "Walking, biking, or scootering instead of driving helps keep the air fresh and clean for everyone to breathe!",
        "Recycling paper saves trees – one ton of recycled paper can save 17 big trees!",
        "Turning off the lights when you leave a room is like giving the planet a high five by saving energy!",
        "Planting a tree gives homes to animals and helps us breathe better by cleaning the air!",
        "Using a reusable water bottle can stop hundreds of plastic bottles from ending up in the ocean!",
        "If everyone picked up just one piece of trash every day, imagine how clean our neighborhoods and parks would be!"
    ]

    var randomTip: String {
        tips.randomElement() ?? "Stay eco-friendly!"
    }
    
    var randomFact: String {
        facts.randomElement() ?? "Every action counts!"
    }

    var body: some View {
        ScrollView {
            VStack(spacing: 0) {
                
                Image(systemName: "leaf.fill")
                    .resizable()
                    .scaledToFit()
                    .foregroundColor(Color.green.opacity(0.7))
                    .frame(width: 35, height: 35)
                    .padding(.top, 15)
                
                Text("Welcome To EcoHabits!")
                    .font(.title).bold()
                    .padding(.top, 15)

                VStack {
                    Image("recycle")
                        .resizable()
                        .scaledToFit()
                        .frame(height: 200)

                    Text("Be an eco-friendly hero! Take on a challenge today, build sustainable habits, and help save the earth!")
                        .font(.body)
                        .multilineTextAlignment(.center)
                        .padding()
                        .padding(.horizontal)
                }
                .padding()
                .background(Color.white)
                .cornerRadius(15)
                .shadow(color: .gray.opacity(0.5), radius: 30, x: 0, y: 5)
                .overlay(
                    RoundedRectangle(cornerRadius: 10)
                        .stroke(Color.green, lineWidth: 1)
                )
                .padding(.top, 30)

                Text("Completed Challenges:")
                    .font(.title)
                    .padding(.top, 40)
                
                Text("Your Points: \(viewModel.points)")
                    .font(.callout)
                    .padding(.top, 5)

                if !viewModel.activeChallenges.isEmpty {
                    TabView(selection: $currentChallengeIndex) {
                        ForEach(Array(viewModel.activeChallenges.enumerated()), id: \.element.id) { index, challenge in
                            ChallengeCard(challenge: challenge)
                                .onTapGesture {
                                    selectedChallenge = challenge
                                    showModal.toggle()
                                }
                                .tag(index)
                        }
                    }
                    .tabViewStyle(PageTabViewStyle(indexDisplayMode: .automatic))
                    .frame(height: 300)
                } else {
                    Text("No completed challenges yet!")
                        .font(.subheadline)
                        .foregroundColor(.secondary)
                        .padding()
                }

                // Thoughtful Tip Section
                VStack(spacing: 5) {
                    Text("Thoughtful Tip:")
                        .font(.system(size: 20))
                        .padding(.bottom, 5)
                    
                    Text(randomTip)
                        .font(.body)
                        .padding(.all, 10)
                        .background(Color.green.opacity(0.1))
                        .cornerRadius(10)
                        .padding(.horizontal)
                }
                        .padding(.bottom, 40)

                VStack {
                    Image("earthSmile")
                        .resizable()
                        .scaledToFit()
                        .frame(height: 200)

                    Text("Every little thing helps!")
                        .font(.headline)
                        .multilineTextAlignment(.center)
                        .padding(.bottom, 5)
                    
                    Text("Turn off lights, save water, and recycle to help the planet.")
                        .font(.body)
                        .multilineTextAlignment(.center)
                        .padding(.bottom, 5)
                    
                    Text("Together, we can keep Earth happy!")
                        .font(.body)
                        .multilineTextAlignment(.center)
                        .padding(.bottom, 10)
                }
                .padding()
                .background(Color.white)
                .cornerRadius(15)
                .shadow(color: .gray.opacity(0.5), radius: 10, x: 0, y: 5)
                .overlay(
                    RoundedRectangle(cornerRadius: 15)
                        .stroke(Color.green, lineWidth: 1)
                )
                .padding(.top, 10)
                
                //Did You Know Section
                VStack {
                    Image(systemName: "drop.fill")
                        .resizable()
                        .scaledToFit()
                        .frame(height: 40)
                        .foregroundColor(Color.blue.opacity(0.7))
                    
                    Text("Did you know?")
                        .font(.headline)
                        .padding(.top, 10)
                    
                    Text(randomFact)
                        .font(.body)
                        .multilineTextAlignment(.center)
                        .padding(.all, 10)
                        .cornerRadius(10)
                        .padding(.horizontal)
                        .padding(.bottom, 40)
                }
                   .padding(.top, 30)
               }
               .padding(.horizontal)
           }
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
