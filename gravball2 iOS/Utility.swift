//
//  Utility.swift
//  gravball2 iOS
//
//  Created by Daniel Roberts on 5/30/25.
//
import SpriteKit
import SwiftUI
import GameKit

class Utility {
    static let shared = Utility()
    private let scoreKey = "HighScore"
    private(set) var totalBalls: Int = 0
    private let ballsForLevel: Int = 10
    private var theGame = Game(numBalls: 10, level: 1, time: 30, wheelType:6)
    let defaults = UserDefaults.standard
    
    func setUpGame()
    {
        
        let randomNum = Int.random(in: 1..<5)
        
        switch randomNum{
        case 1:
            theGame.setWheelType(Sphere.WHEEL_TYPE_RED_BLUE)
        case 2:
            theGame.setWheelType(Sphere.WHEEL_TYPE_GREEN_RED_BLUE)
        case 3:
            theGame.setWheelType(Sphere.WHEEL_TYPE_YELLOW_GREEN_RED_BLUE)
        case 4:
            theGame.setWheelType(Sphere.WHEEL_TYPE_AQUA_PURPLE_YELLOW_GREEN_RED_BLUE)
        default:
            theGame.setWheelType(Sphere.WHEEL_TYPE_GREEN_RED_BLUE)
        }
        
    }
    private init(
    ) {
    }
    // Save score to UserDefaults
    func saveScore(_ score: Int) {
            UserDefaults.standard.set(score, forKey: scoreKey)
            UserDefaults.standard.synchronize() // Ensure immediate save (optional in modern iOS)
    }
    
    func returnGame() -> Game {
        return theGame
    }
    
   func setRandomNumBalls()
    {
        let randomNum = Int.random(in: 10..<15)
        theGame.setNumBalls(randomNum)
    }
    
    
    func nextLevel(levelComplete: Int)
    {
        let randomNum = Int.random(in: 1..<5)
        
        switch randomNum{
        case 1:
            theGame.setWheelType(Sphere.WHEEL_TYPE_RED_BLUE)
        case 2:
            theGame.setWheelType(Sphere.WHEEL_TYPE_GREEN_RED_BLUE)
        case 3:
            theGame.setWheelType(Sphere.WHEEL_TYPE_YELLOW_GREEN_RED_BLUE)
        case 4:
            theGame.setWheelType(Sphere.WHEEL_TYPE_AQUA_PURPLE_YELLOW_GREEN_RED_BLUE)
        default:
            theGame.setWheelType(Sphere.WHEEL_TYPE_GREEN_RED_BLUE)
        }
        
      //  theGame.setWheelType(Sphere.WHEEL_TYPE_GREEN_RED_BLUE)
    }
    
    func getLevel() -> Int {
        return theGame.level
            //return UserDefaults.standard.integer(forKey: scoreKey)
    }
    
    func getWheelType() -> Int {
        return theGame.wheelType
            //return UserDefaults.standard.integer(forKey: scoreKey)
    }
      
    func getBallsForLevel() -> Int {
        return theGame.numBalls
            //return UserDefaults.standard.integer(forKey: scoreKey)
    }
    
    func getTotalBalls() -> Int {
        return totalBalls
            //return UserDefaults.standard.integer(forKey: scoreKey)
    }
    
    
        // Retrieve score from UserDefaults
    func getScore() -> Int {
        return totalBalls
            //return UserDefaults.standard.integer(forKey: scoreKey)
    }
        
        // Update high score if new score is higher
    func updateHighScore(_ newScore: Int) {
            let currentHighScore = getScore()
            if newScore > currentHighScore {
                saveScore(newScore)
            }
    }
    
    func incrementLevel() {
        theGame.level += 1
    }
    
    func incrementTotalBalls() {
        totalBalls += 1
    }
    
    func decreaseTotalBalls() {
        if (totalBalls > 0) {
            totalBalls -= 1
        }
    }
    
    func setLevelParameters() {
        defaults.set(theGame.level, forKey: "level")
        defaults.set(totalBalls, forKey: "gravballs")
    }
    
    func getLevelParameters()
    {
        totalBalls = defaults.integer(forKey: "gravballs")
        theGame.level = defaults.integer(forKey: "level")
        if(theGame.level == 0)
        {
            theGame.level = 1
        }
    }
    
    
//    func createMenuScene(size: CGSize) -> SKScene {
//        let scene = MenuScene(size: size)
//        scene.scaleMode = .aspectFill // or .fill, depending on desired scaling
//        
//        
//        return scene
//    }
    
    func transitionGameScene()
    {
        
    }
}
