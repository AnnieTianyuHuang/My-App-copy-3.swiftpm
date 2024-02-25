import SwiftUI

struct Change2View: View {
    @EnvironmentObject var selection: Selection
    
    var body: some View {
        ZStack {
            Color.black.opacity(0.4).edgesIgnoringSafeArea(.all)
            VStack(spacing: 20) {
                Text("Try Lower")
                    .font(.title)
                    .foregroundColor(.white)
                Text("Oh, you soared above the Kármán Line (100km)! Drift into the void of space, where Earth's grasp weakens. Now try Experience the thrill of skydiving from lower altitudes. Can you make a perfect landing?")
                    .frame(maxWidth: 400)
                    .multilineTextAlignment(.center) 
                    .font(.system(size: 20))
                    .foregroundColor(.white)
                    .padding()
                    .clipShape(RoundedRectangle(cornerRadius: 18, style: .continuous))
                
                Button(action: {
                    selection.value = 2
                }) {
                    HStack {
                        Text("Replay Prev")
                        Image(systemName: "arrow.counterclockwise.circle.fill") 
                    }
                }
                .frame(width: 200)
                .font(.system(size: 30))
                .foregroundColor(.black)
                .padding()
                .background(Color.white.opacity(0.6))
                .clipShape(RoundedRectangle(cornerRadius: 18, style: .continuous))
                
                Button(action: {
                    selection.value = 3
                }) {
                    HStack {
                        Text("Try Lower")
                        Image(systemName: "arrow.right.circle.fill") 
                    }
                }
                .frame(width: 200)
                .font(.system(size: 30))
                .foregroundColor(.white)
                .padding()
                .background(Color.blue)
                .clipShape(RoundedRectangle(cornerRadius: 18, style: .continuous))
            }
            .padding()
        }
    }
}
