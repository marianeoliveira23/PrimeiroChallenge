
import SwiftUI

struct TelaFim: View {
    let text: String = "esse capítulo finaliza por aqui, \n obrigada pela atenção!!"
    @State var animatedText = ""
    @State var isAnimating = true
    
    let images = ["fim1", "fim1", "fim1"]
    let positions = [
        CGPoint(x: 370, y: 200),
        CGPoint(x: 370, y: 200),
        CGPoint(x: 370, y: 200)]
    
    
    @State var currentIndex = 0
    
    var body: some View {
        ZStack {
            Image(images[currentIndex])
                .resizable()
                .aspectRatio(contentMode: .fill)
                .position(CGPoint(x: 390, y: 180))
                .position(positions[currentIndex])
                .onAppear {
                    animateImage()
                }
            
            VStack {
                Text(animatedText)
                    .multilineTextAlignment(.center)
                    .font(.custom("SignPainter", size: 30))
                    .foregroundStyle(.black)
                    .position(CGPoint(x: 400, y: 50))
                    //.frame(width: 80, height:15)
                    .task {
                        await animate()
                        isAnimating = false
                    }
            }
        }//.navigationBarBackButtonHidden() // deixa o botao back invisivel

        
    }
    func animateImage(){
        Timer.scheduledTimer(withTimeInterval: 0.5,repeats: true) {_ in
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

struct TelaFim_Previews: PreviewProvider {
    static var previews: some View {
        TelaFim()
    }
}

#Preview {
    TelaFim()
}




