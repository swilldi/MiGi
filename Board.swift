//
//  Board.swift
//  MiGi
//
//  Created by Дмитрий on 15.01.2024.
//

import Foundation

class Board {
    var field: Array<Array<Int>> = [[0, 0, 0],
                                    [0, 0, 0],
                                    [0, 0, 0]]
    
    
    //    проверяет заполнено ли полностью доска
    func checkField() -> Bool {
        for row in 0..<3 {
            if field[row].contains(0) {
                return true
            }
        }
        return false
    }
    
    //    просто чтобы увидеть доску
    func viewField() {
        for row in 0..<3 {
            print(field[row])
//            Thread.sleep(forTimeInterval: 0.3)
        }
        print()
    }
    
//    возвращает массив с массивами колонок
    func getCol() -> Array<Array<Int>> {
        var arrCol: Array<Array<Int>> = []
        for col in 0...2 {
            let col = [field[0][col], field[1][col], field[2][col]]
            arrCol.append(col)
        }
        return arrCol
    }
    
//    возвращает количество очков всего поля
    func scorePoint() -> Int {
        var points = 0
        for col in getCol() {
            points += scoreColPoint(col)
        }
        return points
    }
    
//    возвращает количество очков на отдельной колонке
    func scoreColPoint(_ entryCol: Array<Int>) -> Int {
        let col = entryCol.sorted()
        var points = 0
//        print(col)
        let quantityNum = Set(col).count
        
        if quantityNum == 1 {
            points += col[0] * 9
        } else if quantityNum == 3 {
            points += col[0] + col[1] + col[2]
        } else {
            if col[0] == col[1] {
                points += col[0] * 4 + col[2]
            } else {
                points += col[0] + col[1]  * 4
            }
        }
        return points
    }
    
}

