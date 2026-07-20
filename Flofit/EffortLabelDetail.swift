//
//  EffortLabel.swift
//  LiMaChallenge3
//
//  Created by Juan Fausta Pringadi on 05/06/26.
//

import SwiftUI

struct EffortLabelDetail: View {
    @Binding var feeling: Int
    
    private var effortColorLabel: Color {
        switch feeling {
        case 5:
            return .DarkModeFeelingColorPrimeLabel
        case 4:
            return .DarkModeFeelingColorEnergizedLabel
        case 3:
            return .DarkModeFeelingColorSteadyLabel
        case 2:
            return .DarkModeFeelingColorExhaustedLabel
        default:
            return .DarkModeFeelingColorFatiguedLabel
        }
    }
    
    private var effortColorText: Color {
        switch feeling {
        case 5:
            return .DarkModeFeelingColorPrime
        case 4:
            return .DarkModeFeelingColorEnergized
        case 3:
            return .DarkModeFeelingColorSteady
        case 2:
            return .DarkModeFeelingColorExhausted
        default:
            return .DarkModeFeelingColorFatigued
        }
    }
    
    private var effortDescription: String {
        switch feeling {
        case 5:
            return "Prime"
        case 4:
            return "Energized"
        case 3:
            return "Steady"
        case 2:
            return "Exhausted"
        default:
            return "Fatigued"
        }
    }
    
    var body: some View {
        HStack (spacing:4){
            Image(systemName: "\(feeling).circle")
            Text("\(effortDescription)")
        }
        .padding(8)
        .font(.BodySemiBold)
        .background(effortColorLabel, in: RoundedRectangle(cornerRadius: Radius.unclickable))
        .foregroundStyle(effortColorText)
    }
}

