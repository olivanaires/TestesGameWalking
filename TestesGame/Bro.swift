//
//  Bro.swift
//  TestesGame
//
//  Created by Olivan Aires on 01/12/15.
//  Copyright © 2015 Olivan Aires. All rights reserved.
//

import Foundation
import SpriteKit

class Bro: SKSpriteNode {
    
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
    
    enum BroFire:Int {
        case bro5_hurt0001, bro5_fire0001, bro5_fire0002, bro5_fire0003, bro5_fire0004, bro5_fire0005
    }
    
    enum BroRun:Int {
        case bro5_hurt0001, bro5_run0001, bro5_run0002, bro5_run0003, bro5_run0004, bro5_run0005, bro5_run0006, bro5_run0007
    }
    
    var currentStateFire = BroFire.bro5_hurt0001
    var currentStateRun = BroRun.bro5_hurt0001
    
    func stepStateFire(){
        switch currentStateFire {
        case .bro5_hurt0001:
            currentStateFire = .bro5_fire0001
            let newTexture = SKTexture(imageNamed: "bro5_fire0001")
            self.texture = newTexture
        case .bro5_fire0001:
            currentStateFire = .bro5_fire0002
            let newTexture = SKTexture(imageNamed: "bro5_fire0002")
            self.texture = newTexture
        case .bro5_fire0002:
            currentStateFire = .bro5_fire0003
            let newTexture = SKTexture(imageNamed: "bro5_fire0003")
            self.texture = newTexture
        case .bro5_fire0003:
            currentStateFire = .bro5_fire0004
            let newTexture = SKTexture(imageNamed: "bro5_fire0004")
            self.texture = newTexture
        case .bro5_fire0004:
            currentStateFire = .bro5_fire0005
            let newTexture = SKTexture(imageNamed: "bro5_fire0005")
            self.texture = newTexture
        case .bro5_fire0005:
            currentStateFire = .bro5_fire0001
            let newTexture = SKTexture(imageNamed: "bro5_fire0001")
            self.texture = newTexture
        }
    }
    
    func stepStateRun(){
        switch currentStateRun {
        case .bro5_hurt0001:
            currentStateRun = .bro5_run0001
            let newTexture = SKTexture(imageNamed: "bro5_run0001")
            self.texture = newTexture
        case .bro5_run0001:
            currentStateRun = .bro5_run0002
            let newTexture = SKTexture(imageNamed: "bro5_run0002")
            self.texture = newTexture
        case .bro5_run0002:
            currentStateRun = .bro5_run0003
            let newTexture = SKTexture(imageNamed: "bro5_run0003")
            self.texture = newTexture
        case .bro5_run0003:
            currentStateRun = .bro5_run0004
            let newTexture = SKTexture(imageNamed: "bro5_run0004")
            self.texture = newTexture
        case .bro5_run0004:
            currentStateRun = .bro5_run0005
            let newTexture = SKTexture(imageNamed: "bro5_run0005")
            self.texture = newTexture
        case .bro5_run0005:
            currentStateRun = .bro5_run0006
            let newTexture = SKTexture(imageNamed: "bro5_run0006")
            self.texture = newTexture
        case .bro5_run0006:
            currentStateRun = .bro5_run0007
            let newTexture = SKTexture(imageNamed: "bro5_run0007")
            self.texture = newTexture
        case .bro5_run0007:
            currentStateRun = .bro5_run0001
            let newTexture = SKTexture(imageNamed: "bro5_run0001")
            self.texture = newTexture
        }
    }
    
    
    
    func updateBroFire() {
        if currentStateFire != .bro5_hurt0001 {
            stepStateFire()
        }
    }
    
    var voltando: Bool = false
    func updateBroRun(frameWidth: CGFloat) {
        if currentStateRun != .bro5_hurt0001 {
            let positionX = self.position.x
            if positionX > frameWidth - 300  && !self.voltando {
                self.xScale = self.xScale * -1
                self.voltando = true
            } else if positionX < 200  && self.voltando{
                self.xScale = self.xScale * -1
                self.voltando = false
            }
            
            if positionX < frameWidth - 300 && !self.voltando {
                self.position = CGPoint(x: self.position.x+4, y: self.position.y)
            } else if positionX > 200 && self.voltando {
                self.position = CGPoint(x: self.position.x-4, y: self.position.y)
            }

            stepStateRun()
        }
    }
    
    func updateAcao(location: CGPoint) -> String {
        if location.x < 300 {
            self.currentStateFire = Bro.BroFire.bro5_fire0001
            return "fire"
        }
        else if location.x > 700 {
            self.currentStateRun = Bro.BroRun.bro5_run0001
            return "run"
        } else {
            self.currentStateRun = Bro.BroRun.bro5_hurt0001
            let newTexture = SKTexture(imageNamed: "bro5_hurt0001")
            self.texture = newTexture
            return "parado"
        }
    }
    
}
