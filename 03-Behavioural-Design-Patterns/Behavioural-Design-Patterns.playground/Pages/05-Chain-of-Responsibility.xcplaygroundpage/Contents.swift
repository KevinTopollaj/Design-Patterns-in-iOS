import Foundation

// Step 1: Define the Handler protocol
protocol PurchaseHandler: AnyObject {
  var nextHandler: PurchaseHandler? { get set }
  func processPurchase(_ amount: Double)
}

// Step 2: Implement concrete handlers
class CEO: PurchaseHandler {
  var nextHandler: PurchaseHandler?

  func processPurchase(_ amount: Double) {
    if amount <= 10000 {
      print("CEO approves the purchase.")
    } else {
      print("Purchase request denied.")
    }
  }
}

class Director: PurchaseHandler {
  var nextHandler: PurchaseHandler?

  func processPurchase(_ amount: Double) {
    if amount <= 5000 {
      print("Director approves the purchase.")
    } else {
      nextHandler?.processPurchase(amount)
    }
  }
}

// @Kevin_Topollaj

class Manager: PurchaseHandler {
  var nextHandler: PurchaseHandler?

  func processPurchase(_ amount: Double) {
    if amount <= 1000 {
      print("Manager approves the purchase.")
    } else {
      nextHandler?.processPurchase(amount)
    }
  }
}

// Step 3: Client code that uses the chain
class PurchaseManager {
  private var handlerChain: PurchaseHandler

  init() {
    // Creating the chain
    let ceo = CEO()
    let director = Director()
    let manager = Manager()

    director.nextHandler = ceo
    manager.nextHandler = director

    handlerChain = manager
  }

  func processPurchaseRequest(_ amount: Double) {
    handlerChain.processPurchase(amount)
  }
}

// Step 4: Usage
let purchaseManager = PurchaseManager()
purchaseManager.processPurchaseRequest(8000)
