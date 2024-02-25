import SwiftUI

struct Change3View: View {
    @EnvironmentObject var selection: Selection
    
    var body: some View {
        ZStack {
            Color.black.opacity(0.4).edgesIgnoringSafeArea(.all)
            VStack(spacing: 20) {
                Text("Try adding clouds")
                    .font(.title)
                    .foregroundColor(.white)
                Text("Oh, you dived below Safe Altitude (300m): Too close to earth, and there's no chance for parachutes to deploy. Let's try something new! Clouds can make skydiving more challenging and fun. Try placing some in your next jump.")
                    .frame(maxWidth: 400)
                    .multilineTextAlignment(.center) 
                    .font(.system(size: 20))
                    .foregroundColor(.white)
                    .padding()
                    .clipShape(RoundedRectangle(cornerRadius: 18, style: .continuous))
                
                Button(action: {
                    selection.value = 3
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
                    selection.value = 4
                }) {
                    HStack {
                        Text("Place Cloud")
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
        }
    }
}

