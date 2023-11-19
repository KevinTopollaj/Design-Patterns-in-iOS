import Foundation

// Context class representing the order
class Order {
  private var state: OrderState

  init() {
    // Initial state is set to Pending
    self.state = PendingState()
  }

  func setState(state: OrderState) {
    self.state = state
  }

  func process() {
    state.process(order: self)
  }
}

// State protocol defining the interface for different order states
protocol OrderState {
  func process(order: Order)
}

// @Kevin_Topollaj

// Concrete state classes implementing the
// behaviour for different order states

class PendingState: OrderState {
  func process(order: Order) {
    print("Order is pending. Processing...")
    // Logic for processing a pending order
    order.setState(state: ShippedState())
  }
}

class ShippedState: OrderState {
  func process(order: Order) {
    print("Order is shipped. Processing...")
    // Logic for processing a shipped order
    order.setState(state: DeliveredState())
  }
}

class DeliveredState: OrderState {
  func process(order: Order) {
    print("Order is delivered. Processing...")
    // Logic for processing a delivered order
  }
}

// Client code
let order = Order()

// Processing the order in different states
order.process()
order.process()
order.process()
