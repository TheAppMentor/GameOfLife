//
//  GridRenderer.swift
//  GoL
//
//  Created by Moorthy, Prashanth on 29/01/20.
//  Copyright © 2020 Moorthy, Prashanth. All rights reserved.
//

import Foundation
import UIKit

struct GridRenderer {
        
    // Note, we wil try not to render the white cells. Only render cells that are alive.
    // Will improve redraw efficiency.
    static func render(grid : Grid, gridDimension : CGSize, cellWidthHeight : CGFloat) -> CALayer {
        
        let gridRenderStartTime = Date()
        
        let colCount = grid.GRID_COL_COUNT
        let rowCount = grid.GRID_ROW_COUNT

        let containerLayer = CALayer()
        containerLayer.frame = CGRect(origin: .zero,
                                      size: CGSize(width: CGFloat(rowCount) * cellWidthHeight, height: CGFloat(colCount) * cellWidthHeight))
        
        
        Array(0..<rowCount).forEach { row in
            Array(0..<colCount).forEach { col in
                let cellLayer = CellRenderer.render(cell: grid[row,col], dimension: cellWidthHeight)
                let xCoord = CGFloat(col) * cellWidthHeight
                let yCoord = CGFloat(row) * cellWidthHeight
                cellLayer.frame = CGRect(origin: CGPoint(x: xCoord, y: yCoord),
                                         size: CGSize(width: cellWidthHeight, height: cellWidthHeight))
                containerLayer.addSublayer(cellLayer)
            }
        }

        print("Generate Grid Time : \(Date().timeIntervalSince(gridRenderStartTime))")
        return containerLayer
    }
}

extension CALayer {
    var center : CGPoint {
        return CGPoint(x: bounds.midX, y: bounds.midY)
    }
}
