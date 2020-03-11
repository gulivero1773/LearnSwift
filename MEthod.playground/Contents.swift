import UIKit

class Counter {
    var count = 0
    func increment() {
        count += 1
    }
    func increment (by amount: Int){
        count += amount
    }
    func reset() {
        count = 0
    }
}


let counter = Counter()
counter.increment()
counter.count
counter.increment(by: 5)
counter.count
counter.reset()
counter.count


struct Point {
    var x = 0.0, y = 0.0
    func isToTheRightOf(x: Double) -> Bool {
        return self.x > x
    }
    mutating func moveBy( x deltaX: Double, y deltaY: Double){
self = Point(x: x + deltaX, y: y + deltaY)
    }
}

var somePoint = Point(x: 4.0, y: 5.0)
if somePoint.isToTheRightOf(x: 1.0) {
    print("эта точка находится справа от линии где х = 1.0")
}

somePoint.moveBy(x: 2.0, y: 3.0)
print("\(somePoint)")

enum TriStateSwitch {
    case off, low, high
    mutating func next() {
        switch self {
        case .off:
            self = .low
      case .low:
        self = .high
            case .off:
            self = .low
            case .high:
            self = .off
        }
    }
}

var ovenLight = TriStateSwitch.low
ovenLight.next()
ovenLight
ovenLight.next()
ovenLight
