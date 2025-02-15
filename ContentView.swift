//
//  ContentView.swift
//  MiGi
//
//  Created by Дмитрий on 01.01.2024.
//

import SwiftUI

let p1 = Player()
let p2 = Opponent(playerBoard: p1.board)
let game = mainGame(player: p1, computer: p2)



enum Buttons : String {
    case one = "1"
    case two = "2"
    case three = "3"
    case four = "4"
    case five = "5"
    case six  = "6"
    case seven  = "7"
    case eight  = "8"
    case nine = "9"
    case zero = "0"
    case none = ""
    
    var buttonColor: Color {
        return Color(UIColor(red: 55/255.0, green: 55/255.0, blue: 55/255.0, alpha: 1))
        }
    var orangeClor: Color {
        return Color(UIColor(red: 254/255.0, green: 55/255.0, blue: 1/255.0, alpha: 1))
        }
    }



struct ContentView: View {
    
//    @State var dice: Int = Int.random(1...6)
    @State private var dice: Int = Int.random(in: 1...6)
    @State private var pointMainP1 = String(p1.mainPoints)
    @State private var pointMainP2 = String(p2.mainPoints)
    @State private var gameStatus = game.findEndGame()
    let buttons: [[Buttons]] = [
        [.seven, .eight, .nine],
        [.four, .five, .six],
        [.one, .two, .three]
    ]
    
    var body: some View {
        //            Компьютер
        if gameStatus {
//        if false {
            
            VStack{
                ForEach(buttons, id: \.self){ row in
                    HStack (spacing: 12){
                        ForEach(row, id:\.self){
                            item in Button  {
                                //                                self.didTap(button: item)
                            } label: {
                                let (r, c) = findCoords(number: item.rawValue)
                                let position = String(p2.board.field[r][c])
                                let text = position == "0" ? " " : position
                                Text(text)
                                //                                здесь меняешь текс в кнопке
                                
                                    .font(.system(size : 32))
                                    .frame(
                                        width: self.buttonWidth(item: item),
                                        height: self.buttonHeight())
                                    .background(item.buttonColor)
                                    .foregroundColor(.white)
                                    .cornerRadius(self.buttonWidth(item: item) / 2)
                            }
                            
                        }
                    }
                    .padding(.bottom, 3)
                }
                Spacer()
            }
            
            HStack{
                Spacer()
                
                Text(pointMainP1)
                    .font(.system(size: 32))
                    .frame(width: 100.0, height: 50)
                    .background(/*@START_MENU_TOKEN@*//*@PLACEHOLDER=View@*/Color.blue/*@END_MENU_TOKEN@*/)
                    .cornerRadius(30)
                    .padding(.trailing, 30.0)
                
                
                Image("dice_\(dice)")
                    .resizable()
                    .frame(width: 100.0, height: 100.0)
                    .cornerRadius(20)
                

                Text(pointMainP2)
                    .font(.system(size: 32))
                    .frame(width: 100.0, height: 50)
                    .background(/*@START_MENU_TOKEN@*//*@PLACEHOLDER=View@*/Color(red: 0.998, green: 0.584, blue: 0.012)/*@END_MENU_TOKEN@*/)
                    .cornerRadius(30)
                    .padding(.leading, 30.0)
                
                Spacer()
            }
            
            //        Игрок
            VStack{
                Spacer()
                ForEach(buttons, id: \.self){ row in
                    HStack (spacing: 12){
                        ForEach(row, id:\.self){
                            item in Button  {
                                self.didTap(button: item)
                                pointUp()
                                //                            dice = Int.random(in: 1...6)
                                
                            } label: {
                                let (r, c) = findCoords(number: item.rawValue)
                                let position = String(p1.board.field[r][c])
                                let text = position == "0" ? " " : position
                                Text(text)
                                //                                здесь менешь текс в кнопке
                                
                                    .font(.system(size : 32))
                                    .frame(
                                        width: self.buttonWidth(item: item),
                                        height: self.buttonHeight())
                                    .background(item.buttonColor)
                                    .foregroundColor(.white)
                                    .cornerRadius(self.buttonWidth(item: item) / 2)
                            }
                            
                        }
                    }
                    .padding(.bottom, 3)
                }
            }
            
        } else {
            VStack {
                var pointP1 = p1.mainPoints, pointP2 = p2.mainPoints
                if pointP1 > pointP2 {
//                if true {
                    Text("Игрок победил")
                        .font(.system(size: 50))
                        .multilineTextAlignment(.center)
                        .frame(width: 300.0, height: 150.0)
                        .background(.blue)
                        .cornerRadius(30)
                        .padding(.horizontal, 30.0)
                    
                } else if pointP1 != pointP2 {
//                } else if true {
                    Text("Компьютер победил")
                        .font(.system(size: 50))
                        .multilineTextAlignment(.center)
                        .frame(width: 300.0, height: 200.0)
                        .background(.orange)
                        .cornerRadius(30)
                        .padding(.horizontal, 30.0)
                } else {
                    Text("Ничья")
                        .font(.system(size: 50))
                        .multilineTextAlignment(.center)
                        .frame(width: 300.0, height: 100.0)
                        .background(.gray)
                        .cornerRadius(30)
                        .padding(.horizontal, 30.0)
                }
                Button {
                    restart()
                } label: {
                    Text("заново")
                    .font(.system(size: 40))
                    .frame(width: 200, height: 100)
                    .background(.green)
                    .cornerRadius(/*@START_MENU_TOKEN@*/20.0/*@END_MENU_TOKEN@*/)
                    .padding(.top, 100.0)
                    .foregroundColor(.secondary)
                    
                    }
            }
        }
    }
    
    func pointUp() {
        p1.pointUpdate()
        pointMainP1 = String(p1.mainPoints)
        
        p2.pointUpdate()
        pointMainP2 = String(p2.mainPoints)
    }
    
    func restart() {
        game.restartGame()
        pointMainP1 = "0"
        pointMainP2 = "0"
        gameStatus = true
        
    }
    
    func didTap(button : Buttons){

        let (r, c) = findCoords(number: button.rawValue)
        if p1.board.field[r][c] == 0 {
            game.playerTurn(dice, r, c)
            dice = Int.random(in: 1...6)
            gameStatus = game.findEndGame()
            
            game.computerTurn(num: dice)
            dice = Int.random(in: 1...6)
            gameStatus = game.findEndGame()
        }

        
        
//        var position = p1.board.field[r][c]
//        if position == 0 {
//            position =
//        }
//        p1.board.viewField()
        
        
//        if self.displayValue == "0" {
//            displayValue = number
//        }else {
//            self.displayValue = "\(self.displayValue)\(number)"
//        }
    }

    
    func findCoords(number: String) -> (Int, Int) {
        var c = 0, r = 0
        switch number {
        case "1": c = 0; r = 2
        case "2": c = 1; r = 2
        case "3": c = 2; r = 2
        case "4": c = 0; r = 1
        case "5": c = 1; r = 1
        case "6": c = 2; r = 1
        case "7": c = 0; r = 0
        case "8": c = 1; r = 0
        default: c = 2; r = 0
        }
        return (r, c)
    }
    
//    могу настроить размеры
    func buttonWidth (item : Buttons) -> CGFloat {
        return (UIScreen.main.bounds.width - (5 * 12)) / 4
    }
    func buttonHeight () -> CGFloat {
        return (UIScreen.main.bounds.width - (5 * 12)) / 4
    }
}

#Preview {
    ContentView()
}
