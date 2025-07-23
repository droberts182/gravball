//
//  GameScene.swift
//  gravball2 iOS
//
//  Created by Daniel Roberts on 6/23/25.
//

import SpriteKit
import SwiftUI
import CoreMotion
import GameKit

// A simple game scene with falling boxes
class GameScene: SKScene{
    //    var backgroundNode = SKSpriteNode(imageNamed: "images/background.png")
    //
    //    backgroundNode.position = CGPointMake(self.size.width/2, self.size.height/2)
    //    backgroundNode.zPosition = -1
    //    self.addChild(backgroundNode)
    
    private var gameCenterManager: GameCenterManager!
    
    private var distancesYellowGreenRedBlue: [(color: BallColor, value: CGFloat)] = []
    
    private var distancesAquaPurpleYellowGreenRedBlue: [(color: BallColor, value: CGFloat)] = []
    
    private var distancesGreenRedBlue: [(color: BallColor, value: CGFloat)] = []
    
    private var distancesRedBlue: [(color: BallColor, value: CGFloat)] = []
    
       
    
    var ballsArray: [Ball] = []
    
    private var elapsedTime: TimeInterval = 0.0
    
    private var plusOne: SKLabelNode!
    
    private var gravballNode: SKSpriteNode!
    private var levelNode: SKSpriteNode!
    private var timeNode: SKSpriteNode!
    
    private var centerWheel: SKSpriteNode!
    private var centerWheelBack: SKSpriteNode!
    private var controllerLeft:  SKSpriteNode!
    private var controllerRight:  SKSpriteNode!
    private var gravballLabel:  SKLabelNode!
    private var gameOver: SKSpriteNode!
    private var backgroundNode: SKSpriteNode!
    private var levelLabel:  SKLabelNode!
    private var timeLabel:  SKLabelNode!
    
    private var countOne : SKSpriteNode!
    private var countTwo:  SKSpriteNode!
    private var countThree:  SKSpriteNode!
    private var countFour:  SKSpriteNode!
    private var countFive:  SKSpriteNode!
    private var nextLevel:  SKSpriteNode!
    private var menuButton:  SKSpriteNode = SKSpriteNode(imageNamed: "scores2.png")
    
    private var lightUpYellow:  SKSpriteNode = SKSpriteNode(imageNamed: "lightup_yellow.png")
    private var lightUpRed:  SKSpriteNode = SKSpriteNode(imageNamed: "lightup_red.png")
    private var lightUpGreen:  SKSpriteNode = SKSpriteNode(imageNamed: "lightup_green.png")
    private var lightUpBlue:  SKSpriteNode = SKSpriteNode(imageNamed: "lightup_blue.png")
    private var lightUpAqua:  SKSpriteNode = SKSpriteNode(imageNamed: "centerwheel6c_aqua.png")
    private var lightUpPurple:  SKSpriteNode = SKSpriteNode(imageNamed: "centerwheel6c_purple.png")
    
    private var backgroundBlackOut: SKSpriteNode!
    
    private var controllerLeftPoint : CGPoint!
    private var controllerRightPoint : CGPoint!
    private var middleScreenPoint: CGPoint!
    
    private var nextLevelPoint : CGPoint!
    private var menuPoint : CGPoint!
    
    private var ringGlowInner:  SKSpriteNode!
    private var ringGlowOuter:  SKSpriteNode!
    private let motionManager = CMMotionManager()
    private var accelerometerX: CGFloat = 0
    private var accelerometerY: CGFloat = 0
    private let kFilterFactor: CGFloat = 0.55
    private var completedCountdown: Bool = false
    private var levelOver: Bool = false
    private var gameOverFlag: Bool = false
    private var countdownComplete: Bool = false
    
    private var radiansYellow = (GameConstants.sphereAngleYellowCurrent) * CGFloat.pi / 180
    private var radiansGreen = (GameConstants.sphereAngleGreenCurrent) * CGFloat.pi / 180
    private var radiansRed = (GameConstants.sphereAngleRedCurrent) * CGFloat.pi / 180
    private var radiansBlue = (GameConstants.sphereAngleBlueCurrent) * CGFloat.pi / 180
    private var radiansAqua = (GameConstants.sphereAngleAquaCurrent) * CGFloat.pi / 180
    private var radiansPurple = (GameConstants.sphereAnglePurpleCurrent) * CGFloat.pi / 180
    private var radiansDarkSpace1 = (GameConstants.sphereAngleDarkSpace1Current) * CGFloat.pi / 180
    private var radiansDarkSpace2 = (GameConstants.sphereAngleDarkSpace2Current) * CGFloat.pi / 180
    private var radiansDarkSpace3 = (GameConstants.sphereAngleDarkSpace3Current) * CGFloat.pi / 180
    
    private var sheetNode: SKNode?
    private var isSheetPresented = false
    
    private var pointxyellow: CGFloat = 0.0
    private var pointyyellow : CGFloat = 0.0
    private var pointxred: CGFloat = 0.0
    private var pointyred : CGFloat = 0.0
    private var pointxblue : CGFloat = 0.0
    private var pointyblue : CGFloat = 0.0
    private var pointxgreen: CGFloat = 0.0
    private var pointygreen : CGFloat = 0.0
    
    private var pointxdarkspace1: CGFloat = 0.0
    private var pointydarkspace1 : CGFloat = 0.0
    
    private var pointxdarkspace2: CGFloat = 0.0
    private var pointydarkspace2 : CGFloat = 0.0
    
    private var pointxdarkspace3: CGFloat = 0.0
    private var pointydarkspace3 : CGFloat = 0.0
    
    private var pointxaqua: CGFloat = 0.0
    private var pointyaqua : CGFloat = 0.0
    private var pointxpurple: CGFloat = 0.0
    private var pointypurple : CGFloat = 0.0
    
    private var distanceBlue: CGFloat!
    private var distanceRed: CGFloat!
    private var distanceGreen: CGFloat!
    private var distanceYellow: CGFloat!
    private var distanceAqua: CGFloat!
    private var distancePurple: CGFloat!
    
    private var distancedarkspace1: CGFloat!
    private var distancedarkspace2: CGFloat!
    private var distancedarkspace3: CGFloat!
    
    private var wheelCenter: CGPoint!
    private var wheelRadius: CGFloat!
    
    private var positioningTimeUpper: CGFloat = 1.6
    private var positioningConstantUpper: CGFloat = (9/5)
    private var positioningConstantLower: CGFloat = (1/5)
    private var positioningNextLevel: CGFloat = 1.5
    private var positioningMenu: CGFloat = 0.5
    private var positioningGravballWidth: CGFloat = 1.64
    private var positioningLevelLabelWidth: CGFloat = (1/5)

    private var countdownPositioningConstant: CGFloat = 1.6
    
   
    
    func displayNextLevel()
    {
        let buttonFadeIn = SKAction.fadeIn(withDuration: 0.5)
        nextLevel.run(buttonFadeIn)
        
        let buttonFadeInMenu = SKAction.fadeIn(withDuration: 0.5)
        menuButton.run(buttonFadeInMenu)
    }
    
    func doScoreOne()
    {
        let originalPosition = plusOne.position
        
        let fadeIn = SKAction.fadeIn(withDuration: 0.5) // Fade in over 0.5 seconds
            let fadeOut = SKAction.fadeOut(withDuration: 0.5) // Fade out over 0.5 seconds
            let moveTo = SKAction.move(to: CGPoint(x: size.width / 2, y: size.height / 2 + 200), duration: 1.0) // Move over 1 second
            
            // Group fadeIn and first half of moveTo
            let firstHalfMove = SKAction.move(to: CGPoint(x: size.width / 2, y: size.height / 2 + 100), duration: 0.5)
            let firstGroup = SKAction.group([fadeIn, firstHalfMove])
            
            // Group fadeOut and second half of moveTo
            let secondHalfMove = SKAction.move(to: CGPoint(x: size.width / 2, y: size.height / 2 + 200), duration: 0.5)
            let secondGroup = SKAction.group([fadeOut, secondHalfMove])
        let moveBack = SKAction.move(to: originalPosition, duration: 0.5)
            // Sequence: fade in while moving, then fade out while continuing to move
        let sequence = SKAction.sequence([firstGroup, secondGroup, moveBack])
        
        plusOne.run(sequence)
    }
    
    func runGameOverAnimation(on node: SKSpriteNode) {
//           let fadeIn = SKAction.fadeIn(withDuration: 0.5)
//           let fadeOut = SKAction.fadeOut(withDuration: 0.5)
//        let firstGroup = SKAction.group([fadeIn, fadeOut])
//        let moveTo = SKAction.move(to: CGPoint(x: size.width / 2, y: size.height / 2 + 200), duration: 1.0)
//           let sequence = SKAction.sequence([fadeIn, moveTo, fadeOut])
//           node.run(sequence)
        
        let fadeIn = SKAction.fadeIn(withDuration: 0.5) // Fade in over 0.5 seconds
            let fadeOut = SKAction.fadeOut(withDuration: 0.5) // Fade out over 0.5 seconds
            let moveTo = SKAction.move(to: CGPoint(x: size.width / 2, y: size.height / 2 + 200), duration: 1.0) // Move over 1 second
            
            // Group fadeIn and first half of moveTo
            let firstHalfMove = SKAction.move(to: CGPoint(x: size.width / 2, y: size.height / 2 * (11/6)), duration: 0.5)
            let firstGroup = SKAction.group([fadeIn, firstHalfMove])
            
            // Group fadeOut and second half of moveTo
            let secondHalfMove = SKAction.move(to: CGPoint(x: size.width / 2, y: size.height / 2 + 200), duration: 0.5)
            let secondGroup = SKAction.group([fadeOut, secondHalfMove])
            
            // Sequence: fade in while moving, then fade out while continuing to move
            let sequence = SKAction.sequence([firstGroup, secondGroup])
            
        node.run(firstGroup)
        
       }
    
    func setCurrentAngles()
    {
        GameConstants.sphereAngleCurrent = 0
        switch Utility.shared.getWheelType()
        {
        case Sphere.WHEEL_TYPE_AQUA_PURPLE_YELLOW_GREEN_RED_BLUE:
            GameConstants.sphereAngleRedCurrent = 90
            GameConstants.sphereAngleGreenCurrent = 210
            GameConstants.sphereAngleYellowCurrent = 150
            GameConstants.sphereAngleBlueCurrent = 330
            GameConstants.sphereAngleAquaCurrent = 270
            GameConstants.sphereAnglePurpleCurrent = 30
        case Sphere.WHEEL_TYPE_YELLOW_GREEN_RED_BLUE:
            GameConstants.sphereAngleRedCurrent = 225
            GameConstants.sphereAngleGreenCurrent = 135
            GameConstants.sphereAngleYellowCurrent = 45
            GameConstants.sphereAngleBlueCurrent = 315
        case Sphere.WHEEL_TYPE_GREEN_RED_BLUE:
            GameConstants.sphereAngleRedCurrent = 90
            GameConstants.sphereAngleGreenCurrent = 220
            GameConstants.sphereAngleBlueCurrent = 320
            break
        case Sphere.WHEEL_TYPE_RED_BLUE:
            GameConstants.sphereAngleRedCurrent = 90
            GameConstants.sphereAngleBlueCurrent = 270
            break
        default:
            break
        }
    }
    
    func DoFiveToOneCountdown() -> [SKAction]
    {
        // Array of texture names for countdown (5 to 1)
        let textureNames = ["5count.png", "4count.png", "3count.png", "2count.png", "1count.png"]
        var actions: [SKAction] = []
        for (_, textureName) in textureNames.enumerated() {
                    let texture = SKTexture(imageNamed: textureName)
                    let changeTexture = SKAction.setTexture(texture)
                    let fadeIn = SKAction.fadeIn(withDuration: 0.5) // Fade in over 0.5 seconds
                    let wait = SKAction.wait(forDuration: 0.5) // Display for 0.5 seconds
                    let fadeOut = SKAction.fadeOut(withDuration: 0.5) // Fade out over 0.5 seconds
                    // Ensure last number (1) doesn't fade out if you want it to stay visible
                    actions.append(SKAction.sequence([changeTexture, fadeIn, fadeOut, wait]))
                }
        return actions
    }
    
    func doCountdown()
    {
        let countdownText = SKSpriteNode(imageNamed: "countdown.png")
            countdownText.position = CGPoint(x: frame.midX, y: frame.midY * countdownPositioningConstant)
            countdownText.zPosition = 5
            countdownText.alpha = 1.0 // Start visible
            addChild(countdownText)
        
        let beginText = SKSpriteNode(imageNamed: "begin.png")
        beginText.position = CGPoint(x: frame.midX, y: frame.midY * countdownPositioningConstant)
        beginText.zPosition = 5
        beginText.alpha = 0.0 // Start visible
            addChild(beginText)
        
        let beginFadeIn = SKAction.fadeIn(withDuration: 0.5) // Show "Countdown" for 1 second
          let beginFadeOut = SKAction.fadeOut(withDuration: 0.5) // Fade out over 0.5 seconds
        //  let beginText = SKAction.removeFromParent()
        let beginSequence = SKAction.sequence([beginFadeIn, beginFadeOut])
        
        let textWait = SKAction.wait(forDuration: 1.0) // Show "Countdown" for 1 second
          let textFadeOut = SKAction.fadeOut(withDuration: 0.5) // Fade out over 0.5 seconds
          let removeText = SKAction.removeFromParent()
        let textSequence = SKAction.sequence([textWait, textFadeOut, removeText])
        
        countOne = SKSpriteNode(imageNamed: "5count.png")
        // Set up the sprite (position, size, etc.)
                countOne.position = CGPoint(x: frame.midX, y: frame.midY * countdownPositioningConstant)
        countOne.zPosition = 5
                countOne.alpha = 0.0 // Start invisible for first fade-in
                addChild(countOne)

                

        

        self.arrayOfBalls(num: Utility.shared.getBallsForLevel())
                // Run the sequence of actions
                let sequence = SKAction.sequence(DoFiveToOneCountdown())
        countdownText.run(textSequence) {
            self.countOne.run(sequence) {
                // Optional: Keep sprite visible or perform action after countdown
                print("Countdown completed")
                beginText.run(beginSequence)
                {
                    self.completedCountdown = true
                    self.fadeInArrayofBalls()
                    self.countdownComplete = true
                }
                // self.countOne.removeFromParent() // Uncomment to remove sprite
            }
        }
    }
    
    func fadeInArrayofBalls()
    {
        for i in 0..<ballsArray.count {
            let theball = ballsArray[i]
            
            let fadeIn = SKAction.fadeIn(withDuration: 1.25)
            
            theball.sphereBall.run(fadeIn)
            theball.particle.run(fadeIn)
        }
    }
    
    func runFadeAnimation(on node: SKSpriteNode) {
           let fadeIn = SKAction.fadeIn(withDuration: 0.5)
           let fadeOut = SKAction.fadeOut(withDuration: 0.5)
        let wait = SKAction.wait(forDuration: 0.5)
           let sequence = SKAction.sequence([fadeIn, wait, fadeOut])
           node.run(sequence)
       }
    
    func runBlackOutAnimation(on node: SKSpriteNode) {
        let fadeIn = SKAction.fadeIn(withDuration: 0.3)
        let fadeOut = SKAction.fadeOut(withDuration: 0.3)
        let sequence = SKAction.sequence([fadeIn, fadeOut])
        node.run(sequence)
    }
    
    func runOuterGlowAnimation(on node: SKSpriteNode) {
        let fadeIn = SKAction.fadeIn(withDuration: 0.5)
        let fadeOut = SKAction.fadeOut(withDuration: 0.5)
//        let sequence = SKAction.sequence([fadeIn, fadeOut])
//        let repeatForever = SKAction.repeatForever(sequence)
        let wait = SKAction.wait(forDuration: 1.0) // 1-second delay
        let sequence2 = SKAction.sequence([wait, fadeIn, wait, fadeOut]) // Wait, then fade in, then fade out
        let repeatForever2 = SKAction.repeatForever(sequence2)
        node.run(repeatForever2)
    }
    
    func runInnerGlowAnimation(on node: SKSpriteNode) {
        let fadeIn = SKAction.fadeIn(withDuration: 0.5)
        let fadeOut = SKAction.fadeOut(withDuration: 0.5)
        let sequence = SKAction.sequence([fadeIn, fadeOut])
        let repeatForever = SKAction.repeatForever(sequence)
        node.run(repeatForever)
       }
    
    func setColorSegmentsRadians(wheelType: Int)
    {
        radiansYellow = (GameConstants.sphereAngleYellowCurrent) * CGFloat.pi / 180
        radiansGreen = (GameConstants.sphereAngleGreenCurrent) * CGFloat.pi / 180
        radiansRed = (GameConstants.sphereAngleRedCurrent) * CGFloat.pi / 180
        radiansBlue = (GameConstants.sphereAngleBlueCurrent) * CGFloat.pi / 180
        radiansAqua = (GameConstants.sphereAngleAquaCurrent) * CGFloat.pi / 180
        radiansPurple = (GameConstants.sphereAnglePurpleCurrent) * CGFloat.pi / 180
        
        radiansDarkSpace1 = (GameConstants.sphereAngleDarkSpace1Current) * CGFloat.pi / 180
        radiansDarkSpace2 = (GameConstants.sphereAngleDarkSpace2Current) * CGFloat.pi / 180
        radiansDarkSpace3 = (GameConstants.sphereAngleDarkSpace3Current) * CGFloat.pi / 180
        
    }
    
    func setPointsSegments(wheelType: Int)
    {
        switch wheelType {
        case Sphere.WHEEL_TYPE_YELLOW_GREEN_RED_BLUE:
            pointxyellow = cos(radiansYellow) * GameConstants.radiusoutconst4c;
            pointyyellow = sin(radiansYellow) * GameConstants.radiusoutconst4c;
           
            pointxred = cos(radiansRed) * GameConstants.radiusoutconst4c;
            pointyred = sin(radiansRed) * GameConstants.radiusoutconst4c;
           
            pointxblue = cos(radiansBlue) * GameConstants.radiusoutconst4c;
            pointyblue = sin(radiansBlue) * GameConstants.radiusoutconst4c;
           
            pointxgreen = cos(radiansGreen) * GameConstants.radiusoutconst4c;
            pointygreen = sin(radiansGreen) * GameConstants.radiusoutconst4c;
        case Sphere.WHEEL_TYPE_AQUA_PURPLE_YELLOW_GREEN_RED_BLUE:
            pointxyellow = cos(radiansYellow) * GameConstants.radiusoutconst6c;
            pointyyellow = sin(radiansYellow) * GameConstants.radiusoutconst6c;
           
            pointxred = cos(radiansRed) * GameConstants.radiusoutconst6c;
            pointyred = sin(radiansRed) * GameConstants.radiusoutconst6c;
           
            pointxblue = cos(radiansBlue) * GameConstants.radiusoutconst6c;
            pointyblue = sin(radiansBlue) * GameConstants.radiusoutconst6c;
           
            pointxgreen = cos(radiansGreen) * GameConstants.radiusoutconst6c;
            pointygreen = sin(radiansGreen) * GameConstants.radiusoutconst6c;
            
            pointxaqua = cos(radiansAqua) * GameConstants.radiusoutconst6c;
            pointyaqua = sin(radiansAqua) * GameConstants.radiusoutconst6c;
            
            pointxpurple = cos(radiansPurple) * GameConstants.radiusoutconst6c;
            pointypurple = sin(radiansPurple) * GameConstants.radiusoutconst6c;
            
            break
        case Sphere.WHEEL_TYPE_GREEN_RED_BLUE:
            pointxred = cos(radiansRed) * GameConstants.radiusoutconst3c;
            pointyred = sin(radiansRed) * GameConstants.radiusoutconst3c;
           
            pointxblue = cos(radiansBlue) * GameConstants.radiusoutconst3c;
            pointyblue = sin(radiansBlue) * GameConstants.radiusoutconst3c;
           
            pointxgreen = cos(radiansGreen) * GameConstants.radiusoutconst3c;
            pointygreen = sin(radiansGreen) * GameConstants.radiusoutconst3c;
            
            pointxdarkspace1 = cos(radiansDarkSpace1) * GameConstants.radiusoutconstdarkspacebig;
            pointydarkspace1 = sin(radiansDarkSpace1) * GameConstants.radiusoutconstdarkspacebig;
            
            pointxdarkspace2 = cos(radiansDarkSpace2) * GameConstants.radiusoutconstdarkspacebig;
            pointydarkspace2 = sin(radiansDarkSpace2) * GameConstants.radiusoutconstdarkspacebig;
            
            pointxdarkspace3 = cos(radiansDarkSpace3) * GameConstants.radiusoutconstdarkspacesmall;
            pointydarkspace3 = sin(radiansDarkSpace3) * GameConstants.radiusoutconstdarkspacesmall;
            
            break
        case Sphere.WHEEL_TYPE_RED_BLUE:
            pointxred = cos(radiansRed) * GameConstants.radiusoutconst2c;
            pointyred = sin(radiansRed) * GameConstants.radiusoutconst2c;
           
            pointxblue = cos(radiansBlue) * GameConstants.radiusoutconst2c;
            pointyblue = sin(radiansBlue) * GameConstants.radiusoutconst2c;
            break
        default:
            break
        }
         
    }
    
    func updateScoreLabel() {
      //  let totalScore = Utility.shared.getScore()
        
        updateGravballTotal()
//
//        gravballLabel.text = "\(totalScore)"
        }
    
    func updateLevelLabel() {
       // let level = Utility.shared.getLevel()
        
        updateLevelTotal()
        }
    
    func setLightUpNodes()
    {
        wheelCenter = centerWheel.position // CGPoint(x, y)
        wheelRadius = centerWheel.size.width / 2 // A
        
        switch Utility.shared.getWheelType()
        {
        case Sphere.WHEEL_TYPE_AQUA_PURPLE_YELLOW_GREEN_RED_BLUE:
            centerWheelBack = SKSpriteNode(imageNamed: "")
            
            lightUpYellow = SKSpriteNode(imageNamed: "centerwheel6c_yellow.png")
           // lightUpYellow.anchorPoint = CGPoint(x: 0.1, y: 0.3)
            lightUpYellow.position = middleScreenPoint
            lightUpYellow.zPosition = 3
            lightUpYellow.alpha = 0.0
            addChild(lightUpYellow)
            
            lightUpRed = SKSpriteNode(imageNamed: "centerwheel6c_red.png")
          //  lightUpRed.anchorPoint = CGPoint(x: 0.9, y: 0.7)
            lightUpRed.position = middleScreenPoint
            lightUpRed.zPosition = 3
            lightUpRed.alpha = 0.0
            addChild(lightUpRed)
            
            lightUpBlue = SKSpriteNode(imageNamed: "centerwheel6c_blue.png")
           // lightUpBlue.anchorPoint = CGPoint(x: 0.3, y: 0.9)
            lightUpBlue.position = middleScreenPoint
            lightUpBlue.zPosition = 3
            lightUpBlue.alpha = 0.0
            addChild(lightUpBlue)
            
            lightUpGreen = SKSpriteNode(imageNamed: "centerwheel6c_green.png")
           // lightUpGreen.anchorPoint = CGPoint(x: 0.7, y: 0.1)
            lightUpGreen.position = middleScreenPoint
            lightUpGreen.zPosition = 3
            lightUpGreen.alpha = 0.0
            addChild(lightUpGreen)
            
            lightUpAqua = SKSpriteNode(imageNamed: "centerwheel6c_aqua.png")
           // lightUpAqua.anchorPoint = CGPoint(x: 0.7, y: 0.1)
            lightUpAqua.position = middleScreenPoint
            lightUpAqua.zPosition = 3
            lightUpAqua.alpha = 0.0
            addChild(lightUpAqua)
            
            lightUpPurple = SKSpriteNode(imageNamed: "centerwheel6c_purple.png")
            //lightUpPurple.anchorPoint = CGPoint(x: 0.7, y: 0.1)
            lightUpPurple.position = middleScreenPoint
            lightUpPurple.zPosition = 3
            lightUpPurple.alpha = 0.0
            addChild(lightUpPurple)
            
        case Sphere.WHEEL_TYPE_YELLOW_GREEN_RED_BLUE:
            centerWheelBack = SKSpriteNode(imageNamed: "centerwheel_back.png")
            
            lightUpYellow = SKSpriteNode(imageNamed: "lightup_yellow_trim.png")
            lightUpYellow.anchorPoint = CGPoint(x: 0.1, y: 0.3)
            lightUpYellow.position = middleScreenPoint
            lightUpYellow.zPosition = 3
            lightUpYellow.alpha = 0.0
            addChild(lightUpYellow)
            
            lightUpRed = SKSpriteNode(imageNamed: "lightup_red_trim.png")
            lightUpRed.anchorPoint = CGPoint(x: 0.9, y: 0.7)
            lightUpRed.position = middleScreenPoint
            lightUpRed.zPosition = 3
            lightUpRed.alpha = 0.0
            addChild(lightUpRed)
            
            lightUpBlue = SKSpriteNode(imageNamed: "lightup_blue_trim.png")
            lightUpBlue.anchorPoint = CGPoint(x: 0.3, y: 0.9)
            lightUpBlue.position = middleScreenPoint
            lightUpBlue.zPosition = 3
            lightUpBlue.alpha = 0.0
            addChild(lightUpBlue)
            
            lightUpGreen = SKSpriteNode(imageNamed: "lightup_green_trim.png")
            lightUpGreen.anchorPoint = CGPoint(x: 0.7, y: 0.1)
            lightUpGreen.position = middleScreenPoint
            lightUpGreen.zPosition = 3
            lightUpGreen.alpha = 0.0
            addChild(lightUpGreen)
        case Sphere.WHEEL_TYPE_GREEN_RED_BLUE:
            centerWheelBack = SKSpriteNode(imageNamed: "centerwheel3c_back.png")
            lightUpYellow = SKSpriteNode(imageNamed: "")
            lightUpRed = SKSpriteNode(imageNamed: "centerwheel3c_red.png")
          //  lightUpRed.anchorPoint = CGPoint(x: 0.9, y: 0.7)
            lightUpRed.position = middleScreenPoint
            lightUpRed.zPosition = 3
            lightUpRed.alpha = 0.0
            addChild(lightUpRed)
            
            lightUpBlue = SKSpriteNode(imageNamed: "centerwheel3c_blue.png")
           // lightUpBlue.anchorPoint = CGPoint(x: 0.3, y: 0.9)
            lightUpBlue.position = middleScreenPoint
            lightUpBlue.zPosition = 3
            lightUpBlue.alpha = 0.0
            addChild(lightUpBlue)
            
            lightUpGreen = SKSpriteNode(imageNamed: "centerwheel3c_green.png")
           // lightUpGreen.anchorPoint = CGPoint(x: 0.7, y: 0.1)
            lightUpGreen.position = middleScreenPoint
            lightUpGreen.zPosition = 3
            lightUpGreen.alpha = 0.0
            addChild(lightUpGreen)
        case Sphere.WHEEL_TYPE_RED_BLUE:
            centerWheelBack = SKSpriteNode(imageNamed: "centerwheel2_back.png")
            
            lightUpBlue = SKSpriteNode(imageNamed: "centerwheel2_blue.png")
           // lightUpBlue.anchorPoint = CGPoint(x: 0.3, y: 0.9)
            lightUpBlue.position = middleScreenPoint
            lightUpBlue.zPosition = 3
            lightUpBlue.alpha = 0.0
            addChild(lightUpBlue)
            
            lightUpRed = SKSpriteNode(imageNamed: "centerwheel2_red.png")
          //  lightUpRed.anchorPoint = CGPoint(x: 0.9, y: 0.7)
            lightUpRed.position = middleScreenPoint
            lightUpRed.zPosition = 3
            lightUpRed.alpha = 0.0
            addChild(lightUpRed)
            
        default:
            centerWheelBack = SKSpriteNode(imageNamed: "centerwheel_back.png")
        }
        // Set position to center of scene with 150-point upward offset
        centerWheelBack.position = middleScreenPoint
        // Add sprite to scene with zPosition
        self.addChild(centerWheelBack)
        centerWheelBack.zPosition = 1
    }
    
    func setCenterWheel()
    {
        switch Utility.shared.getWheelType() {
        case Sphere.WHEEL_TYPE_YELLOW_GREEN_RED_BLUE:
            centerWheel = SKSpriteNode(imageNamed: "centerwheel.png")
        case Sphere.WHEEL_TYPE_GREEN_RED_BLUE:
            centerWheel = SKSpriteNode(imageNamed: "centerwheel3c.png")
        case Sphere.WHEEL_TYPE_RED_BLUE:
            centerWheel = SKSpriteNode(imageNamed: "centerwheel2.png")
        case Sphere.WHEEL_TYPE_AQUA_PURPLE_YELLOW_GREEN_RED_BLUE:
            centerWheel = SKSpriteNode(imageNamed: "centerwheel6.png")
        default:
            centerWheel = SKSpriteNode(imageNamed: "centerwheel.png") // Fallback image
        }
        
        // Set position to center of scene with 150-point upward offset
        centerWheel.position = middleScreenPoint
        // Add sprite to scene with zPosition
        self.addChild(centerWheel)
        centerWheel.zPosition = 2
        
        backgroundBlackOut = SKSpriteNode(imageNamed: "blackout.png")
    
    
        backgroundBlackOut.position = middleScreenPoint
        backgroundBlackOut.zPosition = 50
        backgroundBlackOut.alpha = 0.0
        // Rotate image to fit landscape (if needed)
        //backgroundNode.zRotation = .pi / 2
        self.addChild(backgroundBlackOut)
        
       
    }
    
    func setUpBakcground()
    {
        let randomNum = Int.random(in: 1..<4)
        
        switch randomNum{
        case GameConstants.BACKGROUND_ONE:
            backgroundNode = SKSpriteNode(imageNamed: "background.png")
        case GameConstants.BACKGROUND_TWO:
            backgroundNode = SKSpriteNode(imageNamed: "background2.png")
        case GameConstants.BACKGROUND_THREE:
            backgroundNode = SKSpriteNode(imageNamed: "background3.png")
        default:
            backgroundNode = SKSpriteNode(imageNamed: "background.png")
        }
        
        backgroundNode.position = CGPoint(x: size.width / 2, y: size.height / 2)
        backgroundNode.zPosition = -1
        // Rotate image to fit landscape (if needed)
        backgroundNode.zRotation = .pi / 2
        addChild(backgroundNode)
        
    }
    
    private var digitNodes: [SKSpriteNode] = []
    private let digitTextures: [SKTexture] = (0...9).map { SKTexture(imageNamed: "\($0)") } // Assumes 0.png to 9.png exist

    // Method to update and display the gravball total
    private func updateGravballTotal() {
        // Remove existing digit nodes
        digitNodes.forEach { $0.removeFromParent() }
        digitNodes.removeAll()

        // Get the total from Utility
        let total = Utility.shared.getTotalBalls()
        let totalString = String(total)
        let padding = 20.0 // Spacing between digits

        // Create and position digit nodes
        var xOffset: CGFloat = 0
        for digitChar in totalString {
            if let digit = Int(String(digitChar)) {
                let digitNode = SKSpriteNode(texture: digitTextures[digit])
                digitNode.position = CGPoint(x: self.size.width / 2 * positioningGravballWidth + 150 - CGFloat(totalString.count) * padding / 2 + xOffset, y: self.size.height / 2 * positioningConstantUpper)
//                CGPoint(x: frame.midX - CGFloat(totalString.count) * padding / 2 + xOffset, y: frame.maxY - 80)
                digitNode.zPosition = 10
                digitNode.size = CGSize(width: 20, height: 30) // Adjust size based on your texture dimensions
                addChild(digitNode)
                digitNodes.append(digitNode)
                xOffset += padding
            }
        }
    }
    
    private var leveldigitNodes: [SKSpriteNode] = []
    private let leveldigitTextures: [SKTexture] = (0...9).map { SKTexture(imageNamed: "\($0)") } // Assumes 0.png to 9.png exist
    
    private func updateLevelTotal() {
        // Remove existing digit nodes
        leveldigitNodes.forEach { $0.removeFromParent() }
        leveldigitNodes.removeAll()

        // Get the total from Utility
        let total = Utility.shared.getLevel()
        let totalString = String(total)
        let padding = 20.0 // Spacing between digits

        // Create and position digit nodes
        var xOffset: CGFloat = 0
        for digitChar in totalString {
            if let digit = Int(String(digitChar)) {
                let digitNode = SKSpriteNode(texture: leveldigitTextures[digit])
                digitNode.position = CGPoint(x: self.size.width / 2 * positioningLevelLabelWidth + 85 - CGFloat(totalString.count) * padding / 2 + xOffset, y: self.size.height / 2 * positioningConstantUpper)
//                CGPoint(x: frame.midX - CGFloat(totalString.count) * padding / 2 + xOffset, y: frame.maxY - 80)
                digitNode.zPosition = 10
                digitNode.size = CGSize(width: 20, height: 30) // Adjust size based on your texture dimensions
                addChild(digitNode)
                leveldigitNodes.append(digitNode)
                xOffset += padding
            }
        }
    }
    
    private var timedigitNodes: [SKSpriteNode] = []
    private let digitTimeTextures: [SKTexture] = (0...9).map { SKTexture(imageNamed: "\($0)") } // Assumes 0.png to 9.png exist
    private func updateTimeTotal(currentTime: CFTimeInterval) {
        // Remove existing digit nodes
        timedigitNodes.forEach { $0.removeFromParent() }
        timedigitNodes.removeAll()

        var lastUpdateTime: TimeInterval = 0.0
        
        // Calculate delta time (time since last frame)
        let deltaTime = lastUpdateTime > 0.0 ? currentTime - lastUpdateTime : 1.0 / 60.0
        lastUpdateTime = currentTime
        
        // Increment elapsed time
        elapsedTime += deltaTime
        let totalSeconds = Int(elapsedTime.rounded())
        // Display "0" before the timer starts, otherwise use the current time
            let totalString = totalSeconds == 0 ? "0" : String(totalSeconds)
            
        
        
        // Get the total from Utility
       // let total = Utility.shared.getLevel()
       
        let padding = 20.0 // Spacing between digits

        // Create and position digit nodes
        var xOffset: CGFloat = 0
        for digitChar in totalString {
            if let digit = Int(String(digitChar)) {
                let digitNode = SKSpriteNode(texture: digitTimeTextures[digit])
                digitNode.position = CGPoint(x: self.size.width / 2 * positioningLevelLabelWidth + 85 - CGFloat(totalString.count) * padding / 2 + xOffset, y: self.size.height / 2 * positioningTimeUpper)
//                CGPoint(x: frame.midX - CGFloat(totalString.count) * padding / 2 + xOffset, y: frame.maxY - 80)
                digitNode.zPosition = 10
                digitNode.size = CGSize(width: 20, height: 30) // Adjust size based on your texture dimensions
                addChild(digitNode)
                timedigitNodes.append(digitNode)
                xOffset += padding
            }
        }
    }
    
    
    
    
    func setUpSprites()
    {
        plusOne = SKLabelNode(text: "SCORE +1")
        plusOne.fontName = "Helvetica-Bold"
        plusOne.fontSize = 32
        plusOne.fontColor = .white
        // Set position to center of scene with 150-point upward offset
        plusOne.position = middleScreenPoint
        // Add sprite to scene with zPosition
        //self.addChild(gravballLabel)
        plusOne.zPosition = 4
        plusOne.alpha = 0.0
        addChild(plusOne)
        
        gravballLabel = SKLabelNode(text: "")
       
        gravballLabel.fontName = "Avenir-Heavy"
    
        gravballLabel.fontSize = 24
        gravballLabel.fontColor = .white
        // Set position to center of scene with 150-point upward offset
        gravballLabel.position = CGPoint(x: self.size.width / 2 * positioningGravballWidth + 100, y: self.size.height / 2 * positioningConstantUpper)
        // Add sprite to scene with zPosition
        self.addChild(gravballLabel)
        gravballLabel.zPosition = 5
        
        gravballNode = SKSpriteNode(imageNamed: "gravball_small.png")
        gravballNode.position = CGPoint(x: self.size.width / 2 * positioningGravballWidth, y: self.size.height / 2 * positioningConstantUpper)
        gravballNode.zPosition = 4
        addChild(gravballNode)
        
        levelLabel = SKLabelNode(text: "Level:")
        levelLabel.fontName = "Helvetica-Bold"
        levelLabel.fontSize = 24
        levelLabel.fontColor = .white
        // Set position to center of scene with 150-point upward offset
        levelLabel.position = CGPoint(x: self.size.width / 2 * positioningLevelLabelWidth, y: self.size.height / 2 * positioningConstantUpper)
        // Add sprite to scene with zPosition
        //self.addChild(levelLabel)
        levelLabel.zPosition = 5
        
        levelNode = SKSpriteNode(imageNamed: "level.png")
        levelNode.position = CGPoint(x: self.size.width / 2 * positioningLevelLabelWidth, y: self.size.height / 2 * positioningConstantUpper)
        levelNode.zPosition = 4
        addChild(levelNode)
        
        timeLabel = SKLabelNode(text: "Time:")
        timeLabel.fontName = "Helvetica-Bold"
        timeLabel.fontSize = 24
        timeLabel.fontColor = .white
        timeLabel.name = "timeLabel"
        // Set position to center of scene with 150-point upward offset
        timeLabel.position = CGPoint(x: self.size.width / 2 * positioningLevelLabelWidth, y: self.size.height / 2 * positioningTimeUpper)
        // Add sprite to scene with zPosition
        //self.addChild(timeLabel)
        timeLabel.zPosition = 5
        
        timeNode = SKSpriteNode(imageNamed: "time.png")
        timeNode.position = CGPoint(x: self.size.width / 2 * positioningLevelLabelWidth, y: self.size.height / 2 * positioningTimeUpper)
        timeNode.zPosition = 4
        addChild(timeNode)
        
        
        gameOver = SKSpriteNode(imageNamed: "gameover.png")
        gameOver.position = middleScreenPoint
        gameOver.zPosition = 4
        gameOver.alpha = 0.0
        addChild(gameOver)
        
        
        nextLevelPoint = CGPoint(x: self.size.width / 2, y: (self.size.height / 2) * positioningNextLevel )
        nextLevel = SKSpriteNode(imageNamed: "nextlevel.png")
        nextLevel.position = nextLevelPoint
        nextLevel.zPosition = 4
        nextLevel.name = "nextLevel"
        nextLevel.alpha = 0.0
        addChild(nextLevel)
        
        menuPoint = CGPoint(x: self.size.width / 2, y: (self.size.height / 2) * positioningMenu )
       // menuButton = SKSpriteNode(imageNamed: "menu.png")
        menuButton.position = menuPoint
        menuButton.zPosition = 4
    
        menuButton.name = "menuButton"
        menuButton.alpha = 0.0
        addChild(menuButton)
        
        //centerWheelBack = SKSpriteNode(imageNamed: "centerwheel_back.png")
        

        controllerLeftPoint = CGPoint(x: (self.size.width / 2) * positioningConstantLower
                                     , y: (self.size.height / 2) * positioningConstantLower)
        controllerLeft = SKSpriteNode(imageNamed: "controller_right")
        controllerLeft.position = controllerLeftPoint
        controllerLeft.zPosition = 4
        controllerLeft.name = "controllerLeft"
//        controllerLeft.name = "controllerLeft"
//        controllerLeft.isUserInteractionEnabled = true
        addChild(controllerLeft)

        controllerRightPoint = CGPoint(x: (self.size.width / 2) * positioningConstantUpper, y: (self.size.height / 2) * positioningConstantLower)
        controllerRight = SKSpriteNode(imageNamed: "controller_left")
        controllerRight.position = controllerRightPoint
        controllerRight.zPosition = 4
        controllerRight.name = "controllerRight"
        addChild(controllerRight)
        
        
        ringGlowInner = SKSpriteNode(imageNamed: "ringglow_inner.png")
        ringGlowInner.position = middleScreenPoint
        ringGlowInner.zPosition = 2
//        let fadeIn = SKAction.fadeIn(withDuration: 0.5)
//        let fadeOut = SKAction.fadeOut(withDuration: 0.5)
//        let sequence = SKAction.sequence([fadeIn, fadeOut])
//        let repeatForever = SKAction.repeatForever(sequence)
//        ringGlowInner.run(repeatForever)
        runInnerGlowAnimation(on: ringGlowInner)
        addChild(ringGlowInner)
        
        ringGlowOuter = SKSpriteNode(imageNamed: "ringglow_outer.png")
        ringGlowOuter.position = middleScreenPoint
        ringGlowOuter.zPosition = 2
//        let fadeIn = SKAction.fadeIn(withDuration: 0.5)
//        let fadeOut = SKAction.fadeOut(withDuration: 0.5)
////        let sequence = SKAction.sequence([fadeIn, fadeOut])
////        let repeatForever = SKAction.repeatForever(sequence)
//        let wait = SKAction.wait(forDuration: 1.0) // 1-second delay
//        let sequence2 = SKAction.sequence([wait, fadeIn, wait, fadeOut]) // Wait, then fade in, then fade out
//        let repeatForever2 = SKAction.repeatForever(sequence2)
//        ringGlowOuter.run(repeatForever2)
        runOuterGlowAnimation(on: ringGlowOuter)
        addChild(ringGlowOuter)
            
    }
    // Command protocol
    protocol Command {
        func execute()
    }
    // Initializes the game scene with specified size, game instance, and GameCenter manager
    init(size: CGSize, game: Game, gameCenterManager: GameCenterManager) {
        // Store the GameCenter manager instance for leaderboard and achievement integration
        self.gameCenterManager = gameCenterManager
        
        // Call the superclass initializer with the provided size
        super.init(size: size)
        
        // Calculate the midpoint of the screen for positioning elements
        middleScreenPoint = CGPoint(x: self.size.width / 2, y: self.size.height / 2)
        
        // Set up the central wheel node for gameplay
        setCenterWheel()
        
        // Initialize light-up nodes for visual effects
        setLightUpNodes()
        
        // Configure the background elements of the scene
        setUpBakcground()
        
        // Set up sprite nodes used in the game
        setUpSprites()
        
        // Initialize the angles for rotating elements
        setCurrentAngles()
        
        // Update the level display label
        updateLevelLabel()
        
        // Update the score display label
        updateScoreLabel()
        
        // Initialize the total time display with a starting value of 0
        updateTimeTotal(currentTime: 0)
        
        // Note: Commented out code for particle effects
        // makeParticle()
        
        // Start the countdown sequence for the game
        doCountdown()
        
        // Check if accelerometer is available for device motion input
        if motionManager.isAccelerometerAvailable {
            // Set accelerometer update interval to 60 Hz (0.1 seconds)
            motionManager.accelerometerUpdateInterval = 0.1
            
            // Start accelerometer updates on the main queue
            motionManager.startAccelerometerUpdates(to: .main) { [weak self] (data, error) in
                // Ensure self and data are available, otherwise exit
                guard let self = self, let data = data else { return }
                
                // Apply low-pass filter to smooth accelerometer data for X-axis
                let newX = (CGFloat(data.acceleration.y) * self.kFilterFactor) + (self.accelerometerX * (1.0 - self.kFilterFactor))
                
                // Apply low-pass filter to smooth accelerometer data for Y-axis
                let newY = (CGFloat(-data.acceleration.x) * self.kFilterFactor) + (self.accelerometerY * (1.0 - self.kFilterFactor))
                
                // Update stored accelerometer values
                self.accelerometerX = newX
                self.accelerometerY = newY
            }
        }
    }
    
    override init(size: CGSize) {
            super.init(size: size) // Call superclass initializer
        
        }
    required init?(coder aDecoder: NSCoder) {
            super.init(coder: aDecoder)
            // Set default properties if needed
        }
    
    func circlesCollide(
        center1: CGPoint, radius1: CGFloat,
        center2: CGPoint, radius2: CGFloat
    ) -> Bool {
        let dx = center1.x - center2.x
        let dy = center1.y - center2.y
        let distance = sqrt(dx * dx + dy * dy)
        return distance <= (radius1 + radius2)
    }
    
    func distanceBetweenTwoPoints(startPoint: CGPoint, endPoint: CGPoint) -> CGFloat {
        let x = endPoint.x - startPoint.x
        let y = endPoint.y - startPoint.y
        return sqrt(x * x + y * y)
    }
    
    func setAngleGoingForward()
    {
        GameConstants.sphereAngleCurrent  += GameConstants.RotationBackwardsFrac;
        GameConstants.sphereAngleYellowCurrent += GameConstants.RotationBackwardsFrac;
        GameConstants.sphereAngleGreenCurrent += GameConstants.RotationBackwardsFrac;
        GameConstants.sphereAngleRedCurrent += GameConstants.RotationBackwardsFrac;
        GameConstants.sphereAngleBlueCurrent += GameConstants.RotationBackwardsFrac;
        GameConstants.sphereAngleAquaCurrent += GameConstants.RotationBackwardsFrac;
        GameConstants.sphereAnglePurpleCurrent += GameConstants.RotationBackwardsFrac;
        
        GameConstants.sphereAngleDarkSpace1Current += GameConstants.RotationBackwardsFrac;
        GameConstants.sphereAngleDarkSpace2Current += GameConstants.RotationBackwardsFrac;
        GameConstants.sphereAngleDarkSpace3Current += GameConstants.RotationBackwardsFrac;
    }
    
    func setAngleGoingBackward()
    {
        GameConstants.sphereAngleCurrent  -= GameConstants.RotationBackwardsFrac;
        GameConstants.sphereAngleYellowCurrent -= GameConstants.RotationBackwardsFrac;
        GameConstants.sphereAngleGreenCurrent -= GameConstants.RotationBackwardsFrac;
        GameConstants.sphereAngleRedCurrent -= GameConstants.RotationBackwardsFrac;
        GameConstants.sphereAngleBlueCurrent -= GameConstants.RotationBackwardsFrac;
        GameConstants.sphereAngleAquaCurrent -= GameConstants.RotationBackwardsFrac;
        GameConstants.sphereAnglePurpleCurrent -= GameConstants.RotationBackwardsFrac;
        
        GameConstants.sphereAngleDarkSpace1Current -= GameConstants.RotationBackwardsFrac;
        GameConstants.sphereAngleDarkSpace2Current -= GameConstants.RotationBackwardsFrac;
        GameConstants.sphereAngleDarkSpace3Current -= GameConstants.RotationBackwardsFrac;
    }
    
    func setGameOver<T>(_ array: [T])
    {
        if(array.isEmpty)
        {
            gameOverFlag = true
        }
    }
    
    func setRotation()
    {
        centerWheel.zRotation = GameConstants.sphereAngleCurrent * .pi / 180
        centerWheelBack.zRotation = GameConstants.sphereAngleCurrent * .pi / 180
        lightUpYellow.zRotation = GameConstants.sphereAngleCurrent * .pi / 180
        lightUpRed.zRotation = GameConstants.sphereAngleCurrent * .pi / 180
        lightUpGreen.zRotation = GameConstants.sphereAngleCurrent * .pi / 180
        lightUpBlue.zRotation = GameConstants.sphereAngleCurrent * .pi / 180
        lightUpAqua.zRotation = GameConstants.sphereAngleCurrent * .pi / 180
        lightUpPurple.zRotation = GameConstants.sphereAngleCurrent * .pi / 180
    }
    
    /**
     * Calculates distances from all wheel segments to a given point ( ball's position)
     * This is used to determine which wheel segment is closest to the ball for collision detection
     * @param otherCenter: The position (of a ball) to calculate distances from
     */
    func setDistance(_ otherCenter: CGPoint)
    {
        // Calculate distance from blue wheel segment to the given point
        distanceBlue = distanceBetweenTwoPoints(
            startPoint: CGPoint(x: wheelCenter.x + pointxblue, y: wheelCenter.y + pointyblue),
            endPoint: CGPoint(x: otherCenter.x, y: otherCenter.y)
        )
        
        // Calculate distance from yellow wheel segment to the given point
        distanceYellow = distanceBetweenTwoPoints(
            startPoint: CGPoint(x: wheelCenter.x + pointxyellow, y: wheelCenter.y + pointyyellow),
            endPoint: CGPoint(x: otherCenter.x, y: otherCenter.y)
        )
        
        // Calculate distance from red wheel segment to the given point
        distanceRed = distanceBetweenTwoPoints(
            startPoint: CGPoint(x: wheelCenter.x + pointxred, y: wheelCenter.y + pointyred),
            endPoint: CGPoint(x: otherCenter.x, y: otherCenter.y)
        )
        
        // Calculate distance from green wheel segment to the given point
        distanceGreen = distanceBetweenTwoPoints(
            startPoint: CGPoint(x: wheelCenter.x + pointxgreen, y: wheelCenter.y + pointygreen),
            endPoint: CGPoint(x: otherCenter.x, y: otherCenter.y)
        )
        
        // Calculate distance from aqua wheel segment to the given point
        distanceAqua = distanceBetweenTwoPoints(
            startPoint: CGPoint(x: wheelCenter.x + pointxaqua, y: wheelCenter.y + pointyaqua),
            endPoint: CGPoint(x: otherCenter.x, y: otherCenter.y)
        )
        
        // Calculate distance from purple wheel segment to the given point
        distancePurple = distanceBetweenTwoPoints(
            startPoint: CGPoint(x: wheelCenter.x + pointxpurple, y: wheelCenter.y + pointypurple),
            endPoint: CGPoint(x: otherCenter.x, y: otherCenter.y)
        )
        
        // Calculate distance from first dark space segment to the given point
        // Dark spaces are barrier/empty segments that cause collision failure
        distancedarkspace1 = distanceBetweenTwoPoints(
            startPoint: CGPoint(x: wheelCenter.x + pointxdarkspace1, y: wheelCenter.y + pointydarkspace1),
           endPoint: CGPoint(x: otherCenter.x, y: otherCenter.y)
       )
        
        // Calculate distance from second dark space segment to the given point
        distancedarkspace2 = distanceBetweenTwoPoints(
            startPoint: CGPoint(x: wheelCenter.x + pointxdarkspace2, y: wheelCenter.y + pointydarkspace2),
           endPoint: CGPoint(x: otherCenter.x, y: otherCenter.y)
       )
        
        // Calculate distance from third dark space segment to the given point
        distancedarkspace3 = distanceBetweenTwoPoints(
            startPoint: CGPoint(x: wheelCenter.x + pointxdarkspace3, y: wheelCenter.y + pointydarkspace3),
           endPoint: CGPoint(x: otherCenter.x, y: otherCenter.y)
       )
        
    }
    
    func decreaseScore()
    {
        Utility.shared.decreaseTotalBalls()
        updateScoreLabel()
    }
    
    func colorsMatch(theball: Ball, index: Int)
    {
        theball.sphereBall.removeFromParent()
        theball.particle.removeFromParent()
        //removeChildren(in: theball.sphereBall)
        ballsArray.remove(at: index)
        Utility.shared.incrementTotalBalls()
        updateScoreLabel()
        
        doScoreOne()
        setGameOver(ballsArray)
    }
    
    
    func setTime(currentTime: CFTimeInterval) {
        var lastUpdateTime: TimeInterval = 0.0
        
        // Calculate delta time (time since last frame)
        let deltaTime = lastUpdateTime > 0.0 ? currentTime - lastUpdateTime : 1.0 / 60.0
        lastUpdateTime = currentTime
        
        // Increment elapsed time
        elapsedTime += deltaTime
        
        // Update the time label with only whole seconds
        if let timeLabel = childNode(withName: "timeLabel") as? SKLabelNode {
            let totalSeconds = Int(elapsedTime.rounded())
            timeLabel.text = "Time: \(totalSeconds) s"
        }
    }
    
    
    
    enum BallColor: String {
        case red = "GameConstants.RED_CONST"
        case yellow = "GameConstants.YELLOW_CONST"
        case green = "GameConstants.GREEN_CONST"
        case blue = "GameConstants.BLUE_CONST"
        case aqua = "GameConstants.AQUA_CONST"
        case purple = "GameConstants.PURPLE_CONST"
        case dark_space_1 = "GameConstants.DARK_SPACE_1_CONST"
        case dark_space_3 = "GameConstants.DARK_SPACE_2_CONST"
        case dark_space_2 = "GameConstants.DARK_SPACE_3_CONST"
    }
    
    func setdistancesArray()
    {
        distancesYellowGreenRedBlue = [
            (.red, distanceRed),
            (.yellow, distanceYellow),
            (.green, distanceGreen),
            (.blue, distanceBlue)
        ]
        
        distancesAquaPurpleYellowGreenRedBlue = [
            (.red, distanceRed),
            (.yellow, distanceYellow),
            (.green, distanceGreen),
            (.blue, distanceBlue),
            (.aqua, distanceAqua),
            (.purple, distancePurple)
        ]
        
        distancesGreenRedBlue = [
            (.red, distanceRed),
            (.green, distanceGreen),
            (.blue, distanceBlue),
            (.dark_space_1, distancedarkspace1),
            (.dark_space_2, distancedarkspace2),
            (.dark_space_3, distancedarkspace3)
        ]
        
        distancesRedBlue = [
            (.red, distanceRed),
            (.blue, distanceBlue)
        ]
    }
    
    // Determines the color of a ball and triggers corresponding animations and actions
    func determineColor(ballcolor: Int, theball: Ball, i: Int) -> Bool {
        // Evaluate the ballcolor parameter against predefined color constants
        switch ballcolor {
            // Case for red color
            case GameConstants.RED_CONST:
                // Run fade animation on the red light-up node
                runFadeAnimation(on: lightUpRed)
                // Check if the ball color matches and perform related actions
                colorsMatch(theball: theball, index: i)
                // Return true to indicate successful color match
                return true
                
            // Case for yellow color
            case GameConstants.YELLOW_CONST:
                // Run fade animation on the yellow light-up node
                runFadeAnimation(on: lightUpYellow)
                // Check if the ball color matches and perform related actions
                colorsMatch(theball: theball, index: i)
                // Return true to indicate successful color match
                return true
                
            // Case for green color
            case GameConstants.GREEN_CONST:
                // Run fade animation on the green light-up node
                runFadeAnimation(on: lightUpGreen)
                // Check if the ball color matches and perform related actions
                colorsMatch(theball: theball, index: i)
                // Return true to indicate successful color match
                return true
                
            // Case for blue color
            case GameConstants.BLUE_CONST:
                // Run fade animation on the blue light-up node
                runFadeAnimation(on: lightUpBlue)
                // Check if the ball color matches and perform related actions
                colorsMatch(theball: theball, index: i)
                // Return true to indicate successful color match
                return true
                
            // Case for purple color
            case GameConstants.PURPLE_CONST:
                // Run fade animation on the purple light-up node
                runFadeAnimation(on: lightUpPurple)
                // Check if the ball color matches and perform related actions
                colorsMatch(theball: theball, index: i)
                // Return true to indicate successful color match
                return true
                
            // Case for aqua color
            case GameConstants.AQUA_CONST:
                // Run fade animation on the aqua light-up node
                runFadeAnimation(on: lightUpAqua)
                // Check if the ball color matches and perform related actions
                colorsMatch(theball: theball, index: i)
                // Return true to indicate successful color match
                return true
                
            // Default case for unrecognized color
            default:
                // Run blackout animation on the background node
                runBlackOutAnimation(on: backgroundBlackOut)
                // Return false to indicate no color match
                return false
        }
    }
    
    /**
     * Determines if a ball's color matches the wheel segment and handles collision effects
     * @param theball: The ball object involved in the collision
     * @param i: Index parameter (likely for ball position or array index)
     * @param ballcolor: The color of the ball being checked for collision
     * @return: Boolean indicating whether the collision was successful (colors matched)
     */
    func determineCollision(theball: Ball, i: Int, ballcolor: BallColor) -> Bool
    {
        switch ballcolor
        {
        // Handle collision with red wheel segment
        case .red:
            if(theball.color == GameConstants.RED_CONST)
            {
                // Ball color matches wheel segment - trigger success effects
                runFadeAnimation(on: lightUpRed)  // Light up red segment
                colorsMatch(theball: theball, index: i)  // Handle successful match
                return true
            }
            else{
                // Ball color doesn't match red wheel segment - trigger failure effects
                runBlackOutAnimation(on: backgroundBlackOut)  // Flash screen black
                //  decreaseScore()  // TODO: Implement score decrease
            }
        
        // Handle collision with blue wheel segment
        case .blue:
            if(theball.color == GameConstants.BLUE_CONST)
            {
                // Ball color matches wheel segment - trigger success effects
                runFadeAnimation(on: lightUpBlue)  // Light up blue segment
                colorsMatch(theball: theball, index: i)  // Handle successful match
                return true
            }
            else{
                // Ball color doesn't match blue wheel segment - trigger failure effects
                runBlackOutAnimation(on: backgroundBlackOut)  // Flash screen black
                //  decreaseScore()  // TODO: Implement score decrease
            }
        
        // Handle collision with yellow wheel segment
        case .yellow:
            if(theball.color == GameConstants.YELLOW_CONST)
            {
                // Ball color matches wheel segment - trigger success effects
                runFadeAnimation(on: lightUpYellow)  // Light up yellow segment
                colorsMatch(theball: theball, index: i)  // Handle successful match
                return true
            }
            else{
                // Ball color doesn't match yellow wheel segment - trigger failure effects
                runBlackOutAnimation(on: backgroundBlackOut)  // Flash screen black
                //  decreaseScore()  // TODO: Implement score decrease
            }
        
        // Handle collision with green wheel segment
        case .green:
            if(theball.color == GameConstants.GREEN_CONST)
            {
                // Ball color matches wheel segment - trigger success effects
                runFadeAnimation(on: lightUpGreen)  // Light up green segment
                colorsMatch(theball: theball, index: i)  // Handle successful match
                return true
            }
            else{
                // Ball color doesn't match green wheel segment - trigger failure effects
                runBlackOutAnimation(on: backgroundBlackOut)  // Flash screen black
                //  decreaseScore()  // TODO: Implement score decrease
            }
        
        // Handle collision with aqua wheel segment
        case .aqua:
            if(theball.color == GameConstants.AQUA_CONST)
            {
                // Ball color matches wheel segment - trigger success effects
                runFadeAnimation(on: lightUpAqua)  // Light up aqua segment
                colorsMatch(theball: theball, index: i)  // Handle successful match
                return true
            }
            else{
                // Ball color doesn't match aqua wheel segment - trigger failure effects
                runBlackOutAnimation(on: backgroundBlackOut)  // Flash screen black
                //  decreaseScore()  // TODO: Implement score decrease
            }
        
        // Handle collision with purple wheel segment
        case .purple:
            if(theball.color == GameConstants.PURPLE_CONST)
            {
                // Ball color matches wheel segment - trigger success effects
                runFadeAnimation(on: lightUpPurple)  // Light up purple segment
                colorsMatch(theball: theball, index: i)  // Handle successful match
                return true
            }
            else{
                // Ball color doesn't match purple wheel segment - trigger failure effects
                runBlackOutAnimation(on: backgroundBlackOut)  // Flash screen black
                //  decreaseScore()  // TODO: Implement score decrease
            }
        
        // Handle collision with dark space segments (barrier/empty areas)
        case .dark_space_1:
            runBlackOutAnimation(on: backgroundBlackOut)  // Always failure - no ball can match dark space
        case .dark_space_2:
            runBlackOutAnimation(on: backgroundBlackOut)  // Always failure - no ball can match dark space
        case .dark_space_3:
            runBlackOutAnimation(on: backgroundBlackOut)  // Always failure - no ball can match dark space
        
        // Handle unknown or unsupported ball colors
        default:
            break  // No action taken for unhandled cases
            
        }
        
        return false  // Default return for unsuccessful collisions
    }
    
    /**
     * Handles collision detection between a ball and wheel segments based on wheel type
     * @param theball: The ball object to check for collision
     * @param i: Index parameter (likely for ball position or iteration)
     * @return: Boolean indicating whether a collision occurred
     */
    func handleCollision(theball: Ball, i: Int) -> Bool
    {
        // Get the current wheel type configuration from utility singleton
        switch Utility.shared.getWheelType()
        {
            // Handle 4-color wheel (Yellow, Green, Red, Blue)
        case Sphere.WHEEL_TYPE_YELLOW_GREEN_RED_BLUE:
            // Find the closest color segment by minimum distance
            switch distancesYellowGreenRedBlue.min(by: { $0.value < $1.value })?.color
            {
            case .red:
                return determineCollision(theball: theball, i: i, ballcolor: .red)
            case .yellow:
                return determineCollision(theball: theball, i: i, ballcolor: .yellow)
            case .green:
                return determineCollision(theball: theball, i: i, ballcolor: .green)
            case .blue:
                return determineCollision(theball: theball, i: i, ballcolor: .blue)
            default:
                return false // No valid color found
            }
            
            // Handle 6-color wheel (Aqua, Purple, Yellow, Green, Red, Blue)
        case Sphere.WHEEL_TYPE_AQUA_PURPLE_YELLOW_GREEN_RED_BLUE:
            // Find the closest color segment by minimum distance
            switch distancesAquaPurpleYellowGreenRedBlue.min(by: { $0.value < $1.value })?.color
            {
            case .red:
                return determineCollision(theball: theball, i: i, ballcolor: .red)
            case .yellow:
                return determineCollision(theball: theball, i: i, ballcolor: .yellow)
            case .green:
                return determineCollision(theball: theball, i: i, ballcolor: .green)
            case .blue:
                return determineCollision(theball: theball, i: i, ballcolor: .blue)
            case .purple:
                return determineCollision(theball: theball, i: i, ballcolor: .purple)
            case .aqua:
                return determineCollision(theball: theball, i: i, ballcolor: .aqua)
            default:
                return false // No valid color found
            }
            
            // Handle 3-color wheel with dark spaces (Green, Red, Blue + dark spaces)
        case Sphere.WHEEL_TYPE_GREEN_RED_BLUE:
            // Find the closest segment (color or dark space) by minimum distance
            switch distancesGreenRedBlue.min(by: { $0.value < $1.value })?.color
            {
            case .red:
                return determineCollision(theball: theball, i: i, ballcolor: .red)
            case .green:
                return determineCollision(theball: theball, i: i, ballcolor: .green)
            case .blue:
                return determineCollision(theball: theball, i: i, ballcolor: .blue)
                // Handle dark space segments (likely empty/barrier segments)
            case .dark_space_1:
                return determineCollision(theball: theball, i: i, ballcolor: .dark_space_1)
            case .dark_space_2:
                return determineCollision(theball: theball, i: i, ballcolor: .dark_space_2)
            case .dark_space_3:
                return determineCollision(theball: theball, i: i, ballcolor: .dark_space_3)
            default:
                return false // No valid segment found
            }
            
            // Handle 2-color wheel (Red, Blue only)
        case Sphere.WHEEL_TYPE_RED_BLUE:
            // Note: Uses distancesGreenRedBlue array but only checks red/blue cases
            switch distancesGreenRedBlue.min(by: { $0.value < $1.value })?.color
            {
            case .blue:
                return determineCollision(theball: theball, i: i, ballcolor: .blue)
            case .red:
                return determineCollision(theball: theball, i: i, ballcolor: .red)
            default:
                return false // No valid color found
            }
            
            // Handle unknown or unsupported wheel types
        default:
            break // Fall through to return false
            
        }
                
            return false // Default return for unhandled cases
        }
    
    func submitScoreFunction() async {
        await gameCenterManager.submitScore(Utility.shared.getTotalBalls())
    }
    
    // Handles the game over sequence, including animations and level progression
    func doGameOver() {
        // Trigger the game over animation on the gameOver node
        runGameOverAnimation(on: gameOver)
        
        // Display the next level information to the user
        displayNextLevel()
        
        // Increment the current level using the shared utility
        Utility.shared.incrementLevel()
        
        // Set the levelOver flag to true, indicating the level has ended
        levelOver = true
        
        // Update level-specific parameters for the next level
        Utility.shared.setLevelParameters()
        
        // Note: Commented out code to adjust centerWheel transparency
        // centerWheel.alpha = 0.5
        
        // Asynchronously submit the player's score
        Task {
            await submitScoreFunction()
        }
        
        // Apply a fade animation to the background node for a smoother transition
        let fadeAction = SKAction.fadeAlpha(to: 0.3, duration: 1.5)
        backgroundNode.run(fadeAction)
        
        // Note: Commented out code to stop animations on ring glow nodes
        // ringGlowInner.removeAllActions()
        // ringGlowOuter.removeAllActions()
    }
    
    /**
     * Main game loop called every frame
     * Handles wheel rotation, ball physics, collision detection, and game state management
     */
    override func update(_ currentTime: CFTimeInterval) {
        
        // Handle wheel rotation direction based on game state flags
        if(GameConstants.goingBackwardBlocker)
        {
            setAngleGoingForward()    // Set wheel to rotate forward
            setRotation()             // Apply the rotation
        }
        else if(GameConstants.goingForwardBlocker)
        {
            setAngleGoingBackward()   // Set wheel to rotate backward
            setRotation()             // Apply the rotation
        }
        
        // Initialize accelerometer usage flags for this frame
        var useAccelX: Bool = false
        var useAccelY: Bool = false
        
        // Only process game logic if the level is still active
        if(!levelOver)
        {
            // Update game timer if countdown has finished
            if(countdownComplete)
            {
                updateTimeTotal(currentTime: currentTime)
            }
            
            // Check for game over condition
            if(gameOverFlag)
            {
                doGameOver()
            }
            // Process ball physics and collisions only after countdown is complete
            else if(countdownComplete)
            {
                // Iterate through all balls in the game
                for i in 0..<ballsArray.count {
                    let theball = ballsArray[i]
                    
                    // Get ball's current position and radius for collision calculations
                    let otherCenter = theball.sphereBall.position
                    let otherRadius = theball.sphereBall.size.width / 2
                    
                    // Create CGPoint representations of ball and wheel centers
                    // Note: otherCircleCenter is redundant with otherCenter
                    let otherCircleCenter = CGPoint(x: theball.sphereBall.position.x, y: theball.sphereBall.position.y)
                    let centerWheelPoint = CGPoint(x: centerWheel.position.x, y: centerWheel.position.y)
                    
                    // Calculate distance between ball and center wheel
                    let distance = distanceBetweenTwoPoints(startPoint: otherCircleCenter, endPoint: centerWheelPoint)
                    
                    // Only process collision detection if ball is close enough to the center wheel
                    if(distance < GameConstants.distanceFromBallToCenter)
                    {
                        // Update wheel segments based on current wheel configuration
                        setColorSegmentsRadians(wheelType: Utility.shared.getWheelType())
                        setPointsSegments(wheelType: Utility.shared.getWheelType())
                        
                        // Update distance calculations for collision detection
                        setDistance(otherCenter)
                        setdistancesArray()
                        
                        // Check if ball is actually colliding with the wheel
                        if circlesCollide(
                            center1: wheelCenter, radius1: wheelRadius,
                            center2: otherCenter, radius2: otherRadius
                        ) {
                            
                            // Handle collision (scoring, ball removal, etc.)
                            // If handleCollision returns true, break out of loop (likely ball was removed)
                            if handleCollision(theball: theball, i:i)
                            {
                                break;
                            }
                            
                            // Reverse ball velocity for bounce effect
                            theball.projX = -theball.projX
                            theball.projY = -theball.projY
                            
                            // Disable accelerometer input to prevent interference during collision
                            useAccelX = false
                            useAccelY = false
                        }
                    }
                    
                    // Update ball position based on velocity and accelerometer input
                    updateBallPosition(theball: theball, useAccelX:useAccelX, useAccelY: useAccelY)
                }
            }
        }
    }
    
    func updateBallPosition(theball: Ball, useAccelX:Bool, useAccelY: Bool)
    {
        let ballHalfSize = theball.sphereBall.size.width / 2
        
        let sensitivity: CGFloat = 1.28
        var useAccelX = useAccelX
        var useAccelY = useAccelY
       
        if(theball.sphereBall.position.x + ballHalfSize >= self.size.width || theball.sphereBall.position.x - ballHalfSize <= 0)
        {
            theball.projX = -theball.projX
            useAccelX = false
        }
        if(theball.sphereBall.position.y >= self.size.height || theball.sphereBall.position.y <= 0)
        {
            theball.projY = -theball.projY
            useAccelY = false
        }
        if (useAccelX)
        {
            theball.projX = theball.projX + accelerometerX * sensitivity
        }
        if (useAccelY)
        {
            theball.projY = theball.projY + accelerometerY * sensitivity
        }
        
        if(theball.projX > GameConstants.maxBallSpeedLimit)
        {
            theball.projX = GameConstants.maxBallSpeedLimit
        }
        if(theball.projX < -GameConstants.maxBallSpeedLimit)
        {
            theball.projX = -GameConstants.maxBallSpeedLimit
        }
        
        if(theball.projY > GameConstants.maxBallSpeedLimit)
        {
            theball.projY = GameConstants.maxBallSpeedLimit
        }
        if(theball.projY < -GameConstants.maxBallSpeedLimit)
        {
            theball.projY = -GameConstants.maxBallSpeedLimit
        }
        
        
        theball.sphereBall.position = CGPoint(x: theball.sphereBall.position.x + theball.projX , y: theball.sphereBall.position.y + theball.projY)
        
        theball.particle.position = CGPoint(x: theball.particle.position.x + theball.projX , y: theball.particle.position.y + theball.projY)
        
        print("Touch ended at: \(theball.projX)")
        print("Touch ended at: \(theball.projY)")
        
        print("Position X: \(theball.sphereBall.position.x)")
        print("Position Y: \(theball.sphereBall.position.y)")
    
    
        
    }
    
    
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        guard let touch = touches.first else { return }
        let location = touch.location(in: self)
        let touchedNode = atPoint(location)

        if touchedNode.name == "controllerLeft" {
            // Start the game or transition to another scene
            print("Left controller tapped!")
            print("Name: \(touchedNode.name)")
            GameConstants.goingBackwardBlocker = true
            GameConstants.goingForwardBlocker = false
            controllerLeft.texture = SKTexture(imageNamed: "controller_right_glow")
        }
        else if touchedNode.name == "controllerRight" {
            // Start the game or transition to another scene
            print("Name: \(touchedNode.name)")
            GameConstants.goingBackwardBlocker = false
            GameConstants.goingForwardBlocker = true
            controllerRight.texture = SKTexture(imageNamed: "controller_left_glow")
        
        }
        print("Name: \(touchedNode.name)")
        if(nextLevel.alpha != 0.0)
        {
            // Check if the nextLevel button was touched
            if touchedNode.name == "nextLevel" {
                // Transition to the next scene
                Utility.shared.nextLevel(levelComplete: 2)
                Utility.shared.setRandomNumBalls()
                setCurrentAngles()
                let nextScene = GameScene(size: self.size, game: Utility.shared.returnGame(), gameCenterManager: gameCenterManager)// Replace with your actual scene
                nextScene.scaleMode = scaleMode
                let transition = SKTransition.fade(withDuration: 0.5)
                view?.presentScene(nextScene, transition: transition)
            }
            else if touchedNode.name == "menuButton" {
                print("pressed Name: \(touchedNode.name)")
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
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        guard let touch = touches.first else { return }
            let location = touch.location(in: self)
            let touchedNode = atPoint(location)

            // Check if the touch ended on the button
            if touchedNode.name == "controllerLeft" {
                controllerLeft.texture = SKTexture(imageNamed: "controller_right")
                
                // Revert to original texture
                
            }
        else if touchedNode.name == "controllerRight" {
            controllerRight.texture = SKTexture(imageNamed: "controller_left")
            
        }
        GameConstants.goingBackwardBlocker = false
        GameConstants.goingForwardBlocker = false
        }
    
    func determineBallColor() -> Int
    {
        var randomPosStart: Int
        var color: Int
        
        switch Utility.shared.getWheelType() {
        case Sphere.WHEEL_TYPE_YELLOW_GREEN_RED_BLUE:
            randomPosStart = Int.random(in: 1..<5)
            switch randomPosStart {
            case GameConstants.BLUE_CONST:
                color = GameConstants.BLUE_CONST
            case GameConstants.RED_CONST:
                color = GameConstants.RED_CONST
            case GameConstants.YELLOW_CONST:
                color = GameConstants.YELLOW_CONST
            case GameConstants.GREEN_CONST:
                color = GameConstants.GREEN_CONST
            default:
                color = GameConstants.BLUE_CONST
            }
        case Sphere.WHEEL_TYPE_RED_BLUE:
            randomPosStart = Int.random(in: 1..<3)
            switch randomPosStart {
            case GameConstants.BLUE_CONST:
                color = GameConstants.BLUE_CONST
            case GameConstants.RED_CONST:
                color = GameConstants.RED_CONST
            default:
                color = GameConstants.BLUE_CONST
            }
        case Sphere.WHEEL_TYPE_GREEN_RED_BLUE:
            randomPosStart = Int.random(in: 1..<4)
            switch randomPosStart {
            case GameConstants.BLUE_CONST:
                color = GameConstants.BLUE_CONST
            case GameConstants.RED_CONST:
                color = GameConstants.RED_CONST
            case GameConstants.GREEN_CONST:
                color = GameConstants.GREEN_CONST
            default:
                color = GameConstants.BLUE_CONST
            }
        case Sphere.WHEEL_TYPE_AQUA_PURPLE_YELLOW_GREEN_RED_BLUE:
            randomPosStart = Int.random(in: 1..<7)
            switch randomPosStart {
            case GameConstants.BLUE_CONST:
                color = GameConstants.BLUE_CONST
            case GameConstants.RED_CONST:
                color = GameConstants.RED_CONST
            case GameConstants.GREEN_CONST:
                color = GameConstants.GREEN_CONST
            case GameConstants.YELLOW_CONST:
                color = GameConstants.YELLOW_CONST
            case GameConstants.AQUA_CONST:
                color = GameConstants.AQUA_CONST
            case GameConstants.PURPLE_CONST:
                color = GameConstants.PURPLE_CONST
            default:
                color = GameConstants.BLUE_CONST
            }
        default:
            randomPosStart = Int.random(in: 1..<3) // Fallback range
            color = GameConstants.BLUE_CONST // Fallback color
        }
        return color
    }
    
    func arrayOfBalls(num: Int)
    {
        for _ in stride(from: 0, to: num, by: 1)
        {
            let (projX, projY) = returnBallSpeed()
            
            let color = determineBallColor()
            
            
            let ball = Ball(projX: projX, projY: projY, color:  color, isInPlay: false, hasEntered: false, hasEnteredSphere: false)
            guard let emitter = SKEmitterNode(fileNamed: "MyParticle.sks") else {
                print("Failed to load MyParticle.sks")
                return
            }
            determineSphereParticleColor(ball: ball, emitter: emitter)
            determineBallParticlePosition(ball: ball)

        }
    }
        
        func returnBallSpeed() -> (projX: CGFloat, projY: CGFloat)
        {
            var projX: CGFloat = 0
            var projY: CGFloat = 0
            
            let minBallSpeed : CGFloat = 4
            let maxBallSpeed : CGFloat = 7
            let randomNum = Int.random(in: 1..<5)
            switch randomNum{
            case GameConstants.TOPLEFT:
                projX = minBallSpeed + CGFloat.random(in: 1..<maxBallSpeed)
                projY = -projX
            case GameConstants.TOPRIGHT:
                projX = minBallSpeed + CGFloat.random(in: 1..<maxBallSpeed)
                projY = -projX
            case GameConstants.BOTTOMLEFT:
                projX = minBallSpeed + CGFloat.random(in: 1..<maxBallSpeed)
                projY = projX
            case GameConstants.BOTTOMRIGHT:
                projX = minBallSpeed + CGFloat.random(in: 1..<maxBallSpeed)
                projY = projX
            default:
                projX = 0
                projY = 0
            }
            
            return (projX: projX, projY: projY)
        }
        
        func determineBallParticlePosition(ball: Ball)
        {
            var posX: Int
            var posY: Int
            var otherCenter: CGPoint
            let otherRadius: CGFloat = ball.sphereBall.size.width / 2
            let lowerLimit : Int = Int(ball.sphereBall.size.width)
            repeat {
                posX = Int.random(in: lowerLimit..<Int(size.width) - lowerLimit)
                posY = Int.random(in: lowerLimit..<Int(size.height) - lowerLimit)
                otherCenter = CGPoint(x: posX, y: posY)
            } while circlesCollide(
                        center1: wheelCenter, radius1: wheelRadius,
                        center2: otherCenter, radius2: otherRadius
            )
                                
            ball.sphereBall.position = CGPoint(x: posX, y: posY)
            ball.sphereBall.zPosition = 5
            ball.sphereBall.alpha = 0.0
            
            ball.particle.position = CGPoint(x: posX, y: posY)
            ball.particle.zPosition = 4
            ball.particle.alpha = 0.0
            
            let rotateForever = SKAction.rotate(byAngle: CGFloat.pi * 2, duration: 1.0) // Full 360° rotation
            let repeatForever = SKAction.repeatForever(rotateForever)
            ball.sphereBall.run(repeatForever)
            ballsArray.append(ball)
            addChild(ball.sphereBall)
            addChild(ball.particle)
        }
        
    /**
     * Sets up the visual appearance of a ball based on its color
     * Configures both the sprite image and particle effects for the ball
     * @param ball: The ball object to configure
     * @param emitter: The particle emitter node to attach to the ball
     */
    func determineSphereParticleColor(ball: Ball, emitter: SKEmitterNode)
    {
        switch ball.color{
        // Configure blue ball appearance
        case GameConstants.BLUE_CONST:
            ball.sphereBall = SKSpriteNode(imageNamed: "ball_blue")  // Set blue ball sprite
            ball.particle = emitter  // Attach particle emitter to ball
            ball.particle.particleColor = .blue  // Set particle color to blue
            ball.particle.particleColorBlendFactor = 1.0  // Full color blending
            ball.particle.particleColorSequence = nil  // Disable color sequence animation
        
        // Configure red ball appearance
        case GameConstants.RED_CONST:
            ball.sphereBall = SKSpriteNode(imageNamed: "ball_red")  // Set red ball sprite
            ball.particle = emitter  // Attach particle emitter to ball
            ball.particle.particleColor = .red  // Set particle color to red
            ball.particle.particleColorBlendFactor = 1.0  // Full color blending
            ball.particle.particleColorSequence = nil  // Disable color sequence animation
        
        // Configure yellow ball appearance
        case GameConstants.YELLOW_CONST:
            ball.sphereBall = SKSpriteNode(imageNamed: "ball_yellow")  // Set yellow ball sprite
            ball.particle = emitter  // Attach particle emitter to ball
            ball.particle.particleColor = .yellow  // Set particle color to yellow
            ball.particle.particleColorBlendFactor = 1.0  // Full color blending
            ball.particle.particleColorSequence = nil  // Disable color sequence animation
        
        // Configure green ball appearance
        case GameConstants.GREEN_CONST:
            ball.sphereBall = SKSpriteNode(imageNamed: "ball_green")  // Set green ball sprite
            ball.particle = emitter  // Attach particle emitter to ball
            ball.particle.particleColor = .green  // Set particle color to green
            ball.particle.particleColorBlendFactor = 1.0  // Full color blending
            ball.particle.particleColorSequence = nil  // Disable color sequence animation
        
        // Configure aqua ball appearance
        case GameConstants.AQUA_CONST:
            ball.sphereBall = SKSpriteNode(imageNamed: "ball_aqua")  // Set aqua ball sprite
            ball.particle = emitter  // Attach particle emitter to ball
            ball.particle.particleColor = .systemBlue  // Set particle color to system blue (closest to aqua)
            ball.particle.particleColorBlendFactor = 1.0  // Full color blending
            ball.particle.particleColorSequence = nil  // Disable color sequence animation
        
        // Configure purple ball appearance
        case GameConstants.PURPLE_CONST:
            ball.sphereBall = SKSpriteNode(imageNamed: "ball_purple")  // Set purple ball sprite
            ball.particle = emitter  // Attach particle emitter to ball
            ball.particle.particleColor = .purple  // Set particle color to purple
            ball.particle.particleColorBlendFactor = 1.0  // Full color blending
            ball.particle.particleColorSequence = nil  // Disable color sequence animation
        
        // Handle unknown or unsupported ball colors
        default:
            break  // No configuration for unhandled colors
        
        }
       
    }
}
