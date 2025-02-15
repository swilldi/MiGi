//
//  Main.swift
//  MiGi
//
//  Created by Дмитрий on 01.01.2024.
//

import Foundation

func countQuantity(_ array: Array<Int>, _ num: Int) -> Int {
    var quantity = 0
    for n in array {
        if n == num {
            quantity += 1
        }
    }
    return quantity
}





class mainGame {
    var step = 1
    var player: Player, computer: Opponent
    
    init(player: Player, computer: Opponent) {
        self.player = player
        self.computer = computer
    }
    
    func restartGame() {
        p1.board = Board()
        p1.pointUpdate()
        p2.board = Board()
        p2.pointUpdate()
    }
    
    func findEndGame() -> Bool {
        var pl = 0, comp = 0
        for row in 0...2 {
            if player.board.field[row].contains(0) { pl += 1 }
            if computer.board.field[row].contains(0) { comp += 1 }
        }
        if pl == 0 || comp == 0 {
//            Thread.sleep(forTimeInterval: 10)
            return false
        }
        return true
    }
    
    func playerTurn(_ dice: Int, _ row: Int, _ col: Int) {
        self.player.makeMove(num: dice, row, col)
        delCoincident(num: dice, col: col)
        p1.pointUpdate()
        step = 0
    }
    
    func computerTurn(num dice: Int) {
        self.computer.makeMove(num: dice)
        delCoincident(num: dice, col: computer.lastStep[1])
        p2.pointUpdate()
        step = 1
    }
    
    func delCoincident(num: Int, col: Int) {
        if step == 1 {
            let arr = self.computer.board.getCol()[col]
            if arr.contains(num) {
                for i in 0...2 {
                    if computer.board.field[i][col] == num {
                        computer.board.field[i][col] = 0
                    }
                }
            }
        } else {
            let arr = self.player.board.getCol()[col]
            if arr.contains(num) {
                for i in 0...2 {
                    if player.board.field[i][col] == num {
                        player.board.field[i][col] = 0
                    }
                }
            }
        }
    }
    
//    func gameWithComp() {
//        let p1 = Player(), p2 = Opponent(playerBoard: p1.board)
//        while p1.board.checkField() || p2.board.checkField() {
//            if step == 1 {
////                ходит игрок
//                step = 2
//                playerTurn(p1)
//            } else {
////                ходит компьютер
//                step = 1
//                computerTurn(p2)
//            }
//            print("\nПоле противника")
//            p2.board.viewField()
//            print("Ваше поле")
//            p1.board.viewField()
//            print("---------------------------------")
//        }
//    }
    
//    func gameWithPlayer() {
//        let p1 = Player(), p2 = Player()
//        if step == 1{
//            step = 2
//            playerTurn(p1)
//        } else {
//            step = 1
//            playerTurn(p2)
//        }
//        print("Поле Игрока 2")
//        p2.board.viewField()
//        print("Поле Игрока 1")
//        p1.board.viewField()
//        print("---------------------------------")
//    }
    
}

