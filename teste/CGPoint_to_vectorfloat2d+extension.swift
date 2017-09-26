//
//  CGPoint_to_vectorfloat2d+extension.swift
//  teste
//
//  Created by Edson  Jr on 26/09/17.
//  Copyright © 2017 Edson  Jr. All rights reserved.
//

import Foundation
import UIKit
import SpriteKit
import  GameplayKit


extension CGPoint {
    init(_ point: float2) {
        x = CGFloat(point.x)
        y = CGFloat(point.y)
        
        //talvez nao funcione
    }
}

extension float2 {
    init(_ point: CGPoint) {
        self.init(x: Float(point.x), y: Float(point.y))
    }
}
