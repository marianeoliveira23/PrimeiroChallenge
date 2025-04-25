
import SwiftUI

struct QuartaTela: View {
    
    let text: String = "de repente, aparece um grupo de meninos malvados\n que o cercaram e estavam dispostos a agredi-lo..."
    @State private var animatedText = ""
    @State private var animatedTexto = true
    @State var currenteIndex = 0
    @State var isAnimating: Bool = true
    
    @State var isAnimate = true
    let images = ["41", "42"]
    
    let positions = [
        CGPoint(x: 400, y: 200),
        CGPoint(x: 400, y: 200)]
    
    
    @State var currentIndex = 0
    
    
    var body: some View {
        ZStack{
            
            Image(images[currentIndex])
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(width: 580, height: 580)
                .position(positions[currentIndex])
                .onAppear {
                    animateImage()
                }
            VStack {
                Text(animatedText)
                    .multilineTextAlignment(.center)
                    .font(.custom("SignPainter", size: 30))
                    .foregroundStyle(.black)
                    .position(x: 450, y:70)
                    .task {
                        await animate()
                        isAnimating = false
                    }
                NavigationLink(destination: QuintaTela()) {
                    Image("botaoum")
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .position(CGPoint(x: 40, y: 0))
                        .frame(width: 80, height:15)
                        .padding(EdgeInsets(top: 0, leading: 0, bottom: 20, trailing: 20))
                }
            }
        }.ignoresSafeArea()
    }
    private func animate() async {
        animatedText = ""
        for char in text {
            animatedText.append(char)
            try? await Task.sleep(for: .milliseconds(75))
        }
    }
    func animateImage(){
        Timer.scheduledTimer(withTimeInterval: 1,repeats: true) {_ in
            if isAnimate {
                currentIndex += 1
                if currentIndex >= images.count{
                    currentIndex = 0
                }
            }
        }
    }
    struct QuartaTela_Previews: PreviewProvider {
        static var previews: some View {
            QuartaTela()
        }
        
    }
}
#Preview {
    QuartaTela()
}

