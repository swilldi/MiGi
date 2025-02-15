//
//  Opponent.swift
//  MiGi
//
//  Created by Дмитрий on 01.01.2024.
//

import Foundation

class Opponent: Player {
    let playerBoard: Board
    var lastStep = [Int]()
    
    init(playerBoard: Board) {
            self.playerBoard = playerBoard
        }
    
     func makeMove(num: Int) {
        let col = findMaxCol()
        for i in 0...2 {
            if board.field[i][col] == 0 {
                board.field[i][col] = num
                lastStep = [i, col]
                break
            }
        }
        pointUpdate()
    }
    
    func findMaxCol() -> Int {
        let col = playerBoard.getCol()
        let myCol = board.getCol()
        let sumCol = [playerBoard.scoreColPoint(col[0]), playerBoard.scoreColPoint(col[1]), playerBoard.scoreColPoint(col[2])].sorted()
        let quantitySum = Set(sumCol).count
        var maxSum: Int, medSum: Int
        var locationMaxMin: Dictionary<String, Int> = [:]
        
        if quantitySum == 3 {
            maxSum = sumCol[2]
            medSum = sumCol[1]
            for i in 0...2 {
                if playerBoard.scoreColPoint(col[i]) == maxSum {locationMaxMin["max"] = i}
                else if playerBoard.scoreColPoint(col[i]) == medSum {locationMaxMin["med"] = i}
                else {locationMaxMin["min"] = i}
            }
            if myCol[locationMaxMin["max"]!].contains(0) {
                return locationMaxMin["max"]!
            } else if myCol[locationMaxMin["med"]!].contains(0) {
                return locationMaxMin["med"]!
            } else {
                return locationMaxMin["min"]!
            }
            
        } else if quantitySum == 2 {
            maxSum = sumCol[2]
            for i in 0...2 {
                if playerBoard.scoreColPoint(col[i]) == maxSum {locationMaxMin["max"] = i}
                else {locationMaxMin["min"] = i}
            }
            if myCol[locationMaxMin["max"]!].contains(0) {
                return locationMaxMin["max"]!
            } else {
                return locationMaxMin["min"]!
            }
            
        } else {
            for i in 0...2 {
                if col[i].contains(0) {
                    return i
                }
            }
        }
        
        return 0
        
        
        
        
        
        
    
//    func findMaxCol() -> Int{
//        let col = playerBoard.getCol()
//        let sumCol: Array<Int> = [playerBoard.scoreColPoint(col[0]), playerBoard.scoreColPoint(col[1]), playerBoard.scoreColPoint(col[2])]
//        var locationMaxMin: Dictionary<String, Int> = [:]
//        let maxSum = sumCol.max()!
//        let minSum = sumCol.min()!
//
//        let quantityDifferentCol = Set(sumCol).count
//
//        if quantityDifferentCol == 1 {
//            for i in 0...2 {
//                if col[i].contains(0) {
//                    return i
//                }
//            }
//        } else if quantityDifferentCol == 2 {
//            var colMax = Array<Int>()
//            var colMin = Array<Int>()
//            for i in 0...2 {
//                if sumCol[i] == maxSum {
//                    colMax.append(i)
//                } else {
//                    colMin.append(i)
//                }
//            }
//
//            for i in colMax {
//                if col[i].contains(0) {
//                    return i
//                }
//            }
//            for i in colMin {
//                if col[i].contains(0) {
//                    return i
//                }
//            }
//
//        } else {
//
//            for i in 0...2 {
//                if sumCol[i] == maxSum {
//                    locationMaxMin["max"] = i
//                } else if sumCol[i] == minSum {
//                    locationMaxMin["min"] = i
//                } else {
//                    locationMaxMin["med"] = i
//                }
//            }
//
//            if col[locationMaxMin["max"]!].contains(0) {
//                return locationMaxMin["max"]!
//            } else if col[locationMaxMin["min"]!].contains(0) {
//                return locationMaxMin["min"]!
//            } else {
//                return locationMaxMin["med"]!
//            }
//        }
//        return 0
//        for i in 0...2 {
//            if sumCol[i] == maxSum {
//                colWithMaxSum = i
//                break
//            }
//        }
//        if colWithMaxSum == 0 {
//            for i in 0...2 {
//                if minSum < sumCol[i], sumCol[i] < maxSum {
//                    colWithMaxSum = i
//                    break
//                }
//            }
//        }
//        if colWithMaxSum == 0 {
//            for i in 0...2 {
//
//            }
//        }
    }
    
}


