import SwiftUI

struct SetimaTela: View {
    let text: String = "...ao investigarem a situação eles perceberam que\n o grupo era muito perigoso e poderia \n se repetir..."
    @State var animatedText = ""
    @State var isAnimating = true
    
    let images = ["71", "72", "73", "74", "75"]
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
                    .position(x:500 , y:50)
                    .font(.custom("SignPainter", size: 30))
                    .foregroundStyle(.black)
                    .task {
                        await animate()
                        isAnimating = false
                    }
                
                Spacer()
                
                NavigationLink(destination: OitavaTela()) {
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
        Timer.scheduledTimer(withTimeInterval: 2,repeats: true) {_ in
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

struct SetimaTela_Previews: PreviewProvider {
    static var previews: some View {
        SetimaTela()
    }
}

#Preview {
    SetimaTela()
}


