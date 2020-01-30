//
//  Grid.swift
//  GoL
//
//  Created by Moorthy, Prashanth on 28/01/20.
//  Copyright © 2020 Moorthy, Prashanth. All rights reserved.
//

import Foundation
import UIKit

struct Grid : CustomStringConvertible {
        
    var GRID_ROW_COUNT : Int = 40
    var GRID_COL_COUNT : Int = 40
    
    // This can just be array of Int
    private var cells : [[Cell]]!
    
    init() {
       cells = Array(repeating:
            Array(repeating: Cell(cellState: .dead), count: GRID_ROW_COUNT), count: GRID_COL_COUNT)
    }
    
    func getLivingNeighbourCount(row : Int, col : Int) -> Int {
        return
            getNeighbours(row: row, col: col)
            .filter {$0.isAlive}
            .count
    }
    
    // Swift docs has a good example of matrix.
    // https://docs.swift.org/swift-book/LanguageGuide/Subscripts.html
    subscript(_ row : Int, _ col : Int) -> Cell {
         get {
            assert(isSubscriptValid(row: row, col: col), "Index out of range")
            return cells[row][col]
        }

        set {
            assert(isSubscriptValid(row: row, col: col), "Index out of range")
            cells[row][col] = newValue
        }
    }
    
    private func isSubscriptValid(row : Int, col : Int) -> Bool {
        guard
            row < GRID_ROW_COUNT,
            row >= 0,
            col  < GRID_COL_COUNT,
            col >= 0 else {
                return false
        }
        return true
    }

    // Note Prashanth : In Future .. if a cell is dead.. We can ignore it. that way they donot need calc
     private func getNeighbours(row : Int, col : Int) -> [Cell] {
        //let leftCell = cells[row - 1]
        
        let cellArr = [
                getCellAt(getTopCellIndex(row, col)),
                getCellAt(getBottomCellIndex(row, col)),
                getCellAt(getLeftCellIndex(row, col)),
                getCellAt(getRightCellIndex(row, col)),
                getCellAt(getTopLeftCellIndex(row, col)),
                getCellAt(getTopRightCellIndex(row, col)),
                getCellAt(getBottomLeftCellIndex(row, col)),
                getCellAt(getBottomRightCellIndex(row, col)),
        ]
        
        let compacted = cellArr.compactMap({ $0 })
        return compacted
    }
    
    
    //Private get Cell at index
    private  func getCellAt(_ index : (row : Int, col :Int)?) -> Cell? {
        
        guard let index = index else {
            return nil
        }
        return cells[index.row][index.col]
    }
    
    
    // Not prash. by returning the index and not an actual cell.. we can make this more testable. ??
    private func getLeftCellIndex(_ row : Int, _ col : Int) -> (row : Int, col : Int)? {
        guard isSubscriptValid(row: row, col: col)  else {
            return nil
        }

        // For wrapping torroidal grid. return the right most grid.
        if isFirstCol(col: col) {return nil}  //We are already in the left most col
        
        return (row, col - 1)
    }

    private func getRightCellIndex(_ row : Int, _ col : Int) -> (row : Int, col : Int)? {
        guard isSubscriptValid(row: row, col: col)  else {
            return nil
        }
        
        // For wrapping torroidal grid. return the right most grid.
        if isLastCol(col: col) {return nil}
        
        return (row, col + 1)
    }

    private func getTopCellIndex(_ row : Int, _ col : Int) -> (row : Int, col : Int)? {
        guard isSubscriptValid(row: row, col: col)  else {
            return nil
        }
        
        if isFirstRow(row: row) {return nil}
        
        return (row - 1, col)
    }

    private func getBottomCellIndex(_ row : Int, _ col : Int) -> (row : Int, col : Int)? {
        guard isSubscriptValid(row: row, col: col)  else {
            return nil
        }
        
        if isLastRow(row: row) {return nil}
        
        return (row + 1, col)
    }

    private func getTopLeftCellIndex(_ row : Int, _ col : Int) -> (row : Int, col : Int)? {
        guard isSubscriptValid(row: row, col: col)  else {
            return nil
        }
        
        if isFirstRow(row: row) {return nil}
        if isFirstCol(col: col) {return nil}
        
        return (row - 1 , col - 1)
    }

    private func getTopRightCellIndex(_ row : Int, _ col : Int) -> (row : Int, col : Int)? {
        guard isSubscriptValid(row: row, col: col)  else {
            return nil
        }
        
        if isFirstRow(row: row) {return nil}
        if isLastCol(col: col) {return nil}
        
        return (row - 1 , col + 1)
    }
    
    private func getBottomLeftCellIndex(_ row : Int, _ col : Int) -> (row : Int, col : Int)? {
        guard isSubscriptValid(row: row, col: col)  else {
            return nil
        }
        
        if isLastRow(row: row) { return nil }
        if isFirstCol(col: col) { return nil }
        
        return (row + 1 , col - 1)
    }

    private func getBottomRightCellIndex(_ row : Int, _ col : Int) -> (row : Int, col : Int)? {
        guard isSubscriptValid(row: row, col: col)  else {
            return nil
        }
        
        if isLastRow(row: row) { return nil }
        if isLastCol(col: col) { return nil }
        
        return (row + 1 , col + 1)
    }
        
    private func isLastRow (row : Int) -> Bool {
        return row == GRID_ROW_COUNT - 1
    }
    
    private func isFirstRow (row : Int) -> Bool {
        return row == 0
    }

    private func isLastCol (col : Int) -> Bool {
        return col == GRID_COL_COUNT - 1
    }
    
    private func isFirstCol (col : Int) -> Bool {
        return col == 0
    }
    
    var description : String {
        return "Grid man"
    }
}
