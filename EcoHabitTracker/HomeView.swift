import SwiftUI

struct HomeView: View {
    @EnvironmentObject var viewModel: ChallengesViewModel
    @State private var selectedChallenge: ChallengeModel? = nil
    @State private var showModal: Bool = false
    @State private var currentChallengeIndex: Int = 0
    
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
    
    var randomTip: String {
        tips.randomElement() ?? "Stay eco-friendly!"
    }

    var body: some View {
        ScrollView {
            VStack(spacing: 0) {
                Text("Welcome To EcoHabits!")
                    .font(.title).bold()
                    .padding(.top, 18)

                
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
                .background(Color.white) // Background color for the VStack
                .cornerRadius(15) // Rounded corners
                .shadow(color: .gray.opacity(0.5), radius: 10, x: 0, y: 5) // Shadow for depth effect
                .overlay(
                    RoundedRectangle(cornerRadius: 15)
                        .stroke(Color.green, lineWidth: 1)
                )
                .padding(.top, 20)

                Text("Completed Challenges:")
                    .font(.title)
                    .padding(.top, 40)
                
                Text("Your Points: \(viewModel.points)")
                    .font(.callout)
                    .padding(.top, 10)

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
                    .padding(.vertical)
                } else {
                    Text("No completed challenges yet!")
                        .font(.subheadline)
                        .foregroundColor(.secondary)
                        .padding()
                }

                // Thoughtful Tip Section
                Text("Thoughtful Tip:")
                    .font(.system(size: 20))
                
                Text(randomTip)
                    .font(.body)
                    .padding(.all, 10)
                    .background(Color.green.opacity(0.1))
                    .cornerRadius(10)
                    .padding(.horizontal)

                VStack {
                    Image("earthSmile")
                        .resizable()
                        .scaledToFit()
                        .frame(height: 200)

                    Text("Every little action counts! Whether it’s turning off lights, using less water, or recycling, you can make a difference. Together, we can keep the Earth healthy and happy. Let’s be eco-heroes!")
                        .font(.body)
                        .multilineTextAlignment(.center)
                        .padding()
                        .padding(.horizontal)
                }
                .padding()
                .background(Color.white) // Background color for the VStack
                .cornerRadius(15) // Rounded corners
                .shadow(color: .gray.opacity(0.5), radius: 10, x: 0, y: 5) // Shadow for depth effect
                .overlay(
                    RoundedRectangle(cornerRadius: 15)
                        .stroke(Color.green, lineWidth: 1)
                )
                .padding(.top, 20)
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
