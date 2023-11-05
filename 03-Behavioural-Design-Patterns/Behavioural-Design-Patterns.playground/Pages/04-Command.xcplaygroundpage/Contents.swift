import Foundation


// 1. Command
protocol Command {
  func execute()
}

// 2. Concrete Commands
class LightOnCommand: Command {
  private let light: Light

  init(light: Light) {
    self.light = light
  }

  func execute() {
    light.turnOn()
  }
}

class LightOffCommand: Command {
  private let light: Light

  init(light: Light) {
    self.light = light
  }

  func execute() {
    light.turnOff()
  }
}

// @Kevin_Topollaj

// 3. Receiver
class Light {
  func turnOn() {
    print("Light is on")
  }

  func turnOff() {
    print("Light is off")
  }
}

// 4. Invoker
class RemoteControl {
  private var command: Command?

  func setCommand(command: Command) {
    self.command = command
  }

  func pressButton() {
    command?.execute()
  }
}

// 5. Client
let remote = RemoteControl()
let livingRoomLight = Light()

let lightOnCommand = LightOnCommand(light: livingRoomLight)
let lightOffCommand = LightOffCommand(light: livingRoomLight)

remote.setCommand(command: lightOnCommand)
remote.pressButton() // Light is on

remote.setCommand(command: lightOffCommand)
remote.pressButton() // Light is off
