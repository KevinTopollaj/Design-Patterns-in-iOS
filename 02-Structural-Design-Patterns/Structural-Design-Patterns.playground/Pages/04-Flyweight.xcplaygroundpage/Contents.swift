import UIKit


// Concrete Flyweight

class CircleFlyweight {
  let color: UIColor
  let radius: CGFloat

  init(color: UIColor, radius: CGFloat) {
    self.color = color
    self.radius = radius
  }
}


// Create a Factory to Manage Flyweights

class CircleFlyweightFactory {
  private var flyweights: [String: CircleFlyweight] = [:]

  func getCircleFlyweight(color: UIColor) -> CircleFlyweight {
    let key = color.description

    if let existingFlyweight = flyweights[key] {
      return existingFlyweight
    } else {
      // Shared properties
      let newFlyweight = CircleFlyweight(color: color, radius: 10.0)
      flyweights[key] = newFlyweight
      return newFlyweight
    }
  }

}

// @Kevin_Topollaj

class Circle {
  let position: CGPoint
  let flyweight: CircleFlyweight

  init(position: CGPoint, flyweight: CircleFlyweight) {
    self.position = position
    self.flyweight = flyweight
  }

  func draw() {
    print("Drawing a circle at \(position) with radius \(flyweight.radius) and color \(flyweight.color).")
  }
}

// Usage
let flyweightFactory = CircleFlyweightFactory()

let circle1 = Circle(position: CGPoint(x: 10, y: 10),
                     flyweight: flyweightFactory.getCircleFlyweight(color: .red))
let circle2 = Circle(position: CGPoint(x: 20, y: 20),
                     flyweight: flyweightFactory.getCircleFlyweight(color: .red))

circle1.draw() // Both circles will share the same flyweight
circle2.draw()
