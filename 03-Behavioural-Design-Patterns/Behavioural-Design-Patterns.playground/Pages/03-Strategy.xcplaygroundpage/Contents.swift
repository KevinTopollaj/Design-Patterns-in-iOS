import Foundation

// 1. Define the strategy protocol
protocol PaymentStrategy {
  func processPayment(amount: Double)
}

// 2. Implement concrete payment strategies
class CreditCardPayment: PaymentStrategy {
  func processPayment(amount: Double) {
    print("Processing credit card payment for $\(amount)")
  }
}

class PayPalPayment: PaymentStrategy {
  func processPayment(amount: Double) {
    print("Processing PayPal payment for $\(amount)")
  }
}

// 3. Create a context class that uses the strategy
class PaymentProcessor {
  private var paymentStrategy: PaymentStrategy

  init(paymentStrategy: PaymentStrategy) {
    self.paymentStrategy = paymentStrategy
  }

  func performPayment(amount: Double) {
    paymentStrategy.processPayment(amount: amount)
  }
}

// @Kevin_Topollaj

// 4. Client code
let orderAmount = 100.0

let creditCardPayment = CreditCardPayment()
let payPalPayment = PayPalPayment()

let paymentProcessor1 = PaymentProcessor(paymentStrategy: creditCardPayment)
paymentProcessor1.performPayment(amount: orderAmount)

let paymentProcessor2 = PaymentProcessor(paymentStrategy: payPalPayment)
paymentProcessor2.performPayment(amount: orderAmount)
