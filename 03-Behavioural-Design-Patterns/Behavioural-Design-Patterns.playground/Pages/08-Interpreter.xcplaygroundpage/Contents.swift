import UIKit

// Protocol
protocol DateElement {
  func interpret(date: Date) -> String
}

// Concrete implementations
class CustomFormatExpression: DateElement {

  private let format: String

  init(_ format: String) {
    self.format = format
  }

  func interpret(date: Date) -> String {
    let dateFormatter = DateFormatter()
    dateFormatter.dateFormat = format
    return dateFormatter.string(from: date)
  }

}


// @Kevin_Topollaj


// Context
class DateInterpreter {

  private var date: Date
  private var format: [DateElement]

  init(date: Date, format: [DateElement]) {
    self.date = date
    self.format = format
  }

  func interpret() -> String {
    return format.map { $0.interpret(date: date) }
                 .joined(separator: "-")
  }

}

// Usage
let currentDate = Date()

let format: [DateElement] = [
  CustomFormatExpression("dd-MMM-YYYY"),
  //    CustomFormatExpression("h:mm a")
]

let interpreter = DateInterpreter(date: currentDate,
                                  format: format)

let formattedDate = interpreter.interpret()

print("Formatted Date: \(formattedDate)")
