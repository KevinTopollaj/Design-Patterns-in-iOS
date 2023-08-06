import Foundation

protocol BeverageComponent {
  func cost() -> Double
  func description() -> String
}

class Coffee: BeverageComponent {
  func cost() -> Double {
    return 2.0
  }

  func description() -> String {
    return "Coffee"
  }
}

class SugarDecorator: BeverageComponent {
  private let baseBeverage: BeverageComponent

  init(baseBeverage: BeverageComponent) {
    self.baseBeverage = baseBeverage
  }

  func cost() -> Double {
    return baseBeverage.cost() + 0.25
  }

  func description() -> String {
    return baseBeverage.description() + ", Sugar"
  }
}

class MilkDecorator: BeverageComponent {
  private let baseBeverage: BeverageComponent

  init(baseBeverage: BeverageComponent) {
    self.baseBeverage = baseBeverage
  }

  func cost() -> Double {
    return baseBeverage.cost() + 0.5
  }

  func description() -> String {
    return baseBeverage.description() + ", Milk"
  }
}

let coffee = Coffee()
print(coffee.description(), ":", coffee.cost())

let sugarDecorator = SugarDecorator(baseBeverage: coffee)
print(sugarDecorator.description(), ":", sugarDecorator.cost())

let milkDecorator = MilkDecorator(baseBeverage: sugarDecorator)
print(milkDecorator.description(), ":", milkDecorator.cost())
