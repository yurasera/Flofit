import SwiftUI

struct RateFeeling: View {
    @State private var isClicked: Bool = false
    @Binding var feelingRating: Int?
    
    // Computed Property mendeteksi apakah data final sudah tersimpan atau belum
    var isLogged: Bool {
        feelingRating != nil
    }
    
    private var effortColorLabel: Color {
        switch feelingRating {
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
    
    private var notFilledGradient: LinearGradient {
        LinearGradient(
            colors: [
                Color(hex: "#1A1616"),
                Color(hex: "#6C1315")
            ],
            startPoint: UnitPoint(x: 0.9, y: 0.95),
            endPoint: UnitPoint(x: -0.35, y: 0.95)
        )
    }
    
    private var filledGradient: LinearGradient {
        LinearGradient(
            colors: [
                effortColorLabel,
                Color.DarkModeBackgroundColorClickable
            ],
            startPoint: UnitPoint(x: 0, y: 1),
            endPoint: UnitPoint(x: 0.75, y: -0.2)
        )
    }
    
    var body: some View {
        Button(action: {
            withAnimation(.spring(response: 0.35, dampingFraction: 0.8)) {
                isClicked.toggle()
            }
        }) {
            HStack {
                Text(isLogged ? "You are feeling" : "How are you feeling today?")
                    .font(.BodySemiBold)
                    .foregroundStyle(Color.DarkModeTextColorPrimary)
                
                Spacer()
                
                if let safeBinding = Binding($feelingRating) {
                    EffortLabelDetail(feeling: safeBinding)
                }
                
                
                if(isLogged){
                    Image(systemName: "pencil")
                        .font(.BodySemiBold)
                        .padding(8)
                        .foregroundStyle(Color.DarkModeTextColorPrimary)
                }
                else {
                    Image(systemName: "plus")
                        .font(.BodySemiBold)
                        .padding(8)
                        .foregroundStyle(Color.DarkModeTextColorPrimary)
                        .liquidGlass(color: Color(hex: "#6C1315"), radius: 1000)
                }
            }
        }
        .padding(16)
        .liquidGlass(gradient: isLogged ? filledGradient : notFilledGradient, radius: Radius.clickable)
        .transition(
            .asymmetric(
                insertion: .move(edge: .top).combined(with: .opacity),
                removal: .move(edge: .top).combined(with: .opacity)
            )
        )
        .animation(.easeInOut(duration: 0.3), value: isClicked)
        .sheet(isPresented: $isClicked){
            FeelingTodaySheet(feelingRating: $feelingRating)
                .presentationDetents([.height(500)])
                .presentationDragIndicator(.visible)
        }
    }
}

#Preview {
    @Previewable @State var mockFeelingRating: Int? = nil
    
    RateFeeling(feelingRating: $mockFeelingRating)
    
}

