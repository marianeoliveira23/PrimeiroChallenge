import SwiftUI

struct TelaOnze: View {
    let text: String = "na Fundação ele fez verdadeiros amigos\n e encontrou seu propósito de vida"
    @State var animatedText = ""
    @State var isAnimating = true
    
    let images = ["111","112", "113"]
    let positions = [
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
                Text(animatedText)
                    .multilineTextAlignment(.center)
                    .position(CGPoint(x: 400, y: 50))
                    .font(.custom("SignPainter", size: 30))
                    .foregroundStyle(.black)
                    .task {
                        await animate()
                        isAnimating = false
                    }
                Spacer()
                NavigationLink(destination: TelaFim()) {
                    Image("botaoum")
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(width: 80, height:15)
                        
                    
                }
            }
            
        }.navigationBarBackButtonHidden() // deixa o botao back invisivel
        
    }
    func animateImage(){
        Timer.scheduledTimer(withTimeInterval: 0.5,repeats: true) {_ in
            if isAnimating {
                currentIndex += 1
                if currentIndex >= images.count{
                    currentIndex = 0
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

struct TelaOnze_Previews: PreviewProvider {
    static var previews: some View {
        TelaOnze()
    }
}

#Preview {
    TelaOnze()
}




