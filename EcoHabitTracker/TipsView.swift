//
//  TipsView.swift
//  EcoHabitTracker
//
//  Created by Maria Rodriguez on 10/19/24.
//


import SwiftUI

struct TipsView: View {
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
    
    var body: some View {
        NavigationView {
            List(tips, id: \.self) { tip in
                Text(tip)
            }
            .navigationTitle("Eco-Friendly Tips")
        }
    }
}

struct TipsView_Previews: PreviewProvider {
    static var previews: some View {
        TipsView()
    }
}