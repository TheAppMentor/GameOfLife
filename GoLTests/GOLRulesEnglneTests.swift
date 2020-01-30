//
//  GOLRulesEnglneTests.swift
//  GoLTests
//
//  Created by Moorthy, Prashanth on 28/01/20.
//  Copyright © 2020 Moorthy, Prashanth. All rights reserved.
//

import XCTest

class GOLRulesEnglneTests: XCTestCase {
    
    var leftCell : Cell!
    var rightCell : Cell!
    var topLeftCell : Cell!
    var topCell : Cell!
    var topRightCell : Cell!
    var bottomLeftCell : Cell!
    var bottomCell : Cell!
    var bottomRightCell : Cell!
    
    let golRulesEngine = GameOfLifeRulesEngine()

    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.
        leftCell        = Cell(cellState: .dead)
        rightCell       = Cell(cellState: .dead)
        topLeftCell     = Cell(cellState: .dead)
        topCell         = Cell(cellState: .dead)
        topRightCell    = Cell(cellState: .dead)
        bottomLeftCell  = Cell(cellState: .dead)
        bottomCell      = Cell(cellState: .dead)
        bottomRightCell = Cell(cellState: .dead)
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }
    
//    func testCellMustHaveNeighbours() {
//        let testCell = Cell(cellState: .dead)
//
//        XCTAssertThrowsError(try golRulesEngine.getNextState(for: testCell, neighbours: [])) { error in
//            XCTAssertEqual(error as? GOLError, GOLError.cellHasNoNeighbours)
//        }
//    }
//
//    func testNeighbourCountLessOrEqualThan8() {
//        let testCell = Cell(cellState: .dead)
//        var allNeigbours : [Cell]  = [leftCell,topLeftCell,topCell,topRightCell,rightCell,bottomRightCell,bottomCell,bottomLeftCell]
//        allNeigbours.append(Cell(cellState: .alive))
//
//        XCTAssertThrowsError(try golRulesEngine.getNextState(for: testCell, liveNeighbourCount: allNeigbours)) { error in
//            XCTAssertEqual(error as? GOLError, GOLError.inCorrectNeighbourCount)
//        }
//    }
    
    // Any live cell with fewer than two live neighbours dies, as if by underpopulation.
    // Dead cell with no live neighbours is dead.
    func testCellWithNoNeighbours() {
        let testCell = Cell(cellState: .dead)
                
        var nextCellState : CellState!
        do {
            nextCellState = try golRulesEngine.getNextState(for: testCell, liveNeighbourCount: 0)
        } catch let error {
            XCTFail("Rules Engine threw an Error! =>>> \(error.localizedDescription)")
        }
        XCTAssert(nextCellState == .dead, "Expected Cell to be dead")
    }
    
    // Any dead cell with exactly three live neighbours becomes a live cell, as if by reproduction.
    func testDeadCellWithExactly3NeighboursBecomesAlive() {
        let testCell = Cell(cellState: .dead)
        
        leftCell.cellState      = .alive
        topCell.cellState       = .alive
        bottomCell.cellState    = .alive
        
        var nextCellState : CellState!
        do {
            nextCellState = try golRulesEngine.getNextState(for: testCell, liveNeighbourCount: 3)
        } catch let error {
            XCTFail("Rules Engine threw an Error! =>>> \(error.localizedDescription)")
        }
        XCTAssert(nextCellState == .alive, "Expected Cell to be alive... ")
    }
    
    func testDeadCellWithExactly2LiveNeighboursRemainsDead() {
        let testCell = Cell(cellState: .dead)
        
        leftCell.cellState      = .alive
        topCell.cellState       = .alive
        
        var nextCellState : CellState!
        do {
            nextCellState = try golRulesEngine.getNextState(for: testCell, liveNeighbourCount: 2)
        } catch let error {
            XCTFail("Rules Engine threw an Error! =>>> \(error.localizedDescription)")
        }
        XCTAssert(nextCellState == .dead, "Expected Cell to be dead... ")
    }

    func testDeadCellWithExactly1LiveNeighboursRemainsDead() {
        let testCell = Cell(cellState: .dead)
        
        leftCell.cellState      = .alive
        
        var nextCellState : CellState!
        do {
            nextCellState = try golRulesEngine.getNextState(for: testCell, liveNeighbourCount: 1)
        } catch let error {
            XCTFail("Rules Engine threw an Error! =>>> \(error.localizedDescription)")
        }
        XCTAssert(nextCellState == .dead, "Expected Cell to be dead... ")
    }
    
    // Any dead cell with exactly three live neighbours becomes a live cell, as if by reproduction.
    func testDeadCellWithExactly4NeighboursRemainsDead() {
        let testCell = Cell(cellState: .dead)
        
        leftCell.cellState      = .alive
        topCell.cellState       = .alive
        bottomCell.cellState    = .alive
        bottomRightCell.cellState    = .alive

        var nextCellState : CellState!
        do {
            nextCellState = try golRulesEngine.getNextState(for: testCell, liveNeighbourCount: 4)
        } catch let error {
            XCTFail("Rules Engine threw an Error! =>>> \(error.localizedDescription)")
        }
        XCTAssert(nextCellState == .dead, "Expected Cell to be dead ... ")
    }

    // Any live cell with fewer than two live neighbours dies, as if by underpopulation.
    func testLiveCellWithOnly1LiveNeighboursDies() {
        let testCell = Cell(cellState: .alive)
        
        leftCell.cellState      = .alive
                
        var nextCellState : CellState!
        do {
            nextCellState = try golRulesEngine.getNextState(for: testCell, liveNeighbourCount: 1)
        } catch let error {
            XCTFail("Rules Engine threw an Error! =>>> \(error.localizedDescription)")
        }
        XCTAssert(nextCellState == .dead, "Expected Cell to be dead ... ")
    }

    // Any live cell with fewer than two live neighbours dies, as if by underpopulation.
    func testLiveCellWithZeroLiveNeighboursDies() {
        let testCell = Cell(cellState: .alive)
                        
        var nextCellState : CellState!
        do {
            nextCellState = try golRulesEngine.getNextState(for: testCell, liveNeighbourCount: 0)
        } catch let error {
            XCTFail("Rules Engine threw an Error! =>>> \(error.localizedDescription)")
        }
        XCTAssert(nextCellState == .dead, "Expected Cell to be dead ... ")
    }
    
    // Any live cell with more than three live neighbours dies, as if by overpopulation.
    func testLiveCellWithMoreThanThreeLiveNeighboursDies() {
        let testCell = Cell(cellState: .alive)
                
        leftCell.cellState        = .alive
        rightCell.cellState       = .alive
        topCell.cellState         = .alive
        bottomCell.cellState      = .alive

                
        var nextCellState : CellState!
        do {
            nextCellState = try golRulesEngine.getNextState(for: testCell, liveNeighbourCount: 4)
        } catch let error {
            XCTFail("Rules Engine threw an Error! =>>> \(error.localizedDescription)")
        }
        XCTAssert(nextCellState == .dead, "Expected Cell to be dead ... ")
    }

    // Any live cell with two or three live neighbours lives on to the next generation.
    func testLiveCellWithExactlyTwoLiveNeighboursLives() {
        let testCell = Cell(cellState: .alive)
                
        leftCell.cellState        = .alive
        rightCell.cellState       = .alive

        var nextCellState : CellState!
        do {
            nextCellState = try golRulesEngine.getNextState(for: testCell, liveNeighbourCount: 2)
        } catch let error {
            XCTFail("Rules Engine threw an Error! =>>> \(error.localizedDescription)")
        }
        XCTAssert(nextCellState == .alive, "Expected Cell to be alive ... ")
    }

    // Any live cell with two or three live neighbours lives on to the next generation.
    func testLiveCellWithExactlyThreeLiveNeighboursLives() {
        let testCell = Cell(cellState: .alive)
                
        leftCell.cellState        = .alive
        rightCell.cellState       = .alive
        bottomCell.cellState      = .alive
        
        var nextCellState : CellState!
        do {
            nextCellState = try golRulesEngine.getNextState(for: testCell, liveNeighbourCount: 3)
        } catch let error {
            XCTFail("Rules Engine threw an Error! =>>> \(error.localizedDescription)")
        }
        XCTAssert(nextCellState == .alive, "Expected Cell to be alive ... ")
    }
}
