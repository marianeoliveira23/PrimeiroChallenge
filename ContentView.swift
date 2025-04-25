import SwiftUI

struct ContentView: View {
    let text: String = "diário do Samuel \n\n capítulo: infância"
    @State var animatedText = ""
    @State var animatedTexto = true
    @State var isAnimate = true
    let images = ["11", "12"]
    let positions = [
        CGPoint(x: 440, y: 200),
        CGPoint(x: 440, y: 200)]
    
    @State var currentIndex = 0
    
    var body: some View {
            ZStack{
                Image(images[currentIndex])
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .position(positions[currentIndex])
                    .onAppear {
                        animateImage()
                    }
                VStack{
                    
                    Text(animatedText)
                        .multilineTextAlignment(.center)
                        .font(.custom("SignPainter", size: 30))
                        .foregroundStyle(.black)
                        .position(x: 450, y:200)
                        .onAppear{
                            animate()
                        }
                    
                    NavigationLink(destination: SegundaTela()) {
                        Image("botaoum")
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .position(CGPoint(x: 40, y: 0))
                            .frame(width: 80, height:15)
                            .padding(EdgeInsets(top: 0, leading: 0, bottom: 20, trailing: 20))
                        
                    }
                }
        }
            .ignoresSafeArea()
            .navigationBarBackButtonHidden()
    }
        
        func animateImage(){
            Timer.scheduledTimer(withTimeInterval: 2,repeats: true) {_ in
                if isAnimate {
                    currentIndex += 1
                    if currentIndex >= images.count{
                        currentIndex = 0
                    }
                }
            }
        }
        private func animate() {
            animatedText = ""
            for char in text {
                animatedText.append(char)
                DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
                    animatedTexto = false
                }
            }
        }
        
    }
    #Preview {
        ContentView()
    }

