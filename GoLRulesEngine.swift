//
//  GoLRulesEngine.swift
//  GoL
//
//  Created by Moorthy, Prashanth on 28/01/20.
//  Copyright © 2020 Moorthy, Prashanth. All rights reserved.
//

import Foundation

struct GameOfLifeRulesEngine {
    
    // Any live cell with fewer than two live neighbours dies, as if by underpopulation.
    // Any live cell with two or three live neighbours lives on to the next generation.
    // Any live cell with more than three live neighbours dies, as if by overpopulation.
    // Any dead cell with exactly three live neighbours becomes a live cell, as if by reproduction.
    

    func getNextState(for cell : Cell, liveNeighbourCount : Int) throws -> CellState {
                            
        guard liveNeighbourCount <= 8 else { throw GOLError.inCorrectNeighbourCount }

        // Any dead cell with exactly three live neighbours becomes a live cell, as if by reproduction.
        if cell.isDead {
            if liveNeighbourCount == 3 {
                return .alive
            }
            return .dead
        }
        
        if cell.isAlive {
            // Any live cell with more than three live neighbours dies, as if by overpopulation.
            if liveNeighbourCount > 3 {
                return .dead
            }
            
            // Any live cell with two or three live neighbours lives on to the next generation.
            if liveNeighbourCount == 2 || liveNeighbourCount == 3 {
                return .alive
            }
            
            // Any live cell with fewer than two live neighbours dies, as if by underpopulation.
            if liveNeighbourCount < 2 {
                return .dead
            }
        }
        
        throw GOLError.uncaughtException

    }
    
    /*
    func getNextState(for cell : Cell, neighbours : [Cell] ) throws -> CellState {
        guard neighbours.count <= 8 else { throw GOLError.inCorrectNeighbourCount }
        guard !neighbours.isEmpty else { throw GOLError.cellHasNoNeighbours }

        let livingCells = neighbours.filter({ $0.isAlive })

        // Any dead cell with exactly three live neighbours becomes a live cell, as if by reproduction.
        if cell.isDead {
            if livingCells.count == 3 {
                return .alive
            }
            return .dead
        }
        
        if cell.isAlive {
            // Any live cell with more than three live neighbours dies, as if by overpopulation.
            if livingCells.count > 3 {
                return .dead
            }
            
            // Any live cell with two or three live neighbours lives on to the next generation.
            if livingCells.count == 2 || livingCells.count == 3 {
                return .alive
            }
            
            // Any live cell with fewer than two live neighbours dies, as if by underpopulation.
            if livingCells.count < 2 {
                return .dead
            }
        }
        
        throw GOLError.uncaughtException
    }
 */
}

enum GOLError : Error {
    case inCorrectNeighbourCount
    case cellHasNoNeighbours
    case uncaughtException
}
