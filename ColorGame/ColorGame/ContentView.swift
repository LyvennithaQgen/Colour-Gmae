//
//  ContentView.swift
//  ColorGame
//
//  Created by htcuser on 07/10/22.
//

import SwiftUI

struct ContentView: View {
    @State var score = 0
    @State var timeRemaining = 60
    let timer = Timer.publish(every: 1, on: .main, in: .common).autoconnect()
    @State var color = colors.randomElement() ?? .gray
    @State var randomRow = numbers.randomElement()
    @State var randomCol = numbers.randomElement()
    @State var showWrong: Bool = false
    @State var opacityValue = opaity.randomElement()
    var body: some View {
        ZStack{
            
            VStack(spacing: 20.0) {
                VStack(spacing: 25.0){
                    Text("Score: \(String(score))")
                        .font(Font.custom("PEOPLE BOOK", size: 30))
                    Text("Time Remaining: \(timeRemaining)")
                        .font(Font.custom("PEOPLE BOOK", size: 30))
                        .onReceive(timer) { _ in
                            if timeRemaining > 0 {
                                timeRemaining -= 1
                            }
                        }
                }
                .padding(.horizontal)
                VStack{
                    VStack{
                        ForEach(numbers, id: \.self) { row in
                            HStack {
                                ForEach(numbers, id: \.self) { col in
                                    ColorView(color: col == randomRow && row == randomCol ? color.opacity(opacityValue ?? 0.8):color)
                                        .frame(width: 50, height: 50)
                                        .cornerRadius(15)
                                        .onTapGesture {
                                            withAnimation {
                                                if col != randomRow || row != randomCol{
                                                    showWrong.toggle()
                                                    DispatchQueue.main.asyncAfter(deadline: .now()+1, execute: {
                                                        showWrong.toggle()
                                                    })
                                                }
                                            }
                                            if timeRemaining > 0{
                                                score = col == randomRow && row == randomCol ? score+100 : score-50 < 0 ? 0: score-50
                                                color = colors.randomElement() ?? .gray
                                                randomRow = numbers.randomElement()
                                                randomCol = numbers.randomElement()
                                                opacityValue = opaity.randomElement()
                                            }
                                            
                                        }
                                }
                            }
                        }
                    }
                }
                    .frame(width: UIScreen.main.bounds.size.width*0.9, height: UIScreen.main.bounds.size.height*0.4)
                    .background(Color.white)
                    .cornerRadius(15)
                    .shadow(radius: 10)
                
            }
            .padding(.all)
            if showWrong{
                Image("Wrong")
                    .resizable()
                    .frame(width: 100, height: 100)
                    .opacity(0.7)
            }
            if timeRemaining == 0{
                VStack(spacing: 100.0){
                    Text("Your Score")
                        .font(Font.custom("PEOPLE BOOK", size: 50))
                    Text(String(score))
                        .font(Font.custom("PEOPLE BOOK", size: 50))
                        .foregroundColor(Color.white)
                        .background(Image("SB")
                            .resizable()
                            .frame(width: UIScreen.main.bounds.size.width*0.7, height: UIScreen.main.bounds.size.height*0.2))
                    Text("Start Again")
                        .font(Font.custom("PEOPLE BOOK", size: 30))
                        .frame(width: 230, height: 42)
                        .background(Color.teal)
                        .cornerRadius(12)
                        .onTapGesture {
                            timeRemaining = 60
                        }
                    
                    
                    
                }
                .frame(maxWidth: .infinity, maxHeight: .infinity)
                .background(LinearGradient(gradient: Gradient(colors: [.teal, .white]), startPoint: .top, endPoint: .bottom))
                .background(Color.white)
            }
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(LinearGradient(gradient: Gradient(colors: [.teal, .white]), startPoint: .top, endPoint: .bottom))
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}


let colors: [Color] = [.red, .green, .blue, .yellow, .purple, .cyan, .orange, .gray, .black]
let numbers = [0, 1, 2, 3, 4]
let opaity = [0.7, 0.8, 0.85, 0.9, 0.75]
 
@ViewBuilder
func ColorView(color: Color) -> some View {
    (color )
        .cornerRadius(15)
        .frame(minHeight: 40)
}
