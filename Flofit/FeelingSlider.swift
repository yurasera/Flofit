
import SwiftUI

struct Feeling {
    var feeling: String
    var description: String
    var signs: String
    var color: Color
}

struct FeelingSlider: View {
    @Binding var feelingRating: Int?
    
    @State private var sliderProgress: CGFloat = 0
    @State private var isDragging: Bool = false
    
    let totalSteps = 5
    
    let feelings: [Feeling] = [
        Feeling(feeling: "Fatigued", description: "Your body still feels heavily worn down", signs: "Muscles feel heavy, soreness lasts longer, body feels slow even after rest.", color: Color.DarkModeFeelingColorFatigued),
        Feeling(feeling: "Exhausted", description: "Your energy feels low today", signs: "Sleepy, mentally drained, low motivation, tired before training even.", color: Color.DarkModeFeelingColorExhausted),
        Feeling(feeling: "Steady", description: "You feel normal and okay to train", signs: "Energy feels stable, no major soreness, no unusual tiredness, average motivation.", color: Color.DarkModeFeelingColorSteady),
        Feeling(feeling: "Energized", description: "You feel fresh and ready to push", signs: "Good mood, body feels light, motivated to train, focused and alert.", color: Color.DarkModeFeelingColorEnergized),
        Feeling(feeling: "Prime", description: "You feel at your absolute best", signs: "Strong, explosive, confident, highly motivated, everything feels “on”.", color: Color.DarkModeFeelingColorPrime)
    ]
    
    private let colorInactiveThumb = Color.DarkModeTextColorSecondary
    
    var activeGradient: LinearGradient {
        LinearGradient(
            colors: [
                Color.DarkModeFeelingColorFatigued,
                Color.DarkModeFeelingColorExhausted,
                Color.DarkModeFeelingColorSteady,
                Color.DarkModeFeelingColorEnergized,
                Color.DarkModeFeelingColorPrime
            ],
            startPoint: .leading,
            endPoint: .trailing
        )
    }
    
    let trackExtension: CGFloat = 20
    
    var body: some View {
        VStack(alignment: .leading, spacing: 32){
            // 1. Judul
            Text("How do you feel today?")
                .font(.BodySemiBold)
                .foregroundStyle(Color.DarkModeTextColorPrimary)
            
            // 2. Detail Deskripsi Perasaan (Dipindah ke atas)
            VStack(alignment: .center, spacing: 12) {
                if let rating = feelingRating {
                    HStack(spacing: 8) {
                        Image(systemName: "\(rating).circle")
                        Text(feelings[rating-1].feeling)
                    }
                    .font(.TitleBold)
                    .foregroundStyle(Color.DarkModeTextColorPrimary)
                    
                    Text(feelings[rating-1].description)
                        .font(.BodySemiBold)
                        .foregroundStyle(Color.DarkModeTextColorPrimary)
                    
                    Text(feelings[rating-1].signs)
                        .font(.FootnoteSemiBold)
                        .foregroundStyle(Color.DarkModeTextColorSecondary)
                        .multilineTextAlignment(.center)
                        .padding(.horizontal, 16)
                } else {
                    Text("Slide to choose your feeling")
                        .font(.BodySemiBold)
                        .foregroundColor(.DarkModeTextColorPrimary)
                }
            }
            .frame(minHeight: 120)
            .frame(maxWidth: .infinity, alignment: .center)
            
            // 3. Slider (Dipindah ke bawah)
            HStack(alignment: .center, spacing: 12) {
                Image(systemName: AppIcon.battery0percent)
                    .foregroundStyle(Color.DarkModeTextColorPrimary)
                
                GeometryReader { geometry in
                    let width = geometry.size.width
                    let thumbSize: CGFloat = 28
                    let trackHeight: CGFloat = 14
                    
                    ZStack(alignment: .leading) {
                        Capsule()
                            .fill(feelingRating == nil ? AnyShapeStyle(Color.DarkModeTextColorSecondary) : AnyShapeStyle(activeGradient))
                            .frame(width: width + trackExtension * 2, height: trackHeight)
                            .offset(x: -trackExtension)
                        
                        ForEach(0..<totalSteps, id: \.self) { index in
                            let tickProgress = CGFloat(index) / CGFloat(totalSteps - 1)
                            Circle()
                                .fill(Color.white)
                                .frame(width: 4, height: 4)
                                .offset(x: tickProgress * (width - thumbSize) + (thumbSize - 4) / 2)
                        }
                        
                        Circle()
                            .fill(feelingRating == nil ? colorInactiveThumb : feelings[feelingRating!-1].color)
                            .frame(width: thumbSize, height: thumbSize)
                            .overlay(Circle().stroke(Color.white, lineWidth: 3))
                            .shadow(radius: 4)
                            .offset(x: feelingRating == nil ? -trackExtension : sliderProgress * (width - thumbSize))
                            .gesture(
                                DragGesture(minimumDistance: 0)
                                    .onChanged { value in
                                        isDragging = true
                                        let locationX = value.location.x - (thumbSize / 2)
                                        let rawProgress = locationX / (width - thumbSize)
                                        let clampedProgress = min(max(rawProgress, 0), 1)
                                        sliderProgress = clampedProgress
                                        
                                        let calculatedRating = Int(round(clampedProgress * CGFloat(totalSteps - 1))) + 1
                                        if feelingRating != calculatedRating {
                                            feelingRating = calculatedRating
                                        }
                                    }
                                    .onEnded { _ in
                                        isDragging = false
                                        if let currentRating = feelingRating {
                                            withAnimation(.spring(response: 0.2, dampingFraction: 0.7)) {
                                                sliderProgress = CGFloat(currentRating - 1) / CGFloat(totalSteps - 1)
                                            }
                                        }
                                    }
                            )
                    }
                    .frame(height: thumbSize)
                    .onChange(of: feelingRating, initial: true) { _, newValue in
                        if let currentRating = newValue, !isDragging {
                            sliderProgress = CGFloat(currentRating - 1) / CGFloat(totalSteps - 1)
                        }
                    }
                }
                .frame(height: 28)
                .padding(.horizontal, trackExtension)
                
                Image(systemName: AppIcon.battery100percent)
                    .foregroundStyle(Color.DarkModeTextColorPrimary)
            }
        }
        .frame(maxWidth: .infinity)
    }
}

#Preview {
    @Previewable @State var dummyRating: Int? = nil
    
    FeelingSlider(feelingRating: $dummyRating)
}
