# Behavioural Design Patterns

## Table of contents

* [Intro](#Intro)
* [Observer](#Observer)
* [Memento](#Memento)




## Intro

![](img/p01.jpeg)


Behavioural design patterns in iOS are a set of design patterns that describe the behavior of objects in an iOS application.
These patterns help to define the relationships between objects and simplify the code, making it easier to maintain and modify.

1- Observer Pattern: Is used to establish a one-to-many relationship between objects. In this pattern, one object (the subject) maintains a list of its dependents (observers) and notifies them automatically of any state changes, usually by calling one of their methods.

2- Memento Pattern: Is used to restore an object to its previous state. This pattern is useful when dealing with undo/redo functionality or when a user needs to return to a previous state in an application.

3- Strategy Pattern: Is used to encapsulate a family of algorithms and make them interchangeable. In this pattern, the algorithms are interchangeable at runtime, and the client code can select the appropriate algorithm for a given task.

4- Command Pattern: Is used to encapsulate a request as an object, thereby allowing for the parameterization of clients with different requests. The client simply invokes a method on a command object, which executes the command at a later time.

5- Chain of Responsibility Pattern: Is used to handle requests by passing them through a chain of objects until an object handles the request. This pattern is useful when the exact object that will handle the request is unknown at runtime.

6- State Pattern: Is used to encapsulate the state of an object and the transitions between states. In this pattern, an object can change its behavior when its internal state changes.

7- Template Method Pattern: Is used to define the basic steps of an algorithm and allow subclasses to override some of the steps without changing the algorithm's structure.

8- Interpreter Pattern: Is used to define the grammar of a language and provide an interpreter to interpret the language. This pattern is useful for implementing domain-specific languages in an iOS application.

9- Visitor Pattern: Is used to separate an algorithm from an object structure on which it operates. In this pattern, a visitor object is created that operates on the object structure and applies the algorithm to each object in the structure.

10- Iterator Pattern: Is used to provide a way to access the elements of an aggregate object sequentially without exposing its underlying representation. This pattern is useful when you need to iterate over a collection of objects in a consistent manner.

In conclusion, the behavioural design patterns in iOS provide a way to describe the behavior of objects in an iOS application.
These patterns simplify the code, make it easier to maintain and modify, and allow for the creation of more complex applications.



## Observer

- Observer Design Pattern is a behavioral design pattern that defines a one-to-many dependency between objects.

- It ensures that when one object (the Subject) changes its state, all its dependents (Observers) are notified and updated automatically.

- This pattern is often used for implementing distributed event handling systems and is fundamental in various areas of software development.

- In iOS, the Observer Design Pattern is used to create a mechanism where objects can subscribe to changes in another object, often used for implementing UI updates when underlying data changes.



### Implementation:

- Let's create a simple example of the Observer Design Pattern in iOS.

- Let's take as an example a basic weather app where the temperature is the Subject being observed, and multiple displays (Observers) are updated when the temperature changes.

- We define a `WeatherObserver` protocol to ensure that all observers implement the `update` method.

```swift
// 1. Define a protocol for observers

protocol WeatherObserver: AnyObject {
  func update(temperature: Double)
}
```

- The `WeatherStation` class maintains a list of observers and notifies them when the temperature changes.

```swift
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
```

- We create two observer classes: `ViewController1` and `ViewController2`.

```swift
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
```

- We add the observers to the `WeatherStation`, and when the temperature is updated, all observers are notified and react accordingly.

```swift
// 4. Usage example
let weatherStation = WeatherStation()
let display1 = ViewController1()
let display2 = ViewController2()

weatherStation.add(observer: display1)
weatherStation.add(observer: display2)

weatherStation.setTemperature(25.5)

weatherStation.remove(observer: display1)

weatherStation.setTemperature(23.5)
```


### Positive aspects:

1. `Decoupling`: The Observer pattern decouples the subject (WeatherStation) from its observers (ViewController1, ViewController2), making it easier to add or remove observers without affecting the subject.

2. `Dynamic updates`: Observers receive updates automatically when the subject's state changes, allowing for real-time, dynamic behavior.

3. `Reusability`: It promotes the reusability of both subjects and observers, as you can add new observers for different purposes.

4. `Testability`: The pattern naturally supports TDD since you can write tests for observers and the subject's behavior separately.



### Negative aspects:

1. `Memory Management`: In the above example, we used a simple array to store observers. You need to be careful about strong reference cycles to prevent memory leaks. Use weak references or other memory management techniques when necessary.

2. `Complexity`: In more complex scenarios, managing a large number of observers can become challenging. You may need to implement additional logic for managing observer lifecycles efficiently.



### Conclusions:

- The Observer Design Pattern is a valuable tool in iOS development for creating loosely coupled, event-driven systems.

- It facilitates dynamic updates and enhances code maintainability.

- However, it's essential to handle memory management properly.

- When used correctly, it can significantly improve the modularity and maintainability of your code, allowing for better scalability and testability.



## Memento

- The Memento Design Pattern is a behavioral pattern that allows you to capture and externalize the internal state of an object without violating encapsulation, and then later restore that object to its previous state.

- It's often used in scenarios where you need to implement undo/redo functionality, maintain a history of an object's state, or simply save and restore an object's state.

- The Memento pattern consists of three key participants:

- `Originator`: This is the object whose state you want to save or restore.

- `Memento`: This is an object that represents the state of the `Originator` at a specific point in time. It should be designed to be immutable, so the state can't be changed once it's stored.

- `Caretaker`: The Caretaker is responsible for storing and managing the Mementos.



### Implementation:

- Let's implement the Memento pattern in the context of a simple iOS app for managing a to-do list.

```swift
// Originator - the object whose state needs to be saved

class Task {
  var title: String
  var completed: Bool

  init(title: String) {
    self.title = title
    self.completed = false
  }

  // Create a Memento to save the state
  func createMemento() -> TaskMemento {
    return TaskMemento(title: title, completed: completed)
  }

  // Restore the state from a Memento
  func restore(from memento: TaskMemento) {
    title = memento.title
    completed = memento.completed
  }
}
```

```swift
// Memento - represents the state of the object

struct TaskMemento {
  let title: String
  let completed: Bool
}
```

```swift
// Caretaker class - is responsible for maintaining the history of the Task object's state.

class TaskHistory {
  private(set) var history: [TaskMemento] = []

  func addMemento(_ memento: TaskMemento) {
    history.append(memento)
  }

  func getMemento(at index: Int) -> TaskMemento {
    return history[index]
  }
}
```

```swift
// Example: @Kevin_Topollaj

let task = Task(title: "Buy groceries")
task.completed = true

let memento = task.createMemento()

let taskHistory = TaskHistory()
taskHistory.addMemento(memento)

let lastMemento = taskHistory.getMemento(at: taskHistory.history.count - 1)

task.restore(from: lastMemento)

print(task.title) // Buy groceries
print(task.completed) // true
```



### Positive aspects:

- `Undo/Redo`: The Memento pattern allows for easy implementation of undo and redo functionality.

- `Encapsulation`: It preserves the encapsulation of the object's state by externalizing it into a Memento object.

- `Snapshot`: You can take snapshots of an object's state at any point in time, which is useful for history tracking.

- `Testability`: Using the Memento pattern promotes testability. You can test the Originator's state-saving and state-restoring functionality independently, which is in line with the principles of TDD.



### Negative aspects:

- `Memory Usage`: Storing multiple Mementos can consume memory, especially if you have many objects with extensive state.

- `Complexity`: In cases where the objects have complex states, implementing the Memento pattern can lead to verbose code. Managing a large number of Mementos and their associated history can become challenging.



### Conclusions:

- The Memento Design Pattern in iOS is a powerful tool for managing and restoring an object's state while maintaining encapsulation.

- It's particularly useful for scenarios like implementing undo/redo features.

- However, it should be used judiciously, as it can increase memory usage when dealing with large objects, and the code can become more complex for objects with extensive state.
