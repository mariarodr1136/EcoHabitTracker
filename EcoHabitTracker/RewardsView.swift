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
                .padding(.top, 30)

            Text("Your Rewards")
                .font(.largeTitle)
                .bold()

            Image(systemName: "medal.fill")
                .resizable()
                .scaledToFit()
                .frame(width: 60, height: 60)
                .foregroundColor(getMedalColor(for: viewModel.points)) 
                .padding(.top, 10)
            
            Text((currentMedalColor()))
                .font(.headline)
                .padding(.top, 5)

            VStack {

                Text(pointsToNextMedal())
                    .font(.footnote)
                    .foregroundColor(.gray)
                    .multilineTextAlignment(.center)

                VStack(alignment: .center, spacing: 10) {
                    Text("How to Earn Points:")
                        .font(.headline)
                        .padding(.top, 20)

                    Text("• Complete challenges")
                    Text("• Build sustainable habits")
                    Text("• Help save the planet!")
                }
                .multilineTextAlignment(.center)
            }
            .frame(maxWidth: .infinity, alignment: .center)

            // Circular progress graph
            ZStack {
                Circle()
                    .fill(Color.green.opacity(0.3))

                Circle()
                    .trim(from: 0.0, to: CGFloat(min(Double(viewModel.points) / 850.0, 1.0)))
                    .stroke(Color.green, lineWidth: 10)
                    .frame(width: 100, height: 100)
                    .rotationEffect(.degrees(-90))
                    .animation(.easeOut(duration: 1.0), value: viewModel.points)

                // Text displaying current points
                Text("\(viewModel.points)/850")
                    .font(.headline)
                
            }
            .padding(.top, 20)
            .padding(.bottom, 20)

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
        .padding(.bottom, 40)
    }

    // Function to determine the medal color based on points
    func getMedalColor(for points: Int) -> Color {
        switch points {
        case 0..<100:
            return Color.gray // No medal
        case 100..<300:
            return Color.bronze // Bronze medal
        case 300..<500:
            return Color.silver // Silver medal
        case 500..<850:
            return Color.gold // Gold medal
        case 850...:
            return Color.platinum // Platinum medal
        default:
            return Color.gray // Default no medal
        }
    }

    // Function to calculate points needed for the next medal and generate a message
    func pointsToNextMedal() -> String {
        let points = viewModel.points

        if points < 100 {
            return "\(100 - points) points to Bronze!"
        } else if points < 300 {
            return "\(300 - points) points to Silver!"
        } else if points < 500 {
            return "\(500 - points) points to Gold!"
        } else if points < 850 {
            return "\(850 - points) points to Platinum!"
        } else {
            return "Congratulations! You've earned the Platinum medal!"
        }
    }
    
    // Function to describe the current medal color
    func currentMedalColor() -> String {
        switch viewModel.points {
        case 0..<100:
            return "No Medal Currently"
        case 100..<300:
            return "Bronze Medal"
        case 300..<500:
            return "Silver Medal"
        case 500..<850:
            return "Gold Medal"
        case 850...:
            return "Platinum Medal"
        default:
            return "No Medal Currently"
        }
    }
}

struct RewardsView_Previews: PreviewProvider {
    static var previews: some View {
        RewardsView()
            .environmentObject(ChallengesViewModel())
    }
}

// Define custom colors for bronze, silver, gold, and platinum
extension Color {
    static let bronze = Color(red: 205 / 255, green: 127 / 255, blue: 50 / 255)
    static let silver = Color(red: 192 / 255, green: 192 / 255, blue: 192 / 255)
    static let gold = Color(red: 255 / 255, green: 215 / 255, blue: 0 / 255)
    static let platinum = Color(red: 229 / 255, green: 228 / 255, blue: 226 / 255)
}
