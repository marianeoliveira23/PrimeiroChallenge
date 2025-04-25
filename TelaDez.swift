import SwiftUI

struct TelaDez: View {
    let text: String = "...na nova escola ele fez novos amigos e se sentiu muito mais feliz"
    @State var animatedText = ""
    @State var isAnimating = true
    
    let images = ["101", "102", "103", "104"]
    let positions = [
        CGPoint(x: 320, y: 200),
        CGPoint(x: 320, y: 200),
        CGPoint(x: 320, y: 200),
        CGPoint(x: 320, y: 200)]
    
    
    @State var currentIndex = 0
    
    var body: some View {
        ZStack {
            Image(images[currentIndex])
                .resizable()
                .aspectRatio(contentMode: .fit)
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
                
                NavigationLink(destination: TelaOnze()) {
                    Image("botaoum")
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .position(CGPoint(x: 40, y: 0))
                        .frame(width: 80, height:15)
                }
            }
        }//.navigationBarBackButtonHidden() // deixa o botao back invisivel

        
    }
    func animateImage(){
        Timer.scheduledTimer(withTimeInterval: 1,repeats: true) {_ in
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

struct TelaDez_Previews: PreviewProvider {
    static var previews: some View {
        TelaDez()
    }
}

#Preview {
    TelaDez()
}




