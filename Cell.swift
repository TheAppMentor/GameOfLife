//
//  Cell.swift
//  GoL
//
//  Created by Moorthy, Prashanth on 28/01/20.
//  Copyright © 2020 Moorthy, Prashanth. All rights reserved.
//

import Foundation
import UIKit

enum CellState {
    case alive
    case dead
}

struct Cell {
        
    var cellState : CellState = .dead
    
    var isAlive : Bool {
        return cellState == .alive
    }

    var isDead : Bool {
        return cellState == .dead
    }
}
