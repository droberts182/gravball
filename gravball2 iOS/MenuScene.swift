//
//  MenuScene.swift
//  gravball2 iOS
//
//  Created by Daniel Roberts on 6/23/25.
//

import SpriteKit
import SwiftUI
import CoreMotion
import GameKit

class MenuScene: SKScene{
    private var gameCenterManager: GameCenterManager!
    private var backgroundMenu: SKSpriteNode!
    private var menuBall: SKSpriteNode!
    private var gravballNode: SKSpriteNode!
    private var startNode: SKSpriteNode!
    private var scoresNode: SKSpriteNode!
    private var positioningStartNode: CGFloat = 1.5
    private var positioningScoresNode: CGFloat = 0.5
    
    func createStarTexture() -> SKTexture {
            let size = CGSize(width: 32, height: 32)
            UIGraphicsBeginImageContextWithOptions(size, false, 0)
            let context = UIGraphicsGetCurrentContext()!
            
            // Draw a white star
            context.setFillColor(UIColor.white.cgColor)
            let path = UIBezierPath()
            let center = CGPoint(x: 16, y: 16)
            let radius: CGFloat = 12
            for i in 0..<5 {
                let angle = CGFloat(i) * .pi / 2.5 - .pi / 2
                let point = CGPoint(
                    x: center.x + radius * cos(angle),
                    y: center.y + radius * sin(angle)
                )
                if i == 0 {
                    path.move(to: point)
                } else {
                    path.addLine(to: point)
                }
            }
            path.close()
            context.addPath(path.cgPath)
            context.fillPath()
            
            let image = UIGraphicsGetImageFromCurrentImageContext()!
            UIGraphicsEndImageContext()
            return SKTexture(image: image)
        }
    
    func makeParticle()
    {
        let sparkEmitter = SKEmitterNode()
                
                // Use programmatic star texture
                sparkEmitter.particleTexture = createStarTexture()
                sparkEmitter.particleBirthRate = 50 // Extremely dense
                sparkEmitter.numParticlesToEmit = 0 // Continuous
                sparkEmitter.particleLifetime = 0.2
        sparkEmitter.particleLifetimeRange = 0.2
                sparkEmitter.emissionAngle = 0
                sparkEmitter.emissionAngleRange = 2 * .pi
                sparkEmitter.particleSpeed = 200
                sparkEmitter.particleSpeedRange = 100
                sparkEmitter.particlePositionRange = CGVector(dx: 5, dy: 5)
                sparkEmitter.particleScale = 0.3 // Huge particles
                sparkEmitter.particleScaleRange = 0.2
                sparkEmitter.particleScaleSpeed = -0.2
                sparkEmitter.particleAlpha = 1.0
                sparkEmitter.particleAlphaSpeed = -0.5
                sparkEmitter.particleColor = .red // White for max brightness
                sparkEmitter.particleColorBlendFactor = 1.0
                sparkEmitter.particleBlendMode = .add
                sparkEmitter.yAcceleration = -100
                sparkEmitter.position = CGPoint(x: size.width / 2, y: size.height / 2)
                sparkEmitter.zPosition = 100
                
                addChild(sparkEmitter)
    
    }
    
    func setupMenuScene()
    {
        backgroundMenu = SKSpriteNode(imageNamed: "startscreen.png")
        
        // Set position to center of scene with 150-point upward offset
        backgroundMenu.position = CGPoint(x: self.size.width / 2, y: self.size.height / 2)
 
        // Add sprite to scene with zPosition
        self.addChild(backgroundMenu)
        backgroundMenu.zPosition = 2
        
        startNode = SKSpriteNode(imageNamed: "start.png")
        
        // Set position to center of scene with 150-point upward offset
        startNode.position = CGPoint(x: self.size.width / 2, y: (self.size.height / 2) * positioningStartNode)
        startNode.name = "startNode"
        
        // Add sprite to scene with zPosition
        self.addChild(startNode)
        startNode.zPosition = 4
        
        scoresNode = SKSpriteNode(imageNamed: "scores.png")
        
        // Set position to center of scene with 150-point upward offset
        scoresNode.position = CGPoint(x: self.size.width / 2, y: (self.size.height / 2) * positioningScoresNode)
        scoresNode.name = "scoresNode"
 
        // Add sprite to scene with zPosition
        self.addChild(scoresNode)
        scoresNode.zPosition = 4
        
        menuBall = SKSpriteNode(imageNamed: "menu_ball.png")
        
        // Set position to center of scene with 150-point upward offset
        menuBall.position = CGPoint(x: self.size.width / 2, y: self.size.height / 2)
      
        // Add sprite to scene with zPosition
        self.addChild(menuBall)
        menuBall.zPosition = 3
        
        gravballNode = SKSpriteNode(imageNamed: "gravball.png")
        
        // Set position to center of scene with 150-point upward offset
        gravballNode.position = CGPoint(x: self.size.width / 2, y: self.size.height / 2)
      
        // Add sprite to scene with zPosition
        self.addChild(gravballNode)
        gravballNode.zPosition = 4
        
        makeParticle()
    }
    
    init(size: CGSize, gameCenterManager: GameCenterManager) {
            super.init(size: size)
        self.gameCenterManager = gameCenterManager
        setupMenuScene()
        }
    
    required init?(coder aDecoder: NSCoder) {
            fatalError("init(coder:) has not been implemented")
        }

    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
            // Transition to GameScene on tap
        Utility.shared.getLevelParameters()
        Utility.shared.setUpGame()
        Utility.shared.setRandomNumBalls()
        guard let touch = touches.first else { return }
        let location = touch.location(in: self)
        let touchedNode = atPoint(location)

        if touchedNode.name == "startNode" {
            let gameScene = GameScene(size: self.size, game: Utility.shared.returnGame(), gameCenterManager: gameCenterManager)

            let textures = [
                        SKTexture(imageNamed: "start"),
                        SKTexture(imageNamed: "start_lit")
                    ]
            let finalTexture = SKTexture(imageNamed: "start_lit") // Replace with your desired texture
                    
                    // Create the animation action
                    let animation = SKAction.animate(with: textures, timePerFrame: 0.1) // 0.1 seconds per frame
                    
                    // Set the final texture
                    let setFinalTexture = SKAction.setTexture(finalTexture)
                    
                    // Sequence: animate once, then set final texture
                    let sequence = SKAction.sequence([animation, setFinalTexture])
                    
                    // Run the sequence
                    startNode.run(sequence)
            
            let transition = SKAction.run {
                let transition = SKTransition.crossFade(withDuration: 1.0)
                self.view?.presentScene(gameScene, transition: transition)
                    }
                    
                    // Sequence: animate, then transition
                    let sequence2 = SKAction.sequence([sequence, transition])
            startNode.run(sequence2)
        }
        else if touchedNode.name == "scoresNode"
        {
            let textures = [
                        SKTexture(imageNamed: "scores"),
                        SKTexture(imageNamed: "scores_lit"),
                        SKTexture(imageNamed: "scores")
                    ]
            let finalTexture = SKTexture(imageNamed: "scores_lit") // Replace with your desired texture
                    
                    // Create the animation action
                    let animation = SKAction.animate(with: textures, timePerFrame: 0.3) // 0.1 seconds per frame
                    
                    // Set the final texture
                    let setFinalTexture = SKAction.setTexture(finalTexture)
                    
                    // Sequence: animate once, then set final texture
                    let sequence = SKAction.sequence([animation, setFinalTexture])
                    
                    // Run the sequence
                    scoresNode.run(animation)
            
            Task {
                print("task started")
                await gameCenterManager.loadLeaderboard()
                DispatchQueue.main.async { [weak self] in
                    self?.gameCenterManager.showLeaderboardSheet = true
                }
            }
        }
        
       
        
        }
}
