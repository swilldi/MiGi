//
//  Player.swift
//  MiGi
//
//  Created by Дмитрий on 01.01.2024.
//

import Foundation

class Player {
    var board: Board
    var mainPoints: Int
    init() {
        self.board = Board()
        self.mainPoints = 0
    }
    
    //    устанавливает число на позицию
    func makeMove(num: Int, _ row: Int, _ col: Int) {
        board.field[row][col] = num
        pointUpdate()
    }
    
    func pointUpdate() {
        mainPoints = board.scorePoint()
    }
}

