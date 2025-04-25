import SwiftUI

struct OitavaTela: View {
    let text: String = "...após um diálogo, eles decidiram trocar o Samuel de escola"
    @State var animatedText = ""
    @State var isAnimating = true
    
    let images = ["81", "82", "83", "84", "85"]
    let positions = [
        CGPoint(x: 410, y: 180),
        CGPoint(x: 410, y: 180),
        CGPoint(x: 410, y: 180),
        CGPoint(x: 410, y: 180),
        CGPoint(x: 410, y: 180)
    ]
    
    @State var currentIndex = 0
    
    var body: some View {
        ZStack {
            Image(images[currentIndex])
                .position(positions[currentIndex])
                .onAppear {
                    animateImage()
                }
            
            VStack {
               Text("")
                Text(animatedText)
                    .multilineTextAlignment(.center)
                    .font(.custom("SignPainter", size: 30))
                    .foregroundStyle(.black)
                    .task {
                        await animate()
                        isAnimating = false
                    }
                
                Spacer()
                
                NavigationLink(destination: NonaTela()) {
                    Image("botaoum")
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .position(CGPoint(x: 40, y: 0))
                        .frame(width: 80, height:15)
                }
            }
        }.navigationBarBackButtonHidden() // deixa o botao back invisivel

        
    }
    func animateImage(){
        Timer.scheduledTimer(withTimeInterval: 1,repeats: true) {_ in
        if isAnimating {
            currentIndex += 1
            if currentIndex >= images.count{
                currentIndex = 1
            }
        }
    }
    }
    
    private func animate() async {
        animatedText = ""
        for char in text {
            animatedText.append(char)
            try? await Task.sleep(for: .milliseconds(75))
        }
    }
}

struct OitavaTela_Previews: PreviewProvider {
    static var previews: some View {
        OitavaTela()
    }
}

#Preview {
    OitavaTela()
}



