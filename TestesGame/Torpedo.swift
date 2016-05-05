//
//  Torpedo.swift
//  TestesGame
//
//  Created by Olivan Aires on 02/12/15.
//  Copyright © 2015 Olivan Aires. All rights reserved.
//

import Foundation
import SpriteKit

class Torpedo: SKSpriteNode {
    
    init (imageNamed: String ) {
        let imageTexture = SKTexture(imageNamed: imageNamed)
        super.init (texture: imageTexture, color: UIColor.blackColor() , size: imageTexture.size())
        
        self.physicsBody = SKPhysicsBody(rectangleOfSize: imageTexture.size())
        self.physicsBody?.dynamic = false
        self.physicsBody?.mass = 1
        
    }
    
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
}