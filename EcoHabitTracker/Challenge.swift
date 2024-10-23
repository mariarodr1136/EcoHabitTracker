import Foundation

struct Challenge: Identifiable {
    let id = UUID()
    let imageName: String
    let title: String
    let isSystemImage: Bool 
}
