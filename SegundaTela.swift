import Foundation
import SwiftUI

struct SegundaTela: View {
    let text: String = "era uma vez uma criança chamada Samuel,\n todos os dias seus pais o mandavam para uma escola muito rígida..."
    @State var animatedText = ""
    @State var isAnimating = true
    
    let images = ["21", "22", "23", "24", "25"]
    let positions = [
        CGPoint(x: 400, y: 190),
        CGPoint(x: 400, y: 190),
        CGPoint(x: 400, y: 190),
        CGPoint(x: 400, y: 190),
        CGPoint(x: 400, y: 190)
    ]
    
    @State var currentIndex = 0
    
    var body: some View {
        ZStack {
            Image(images[currentIndex])
                //.resizable()
                //.aspectRatio(contentMode: .fill)
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
                
                NavigationLink(destination: TerceiraTela()) {
                    Image("botaoum")
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .position(CGPoint(x: 70, y: 10))
                        .frame(width: 80, height:15)
                }
            }
        }.navigationBarBackButtonHidden() // deixa o botao back invisivel

        
    }
    func animateImage(){
        Timer.scheduledTimer(withTimeInterval: 2,repeats: true) {_ in
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

struct SegundaTela_Previews: PreviewProvider {
    static var previews: some View {
        SegundaTela()
    }
}

#Preview {
    SegundaTela()
}


