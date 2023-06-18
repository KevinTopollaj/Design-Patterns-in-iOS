import Foundation

struct Car {
  let brand: String
  let model: String
  let color: String
  let engineType: String
  let numberOfDoors: Int
}

enum BuilderError: Error {
  case incompleteData
}

class CarBuilder {
  private var brand: String?
  private var model: String?
  private var color: String?
  private var engineType: String?
  private var numberOfDoors: Int?

  func setBrand(_ brand: String) -> CarBuilder {
    self.brand = brand
    return self
  }

  func setModel(_ model: String) -> CarBuilder {
    self.model = model
    return self
  }

  func setColor(_ color: String) -> CarBuilder {
    self.color = color
    return self
  }

  func setEngineType(_ engineType: String) -> CarBuilder {
    self.engineType = engineType
    return self
  }

  func setNumberOfDoors(_ numberOfDoors: Int) -> CarBuilder {
    self.numberOfDoors = numberOfDoors
    return self
  }

  func build() throws -> Car {
    guard let brand = brand,
          let model = model,
          let color = color,
          let engineType = engineType,
          let numberOfDoors = numberOfDoors else {
      throw BuilderError.incompleteData
    }

    return Car(brand: brand, model: model,
               color: color, engineType: engineType,
               numberOfDoors: numberOfDoors)
  }
}

let carBuilder = CarBuilder()

let car = try carBuilder
                .setBrand("BMW")
                .setModel("M6")
                .setColor("Black")
                .setEngineType("V8")
                .setNumberOfDoors(4)
                .build()

print("Car: \(car)")
