//
//  CellRenderer.swift
//  GoL
//
//  Created by Moorthy, Prashanth on 29/01/20.
//  Copyright © 2020 Moorthy, Prashanth. All rights reserved.
//

import Foundation
import UIKit

struct CellRenderer {
    
    // Note, we wil try not to render the white cells. Only render cells that are alive.
    // Will improve redraw efficiency.
    static func render(cell : Cell, dimension : CGFloat) -> CALayer {
        let cellLayer = CALayer()
        cellLayer.frame = CGRect(origin: .zero, size: CGSize(width: dimension, height: dimension))
        cellLayer.backgroundColor = cell.isAlive ? UIColor.black.cgColor : UIColor.white.cgColor
        cellLayer.borderColor = UIColor(red: 220.0/255.0, green: 220.0/255.0, blue: 220.0/255.0, alpha: 1.0).cgColor
        cellLayer.borderWidth = 0.5
        return cellLayer
    }
}
