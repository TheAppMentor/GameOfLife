//
//  ViewController.swift
//  GoL
//
//  Created by Moorthy, Prashanth on 28/01/20.
//  Copyright © 2020 Moorthy, Prashanth. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var queueSize: UILabel!
    @IBOutlet weak var generation: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    
    var grid = Grid()
    var currentGeneration : Int = 0 {
        didSet {
            generation.text = String(describing : currentGeneration)
        }
    }
    let cellSize : CGFloat = 10.0
    var startTime : Date!
    
    override func viewWillAppear(_ animated: Bool) {
        // 3 line pattern
//        grid[1,2].cellState = .alive
//        grid[2,2].cellState = .alive
//        grid[3,2].cellState = .alive

        // R-Pentanimo
        grid[1,3].cellState = .alive
        grid[1,2].cellState = .alive
        grid[2,1].cellState = .alive
        grid[2,2].cellState = .alive
        grid[3,2].cellState = .alive

        
        // R-Pentanimo
        grid[20,3].cellState = .alive
        grid[21,3].cellState = .alive
        grid[22,3].cellState = .alive
        grid[20,4].cellState = .alive
        grid[21,2].cellState = .alive

        // R-Pentanimo
        grid[20,10].cellState = .alive
        grid[21,10].cellState = .alive
        grid[22,10].cellState = .alive
        grid[20,11].cellState = .alive
        grid[21,9].cellState = .alive

        
        // R-Pentanimo
        grid[30,20].cellState = .alive
        grid[31,20].cellState = .alive
        grid[32,20].cellState = .alive
        grid[30,21].cellState = .alive
        grid[31,19].cellState = .alive

        
        
        let gridLayer = GridRenderer.render(grid: grid, gridDimension: CGSize(), cellWidthHeight: cellSize)
        self.view.layer.addSublayer(gridLayer)
        gridLayer.name = "CurrentGrid"
        gridLayer.position = self.view.center
        
        startTime = Date()
        
        // Push the initial state on to the render queue.
        gridQueue.enqueue(grid)

        // Spin up the background process to genererate grids
        backgroundQueue.async {
            self.pushNextStateToQueue(currentGrid: self.grid)
        }
            
        Timer.scheduledTimer(withTimeInterval: 1.0, repeats: true) {_ in
            DispatchQueue.main.async {

                // Prashanht : This is not right. THis is where we need to check for the stable state.
                if self.gridQueue.isEmpty {
                    assertionFailure("QUEUE IS EMPTY !!!! ")
                }
                
                if let nextGrid = self.gridQueue.dequeue() {
                    self.queueSize.text = String(describing: self.gridQueue.count)
                    let newGridLayer = GridRenderer.render(grid: nextGrid, gridDimension: CGSize(), cellWidthHeight: self.cellSize)
                    self.view.layer.sublayers?.removeAll(where: { $0.name == "CurrentGrid"})
                                        
                    self.grid = nextGrid
                    
                    newGridLayer.name = "CurrentGrid"
                    self.view.layer.addSublayer(newGridLayer)
                    newGridLayer.position = self.view.center
                    self.currentGeneration += 1
                }                
            }
        }
    }
        
    func getNextGrid(currentGrid : Grid) -> Grid {
        var grid = Grid()
        
        let colCount = grid.GRID_COL_COUNT
        let rowCount = grid.GRID_ROW_COUNT
        
        Array(0..<rowCount).forEach { row in
            Array(0..<colCount).forEach { col in

                grid[row,col].cellState = try! GameOfLifeRulesEngine().getNextState(for: currentGrid[row,col], liveNeighbourCount: currentGrid.getLivingNeighbourCount(row: row, col: col))
            }
        }
        
        if isGridStable(oldGrid: currentGrid, newGrid: grid) {
            //print("Grid is stable man")
            //assertionFailure("Grid is stable")
        }
        
        return grid
    }
    
    func isGridStable(oldGrid : Grid, newGrid : Grid) -> Bool {
        
        let colCount = grid.GRID_COL_COUNT
        let rowCount = grid.GRID_ROW_COUNT
        
        var result = true
        
        // This can be done concurrently
        outerLoop : for row in Array(0..<rowCount) {
            for col in Array(0..<colCount) {
                if oldGrid[row,col].cellState != newGrid[row,col].cellState {
                    result = false
                    break outerLoop
                }
            }
        }
                
        return result
    }
    
    var gridQueue = Queue<Grid>()
    let QUEUE_SIZE_LIMIT = 1000
    let backgroundQueue = DispatchQueue.global(qos: .userInitiated)
    
    //Prashanth : Make a queue visualizer.. to show how stuff is being added to and pulled fromo the queue for rendering..
    // That will be cool.
    // https://stackoverflow.com/questions/18753091/how-can-i-put-data-in-to-a-queue-and-read-it-at-the-same-time
        
    func pushNextStateToQueue(currentGrid : Grid) {
        if gridQueue.count >= QUEUE_SIZE_LIMIT {
            print("Queue is full : \(gridQueue.count)")
            print("Time : \(Date().timeIntervalSince(startTime))")
            return
        }

        let tempGrid = getNextGrid(currentGrid: currentGrid)
        gridQueue.enqueue(tempGrid)
        
        DispatchQueue.main.async {
            self.queueSize.text = String(describing: self.gridQueue.count)
        }
        
        backgroundQueue.async {
            self.pushNextStateToQueue(currentGrid: tempGrid)
        }
    }

    let concurrentQueue = DispatchQueue(label: "com.prash.GOLRulesQueue", qos: .userInitiated, attributes: .concurrent, autoreleaseFrequency: .inherit, target: nil)
}

