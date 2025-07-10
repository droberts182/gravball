//
//  GameConstants.swift
//  gravball2 iOS
//
//  Created by Daniel Roberts on 7/4/25.
//

import SpriteKit
import SwiftUI
import CoreMotion
import GameKit

enum GameConstants{
    static let BACKGROUND_ONE: Int = 1
    static let BACKGROUND_TWO: Int = 2
    static let BACKGROUND_THREE: Int = 3
    
    static let ENTERED_RED: Int = 1
    static let ENTERED_BLUE: Int = 2
    static let ENTERED_GREEN: Int = 3
    static let ENTERED_YELLOW: Int = 4
    static let ENTERED_AQUA: Int = 5
    static let ENTERED_PURPLE: Int = 6
    static let ENTERED_DARK_SPACE: Int = 7
    
    
    static let BLUE_CONST: Int = 1
    static let RED_CONST: Int = 2
    static let GREEN_CONST: Int = 3
    static let YELLOW_CONST: Int = 4
    static let AQUA_CONST: Int = 5
    static let PURPLE_CONST: Int = 6
    
    static let DARK_SPACE_1_CONST: Int = 7
    static let DARK_SPACE_2_CONST: Int = 8
    static let DARK_SPACE_3_CONST: Int = 9
    
    static let maxBallSpeedLimit: CGFloat = 10
    static let TOPLEFT: Int = 1
    static let TOPRIGHT: Int = 2
    static let BOTTOMLEFT: Int = 3
    static let BOTTOMRIGHT: Int = 4
    static let radiusoutconst2c: CGFloat = 90
    static let radiusoutconst3c: CGFloat = 40
    static let radiusoutconst4c: CGFloat = 45
    static let radiusoutconst6c: CGFloat = 30
    static let radiusoutconstdarkspacebig: CGFloat = 25
    static let radiusoutconstdarkspacesmall: CGFloat = 10
    
    static var sphereAngleRedCurrent4c: CGFloat = 225
    
    static var sphereAngleGreenCurrent4c: CGFloat = 135
    
    static var sphereAngleYellowCurrent4c: CGFloat = 45
    
    static var sphereAngleBlueCurrent4c: CGFloat = 315
    
    
    
    static var sphereAngleRedCurrent: CGFloat = 225
    
    static var sphereAngleGreenCurrent: CGFloat = 135
    
    static var sphereAngleYellowCurrent: CGFloat = 45
    
    static var sphereAngleBlueCurrent: CGFloat = 315
    
    static var sphereAngleAquaCurrent: CGFloat = 270
    
    static var sphereAnglePurpleCurrent: CGFloat = 30
    
    static var sphereAngleDarkSpace1Current: CGFloat = 25
    static var sphereAngleDarkSpace2Current: CGFloat = 155
    static var sphereAngleDarkSpace3Current: CGFloat = 270
    
    
    static var sphereAngleRedCurrent6c: CGFloat = 90
    
    static var sphereAngleGreenCurrent6c: CGFloat = 210
    
    static var sphereAngleYellowCurrent6c: CGFloat = 150
    
    static var sphereAngleBlueCurrent6c: CGFloat = 330
    
    static var sphereAngleAquaCurrent6c: CGFloat = 270
    
    static var sphereAnglePurpleCurrent6c: CGFloat = 30
    
    static var goingForwardBlocker: Bool = false
    static var goingBackwardBlocker: Bool = false
    
    static var RotationForwardFrac: CGFloat = 6
    static var RotationBackwardsFrac: CGFloat = -6
    
    static var sphereAngleCurrent: CGFloat = 0
    
    static let distanceFromBallToCenter: CGFloat = 120
    
    
}
