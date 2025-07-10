
import SpriteKit

enum Sphere{
    static let WHEEL_TYPE_RED_BLUE: Int = 2
    static let WHEEL_TYPE_GREEN_RED_BLUE: Int = 3
    static let WHEEL_TYPE_YELLOW_GREEN_RED_BLUE: Int = 4
    static let WHEEL_TYPE_AQUA_PURPLE_YELLOW_GREEN_RED_BLUE: Int = 6
}

class Game : NSObject {
    var numBalls: Int
    var level: Int
    var time: Int
    var wheelType: Int
  
//    override init() {
//        //
//    }
    init(numBalls: Int, level: Int, time: Int, wheelType: Int) {
        self.numBalls = numBalls
        self.level = level
        self.time = time
        self.wheelType = wheelType
    }
    
    func setNumBalls(_ numBalls: Int) {
        self.numBalls = numBalls
    }
    
    func setLevel(_ level: Int) {
        self.level = level
    }
    
    func setTime(_ time: Int) {
        self.time = time
    }
    
    func setWheelType(_ wheelType: Int) {
        self.wheelType = wheelType
    }
}
