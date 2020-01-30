//
//  GridTest.swift
//  GoL
//
//  Created by Moorthy, Prashanth on 29/01/20.
//  Copyright © 2020 Moorthy, Prashanth. All rights reserved.
//

import XCTest

class GridTest: XCTestCase {

    var grid : Grid!
    
    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.
        grid = Grid()
        grid.GRID_ROW_COUNT = 3
        grid.GRID_COL_COUNT = 3
    }
    
    func testGridSubScript1() {
        let topCornerCell = grid[0,0]
        XCTAssertTrue(topCornerCell.cellState == .dead)
        XCTAssertTrue(grid.getNeighbours(row: 0, col: 0).count == 3)
    }

    // Cell bottom of to Top corner should exist
    func testGridSubScript2() {
        let topCornerCell = grid[0,0]
        grid[1,0].cellState = .alive
        
        XCTAssertTrue(topCornerCell.cellState == .dead)
        XCTAssertTrue(grid.getNeighbours(row: 0, col: 0).count == 3)
        
        let neighbours = grid.getNeighbours(row: 0, col: 0)
        let bottomCell = neighbours.filter { $0.isAlive }
        let liveCellCount = neighbours.filter {$0.isAlive }
        
        XCTAssertTrue(liveCellCount.count == 1)
        XCTAssertTrue(bottomCell.first!.isAlive)
    }

    func testNeighorCountTopRightCornerCell() {
        let neighbours = grid.getNeighbours(row: 0, col: grid.GRID_COL_COUNT - 1)
        XCTAssertTrue(neighbours.count == 3)
    }

    func testNeighorCountTopLeftCornerCell() {
        let neighbours = grid.getNeighbours(row: 0, col: 0)
        XCTAssertTrue(neighbours.count == 3)

    }
    func testNeighorCountBottomRightCornerCell() {
        let neighbours = grid.getNeighbours(row: grid.GRID_ROW_COUNT - 1, col: grid.GRID_COL_COUNT - 1)
        XCTAssertTrue(neighbours.count == 3)

    }
    
    func testNeighorCountBottomLeftCornerCell() {
        let neighbours = grid.getNeighbours(row: grid.GRID_ROW_COUNT - 1, col: 0)
        XCTAssertTrue(neighbours.count == 3)
    }

    func testNeighorCountCenterCell() {
        let neighbours = grid.getNeighbours(row: 1, col: 1)
        XCTAssertTrue(neighbours.count == 8)
    }

    func testNeighorStateCenterCell() {
        grid[0,1].cellState = .alive
        let neighbours = grid.getNeighbours(row: 1, col: 1)
        XCTAssertTrue(neighbours.count == 8)
        XCTAssertTrue(grid.getLivingNeighbourCount(row: 1, col: 1) == 1)
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

}
