//
//  GameScene.swift
//  TestesGame
//
//  Created by Olivan Aires on 30/11/15.
//  Copyright (c) 2015 Olivan Aires. All rights reserved.
//

import SpriteKit

class GameScene: SKScene, SKPhysicsContactDelegate {
    
    var broNode: Bro?
    var currentPositionX: CGFloat?
    var touchLocation: CGPoint?
    var myWorld: SKNode = SKNode()

    var acao: String = "parado"
    var lastYieldTimeInterval: NSTimeInterval = NSTimeInterval()
    var lastUpdateTimeInterval: NSTimeInterval = NSTimeInterval()
    
    let photonTorpedoCategory: UInt32 = 0x1 << 0
    
    override func didMoveToView(view: SKView) {
       
        broNode = Bro(imageNamed: "bro5_hurt0001")
        broNode!.position = CGPointMake(300, 600)
        broNode?.name = "heroi"
        addChild(broNode!)
    
        currentPositionX = broNode!.position.x
        
        self.physicsWorld.gravity = CGVectorMake(0, 0)
        self.physicsWorld.contactDelegate = self
        self.anchorPoint = CGPointMake (0.5,0.5)
        self.view?.frameInterval = 3
        
    }
    
    override func didSimulatePhysics() {
    
    }
    
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
        
    }
    override func touchesEnded(touches: Set<UITouch>, withEvent event: UIEvent?) {
        
        for touch in touches {
            
            touchLocation = touch.locationInNode(self)
            acao = "anda"
            
            // ponto de destino
            let offSet: CGPoint = vecSub(touchLocation!, b: broNode!.position)
            let direction: CGPoint = vecNoramlize(offSet)
            let shotLength: CGPoint = vecMult(direction, b: 1000)
            let finalDestination: CGPoint = vecAdd(shotLength, b: broNode!.position)
            
            // velocidade do deslocamento
            let velocity = 100/1
            let moveDuration: Float = Float(self.size.width) / Float(velocity)
            
            var actionArray: [SKAction] = []
            actionArray.append(SKAction.moveTo(finalDestination, duration: NSTimeInterval(moveDuration)))
            actionArray.append(SKAction.removeFromParent())
            
            broNode!.runAction(SKAction.sequence(actionArray), withKey: "acaoAnda")
            
            if currentPositionX >= touchLocation!.x {
                if broNode!.xScale > 0 {
                    broNode!.xScale = broNode!.xScale * -1
                }
            } else if currentPositionX <= touchLocation!.x {
                if broNode!.xScale < 0 {
                    broNode!.xScale = broNode!.xScale * -1
                }
            }
            
        }
        
    }
    
    var frenteX: Bool = true
    override func update(currentTime: NSTimeInterval) {
        
        
        
        
        self.enumerateChildNodesWithName("heroi",  usingBlock: {
            node, stop in
        
            
            if let bro = node as? Bro {
                if self.acao == "anda" {
                    bro.stepStateRun()
                } else {
                    let newTexture = SKTexture(imageNamed: "bro5_hurt0001")
                    bro.texture = newTexture
                }
            }
            
            // valida direção da acao
            let positionX = self.touchLocation?.x
            if self.currentPositionX > positionX {
                self.frenteX = false
            } else {
                self.frenteX = true
            }
            
            // define quando deve parar a acao
            if self.frenteX {
                if node.position.x >= positionX {
                    node.removeActionForKey("acaoAnda")
                    self.currentPositionX = node.position.x
                    self.acao = "parado"
                }
            } else if !self.frenteX {
                if node.position.x <= positionX {
                    node.removeActionForKey("acaoAnda")
                    self.currentPositionX = node.position.x
                    self.acao = "parado"
                    
                }
            }
            
        })
        
    }
    
    func vecAdd(a: CGPoint, b: CGPoint) -> CGPoint {
        return CGPointMake(a.x + b.x, a.y + b.y)
    }
    
    func vecSub(a: CGPoint, b: CGPoint) -> CGPoint {
        return CGPointMake(a.x - b.x, a.y - b.y)
    }
    
    func vecMult(a: CGPoint, b: CGFloat) -> CGPoint {
        return CGPointMake(a.x * b, a.y * b)
    }
    
    func vecLength (a:CGPoint)->CGFloat{
        return CGFloat(sqrtf(CFloat(a.x) * CFloat(a.x) + CFloat(a.y) * CFloat(a.y)));
    }
    
    func vecNoramlize (a:CGPoint)->CGPoint{
        let length:CGFloat = self.vecLength(a)
        return CGPointMake(a.x / length, a.y / length);
    }

}
