import UIKit

// 1. Define a protocol for observers
protocol WeatherObserver: AnyObject {
  func update(temperature: Double)
}

// 2. Create a WeatherStation class (subject)
class WeatherStation {
  private var temperature: Double = 0
  private var observers = [WeatherObserver]()

  func add(observer: WeatherObserver) {
    observers.append(observer)
  }

  func remove(observer: WeatherObserver) {
    observers = observers.filter { $0 !== observer }
  }

  func setTemperature(_ temperature: Double) {
    self.temperature = temperature
    notifyObservers()
  }

  private func notifyObservers() {
    for observer in observers {
      observer.update(temperature: temperature)
    }
  }
}

// @ Kevin_Topollaj

// 3. Create observer classes
class ViewController1: WeatherObserver {
  func update(temperature: Double) {
    print("VC 1: \(temperature)°C")
  }
}

class ViewController2: WeatherObserver {
  func update(temperature: Double) {
    print("VC 2: Temperature is now \(temperature)°C")
  }
}

// 4. Usage example
let weatherStation = WeatherStation()
let display1 = ViewController1()
let display2 = ViewController2()

weatherStation.add(observer: display1)
weatherStation.add(observer: display2)

weatherStation.setTemperature(25.5)

weatherStation.remove(observer: display1)

weatherStation.setTemperature(23.5)
