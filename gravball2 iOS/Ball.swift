//
//  Ball.swift
//  gravball2 iOS
//
//  Created by Daniel Roberts on 4/27/25.
//
import SpriteKit

class Ball : NSObject {
    var projX: CGFloat
    var projY: CGFloat
    var sphereBall = SKSpriteNode()
    var particle = SKEmitterNode()
    
    let color: Int
    let isInPlay: Bool
    let hasEntered: Bool
    let hasEnteredSphere: Bool
//    override init() {
//        //
//    }
    init(projX: CGFloat, projY: CGFloat, color: Int, isInPlay: Bool, hasEntered: Bool, hasEnteredSphere: Bool) {
        self.projX = projX
        self.projY = projY
        self.color = color
        self.isInPlay = isInPlay
        self.hasEntered = hasEntered
        self.hasEnteredSphere = hasEnteredSphere
    }
}
