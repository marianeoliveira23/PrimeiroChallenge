import Foundation
import SwiftUI

struct SextaTela: View {
    let text: String = "ao chegar em casa, ele contou tudo aos seus pais \n e eles ficaram super assustados com a situação"
    @State var animatedText = ""
    @State var isAnimating = true
    
    let images = ["61", "62"]
    let positions = [
        CGPoint(x: 400, y: 190),
        CGPoint(x: 400, y: 190)
    ]
    @State var currentIndex = 0
    
    var body: some View {
        ZStack {
            Image(images[currentIndex])
                .resizable()
                .aspectRatio(contentMode: .fill)
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
                
                NavigationLink(destination: SetimaTela()) {
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

struct SextaTela_Previews: PreviewProvider {
    static var previews: some View {
        SextaTela()
    }
}

#Preview {
    SextaTela()
}


