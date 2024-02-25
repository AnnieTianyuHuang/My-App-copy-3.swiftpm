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
                
                Button("Replay") {
                    selection.value = 3
                }
                .foregroundColor(.white)
                .padding()
                .background(Color.blue)
                .cornerRadius(10)
                
                Button("Place Cloud") {  // 新增的按钮
                    selection.value = 4
                }
                .foregroundColor(.white)
                .padding()
                .background(Color.green)  // 为了区分，使用不同的颜色
                .cornerRadius(10)
            }
            .padding()
        }
    }
}

