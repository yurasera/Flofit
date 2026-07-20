import SwiftUI

struct FeelingTodaySheet: View {
    @Binding var feelingRating: Int?
    @Binding var isPresented: Bool
    @State private var localRating: Int?
    
    var body: some View {
        NavigationStack {
            VStack(spacing: 0) {
                FeelingSlider(feelingRating: $localRating)
                    .padding(.top, 20)
                
                Spacer()
                
                Button(action: {
                    feelingRating = localRating
                    isPresented = false
                }) {
                    Text("Save Feeling")
                        .font(.BodySemiBold)
                        .foregroundStyle(Color.DarkModeTextColorPrimary)
                        .frame(maxWidth: .infinity)
                        .padding(.vertical, 16)
                        .background(localRating == nil ? Color.DarkModeBackgroundColorGray : Color.DarkModeBrandColorPrimary) // Ganti dengan token warnamu
                        .clipShape(RoundedRectangle(cornerRadius: Radius.clickable))
                }
                .disabled(localRating == nil)
                .padding(.bottom, 16)
            }
            .navigationTitle("Feeling Today")
            .navigationBarTitleDisplayMode(.inline)
            .onAppear {
                localRating = feelingRating
            }
        }
        .padding(20)
    }
}

#Preview {
    @Previewable @State var previewRating: Int?
    @Previewable @State var previewPresented: Bool = true
    FeelingTodaySheet(feelingRating: $previewRating, isPresented: $previewPresented)
}
