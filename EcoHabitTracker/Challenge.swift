//
//  Challenge.swift
//  EcoHabitTracker
//
//  Created by Maria Rodriguez on 10/18/24.
//

import Foundation

struct Challenge: Identifiable {
    let id = UUID()
    let imageName: String
    let title: String
    let isSystemImage: Bool // New property to distinguish image types
}
