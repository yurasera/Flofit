//
//  ContentView.swift
//  Flofit
//
//  Created by Yuhaya Lissera on 05/07/26.
//

import SwiftUI

struct ContentView: View {
    @State private var feelingRating: Int? = nil
    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            Text("Prioritize Recovery")
                .font(.title)
                .fontWeight(.bold)

            Text("Readiness score based on your feeling only.")
                .font(.body)
                .foregroundStyle(.secondary)
            
            Text("Mind & Body Check-in")
                .font(.title3)
                .fontWeight(.bold)
            RateFeeling(feelingRating: $feelingRating)
            
            Text("This form will affect your readiness score")
                .font(.title3)
                .foregroundStyle(Color.DarkModeTextColorSecondary)
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .topLeading)
        .padding()
    }
}

#Preview {
    ContentView()
}
