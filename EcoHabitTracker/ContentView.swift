import SwiftUI

struct ContentView: View {
    @StateObject private var challengesViewModel = ChallengesViewModel()
    
    var body: some View {
        TabView {
            // Home Tab
            HomeView()
                .tabItem {
                    Image(systemName: "house.fill")
                    Text("Home")
                }

            // Challenges Tab
            ChallengesView()
                .tabItem {
                    Image(systemName: "star.fill")
                    Text("Challenges")
                }

            // Rewards Tab
            RewardsView()
                .tabItem {
                    Image(systemName: "trophy.fill")
                    Text("Rewards")
                }
        }
        .environmentObject(challengesViewModel)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
            .environmentObject(ChallengesViewModel())
    }
}
