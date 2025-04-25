
import SwiftUI

struct TerceiraTela: View {
    let text: String = "...até que um dia, indo para a escola sozinho,\n ele percebeu que havia algo estranho"
    @State var animatedText = ""
    @State var isAnimating = true
    
    let images = ["31", "32", "33", "34"]
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
                
                NavigationLink(destination: QuartaTela()) {
                    Image("botaoum")
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .position(CGPoint(x: 40, y: 0))
                        .frame(width: 80, height:15)
                        //.padding(EdgeInsets(top: 0, leading: 0, bottom: 20, trailing: 20))
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

struct TerceiraTela_Previews: PreviewProvider {
    static var previews: some View {
        TerceiraTela()
    }
}

#Preview {
    TerceiraTela()
}



