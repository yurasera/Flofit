//
//  ContentView.swift
//  Flofit
//
//  Created by Yuhaya Lissera on 05/07/26.
//

import SwiftUI

struct ContentView: View {
    @State private var feelingRating: Int? = nil
    @State private var isShowingFeelingSheet: Bool = true
    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            Text("Prioritize Recovery")
                .font(.title)
                .fontWeight(.bold)
                .foregroundStyle(.black)

            Text("Readiness score based on your feeling only.")
                .font(.body)
                .foregroundStyle(.black)
            
            FeelingTodaySheet(feelingRating: $feelingRating, isPresented: $isShowingFeelingSheet)
                .background(Color.clear)
                .transition(.move(edge: .bottom).combined(with: .opacity))
                .zIndex(1)
            RateFeeling(feelingRating: $feelingRating, showFeelingSheet: $isShowingFeelingSheet)
            
            Text("This form will affect your readiness score")
                .font(.body)
                .foregroundStyle(.black)
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .topLeading)
        .padding()
        .background(.white)
    }
}

#Preview {
    ContentView()
}
