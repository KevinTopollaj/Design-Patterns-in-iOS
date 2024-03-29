# Behavioural Design Patterns

## Table of contents

* [Intro](#Intro)
* [Observer](#Observer)
* [Memento](#Memento)
* [Strategy](#Strategy)
* [Command](#Command)
* [Chain of Responsibility](#Chain-of-Responsibility)
* [State](#State)
* [Template Method](#Template-Method)
* [Interpreter](#Interpreter)
* [Visitor](#Visitor)
* [Iterator](#Iterator)



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




## Strategy

- The Strategy Design Pattern is a behavioral pattern that allows you to define a family of objects, encapsulate each one of them, and make them interchangeable.

- It enables the client to choose the appropriate object dynamically at runtime without altering the context that uses these objects.

- This pattern is especially useful when you have multiple ways to perform a specific task or when you want to decouple the client from the implementation details.



### Implementation:

- Let's implement a real-world example of a strategy pattern for a payment processing system in an iOS app.

- We will create a strategy pattern for different payment methods (e.g., credit card, PayPal).

```swift
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
```



### Positive aspects:

- `Open-Closed Principle`: The Strategy Pattern allows you to add new payment methods or objects without modifying existing code, following the Open-Closed Principle.

- `Highly Testable`: The pattern encourages the use of protocols, making it easy to write unit tests for each payment strategy independently.

- `Clean and Readable Code`: The pattern promotes separation of concerns and cleaner code by isolating different strategies.



### Negative aspects:

- `Complexity`: For simple scenarios with only a few strategies, implementing the Strategy Pattern might introduce unnecessary complexity.

- `Increased Number of Objects`: Introducing multiple strategies can lead to an increased number of objects, which might make the codebase harder to manage in very large projects.



### Conclusions:

- The Strategy Design Pattern is a powerful tool when you need to provide multiple interchangeable objects or behaviors in your iOS application.

- It promotes clean, maintainable code and adheres to the SOLID principles.

- However, it's essential to use it judiciously, considering the complexity it may add to your project.

- Always aim for simplicity and readability while applying design patterns in your application.




## Command

- Is used to encapsulate a request as an object, thereby allowing for the parameterization of clients with different requests.

- The client simply invokes a method on a command object, which executes the command at a later time.

- This pattern typically consists of the following components:

1. `Command`: Represents a request and contains all the necessary information to execute it. It defines an interface with an `execute` method.

2. `Concrete Command`: Implements the `Command` interface and contains the specific behavior associated with the command.

3. `Receiver`: Contains the code and data necessary for performing the action.

4. `Invoker`: Invokes the command and manages the command's execution.



### Implementation:

- Let's say we're building a remote control for a home automation system.
- We can use the Command Pattern to control different devices (e.g., lights, fans, or doors).
- Here's an example implementation:

```swift
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
```



### Positive aspects:

- `Separation of Concerns`: The Command Pattern decouples the sender from the receiver, making the code more maintainable and flexible.

- `Dynamic Commands`: You can add new commands without modifying existing code, promoting extensibility.

- `Testability`: Each command can be tested in isolation, which fits well with TDD principles.



### Negative aspects:

- `Complexity`: In simple scenarios, the Command Pattern can add unnecessary complexity.

- `Overhead`: It may create a significant number of small command objects, which can affect performance and memory usage.




### Conclusions:

- The Command Pattern is a valuable tool when you need to decouple senders and receivers of commands, or dynamically extend your application with new commands.

- However, it should be used judiciously to avoid unnecessary complexity and overhead.




## Chain of Responsibility

- The Chain of Responsibility is a behavioral design pattern where a request is passed through a chain of handlers.

- Each handler decides either to process the request or to pass it along the chain.

- The idea is to decouple the sender and receiver of a request.


### Implementation:

- Let's consider a real-world example where we handle a purchase requests in an e-commerce app.

```swift

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
```


### Positive aspects:

- `Flexibility`: Handlers can be added, modified, or removed without affecting the client code.

- `Single Responsibility`: Each handler has a single responsibility, making the code more maintainable.

- `Encapsulation`: The details of how a request is handled are encapsulated within each handler.



### Negative aspects:

- `Guaranteed Handling`: There's no guarantee that a request will be handled. If the end of the chain is reached and no handler can process the request, it may go unhandled.

- `Performance Overhead`: The chain traversal may add some overhead, especially if the chain is long.

- `Complexity`: In some scenarios, having too many handlers or a complex chain might make the code harder to understand.



### Conclusions:

- The Chain of Responsibility pattern is a powerful tool for handling requests in a flexible and decoupled way.

- It's particularly useful when you have a sequence of processing steps and want to avoid coupling the sender to the concrete receivers.

- However, it's essential to use it judiciously, considering the complexity and potential pitfalls.




## State

- The State Design Pattern allows an object to alter its behaviour when its internal state changes.
- The pattern encapsulates the states into separate classes and delegates the state-specific behaviour to these classes.
- This helps in making the object's behaviour more modular and extensible.



### Implementation:

- In this example we have a ordering process, we have an `Order` class representing the context, and different state classes such as `PendingState`, `ShippedState`, and `DeliveredState` representing the various states an order can be in.

```swift
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

/*
Order is pending. Processing...
Order is shipped. Processing...
Order is delivered. Processing...
*/
```


### Positive aspects:

- `Modularity`: The State Design Pattern promotes modularity by encapsulating the behaviour of each state in separate classes. This makes it easier to understand, maintain, and extend the code.

- `Flexibility`: Adding new states or modifying existing ones is easier without affecting the context class (Order in this case). Each state class is responsible for its own behaviour.

- `Readability`: The code becomes more readable as each state is represented by its own class, making it clear and organised.

- `Testability`: The separation of concerns allows for easier testing. You can write unit tests for each state class independently.



### Negative aspects:

- `Complexity`: For simple scenarios, introducing the State Design Pattern might be overkill and could add unnecessary complexity.

- `Number of Classes`: As the number of states increases, the number of state classes also increases, potentially leading to a larger codebase.

- `Context Awareness`: The context class needs to be aware of all possible states, which might lead to a large switch or if-else structure if not handled properly.



### Conclusions:

- The State Design Pattern is a powerful tool for managing the behaviour of an object as its internal state changes.
- In the context of iOS development, it can be particularly useful for managing the state of view controllers, animations, or any system where behaviour changes happen based on internal conditions.

- However, like any design pattern, it should be applied judiciously, considering the specific requirements of the application.




## Template Method

- The Template Method design pattern is a behavioral pattern that defines the skeleton of an algorithm in the superclass but lets subclasses alter specific steps of the algorithm without changing its structure.

- This pattern promotes code reusability and allows for the customisation of certain steps within a common algorithm.



### Implementation:

- Let's consider a real-world scenario of building a document processing system for an iOS app.

- The overall document processing involves downloading a document, parsing its content, and saving it in a specific format.

- The Template Method pattern can be applied to encapsulate the common algorithm while allowing subclasses to implement the specific steps.

- This example shows the processing for one type of document (PDF) but we can follow the same logic to implement it for other type of documents (Word, Excel ...etc)

```swift
// Step 1: Create a template class with a template method
class DocumentProcessorTemplate {

  // Template method
  func processDocument() {
    downloadDocument()
    parseContent()
    saveDocument()
    // Additional common steps can be added here
  }

  // Step 2: Define abstract methods to be implemented by subclasses
  func downloadDocument() {
    fatalError("Subclasses must implement this method")
  }

  func parseContent() {
    fatalError("Subclasses must implement this method")
  }

  func saveDocument() {
    fatalError("Subclasses must implement this method")
  }

}

// @Kevin_Topollaj

// Step 3: Create concrete subclasses implementing the abstract methods
class PDFDocumentProcessor: DocumentProcessorTemplate {

  override func downloadDocument() {
    // Implementation for downloading a PDF document
    print("Downloading PDF document")
  }

  override func parseContent() {
    // Implementation for parsing PDF content
    print("Parsing PDF content")
  }

  override func saveDocument() {
    // Implementation for saving the processed PDF document
    print("Saving processed PDF document")
  }

}

let pdfProcessor = PDFDocumentProcessor()
pdfProcessor.processDocument()
```



### Positive aspects:

- `Code Reusability`: The common algorithm is defined in the template class, promoting code reuse across different subclasses.

- `Encapsulation`: The template method encapsulates the overall algorithm, hiding the implementation details of individual steps from the client code.

- `Flexibility`: Subclasses can provide custom implementations for specific steps, allowing for flexibility in adapting the algorithm.



### Negative aspects:

- `Rigidity`: Changes to the overall algorithm structure in the template class can affect all subclasses, potentially requiring modifications in multiple places.

- `Complexity`: Introducing too many abstract methods or steps in the template method may lead to increased complexity, making the pattern harder to understand.



### Conclusions:

- The Template Method pattern is a powerful tool for designing frameworks where the overall algorithm structure remains constant, but certain steps can be customized by subclasses.

- It enhances code reusability and provides a structured approach to algorithm design.

- However, careful consideration is needed to balance flexibility and potential complexities introduced by the pattern.




## Interpreter

- Interpreter is a behavioural pattern, in this example, we are using the Interpreter to allow you to customise how dates are displayed.
- We can define the preferred date format, like "dd-MMM-YYYY".
- The Interpreter Design Pattern is employed to interpret and format dates based on provided expressions.


### Implementation:

- We create the `DateElement` that will be the protocol used in this Interpret design pattern example. 

- We then introduce the `CustomFormatExpression` as a new type of expression that conforms to the `DateElement` protocol.

- Then the `DateInterpreter` class takes a `date` and a `format` as input and it interprets this format, applying each expression to the input date. 

- The `CustomFormatExpression` uses `DateFormatter` to interpret the defined formats.

```swift
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
    return format.map { $0.interpret(date: date) }.joined(separator: "-")
  }

}

// Usage
let currentDate = Date()

let format: [DateElement] = [
  CustomFormatExpression("dd-MMM-YYYY"),
  //    CustomFormatExpression("h:mm a")
]

let interpreter = DateInterpreter(date: currentDate, format: format)
let formattedDate = interpreter.interpret()

print("Formatted Date: \(formattedDate)")
```


### Positive aspects:

- `Flexibility`: The Interpreter pattern allows for flexibility in date formatting by enabling users to define custom format expressions dynamically.

- `Extensibility`: The design is extensible, allowing the addition of new concrete implementations of `DateElement` without modifying the existing code.

- `Encapsulation`: Each concrete implementation encapsulates the logic for interpreting a specific date element, promoting a clear separation of concerns.



### Negative aspects:

- `Limited Expressiveness`: While the example is suitable for common date formats, the current design might be limited in handling more complex date formatting scenarios or expressions.

- `Potential Error Handling Issues`: The example lacks explicit error handling for scenarios where the date format is incorrect or unsupported.



### Conclusions:

- The Interpreter pattern, as demonstrated in the example, offers flexibility and extensibility for simple date formatting scenarios.

- It excels in providing users with the ability to define custom date formats.

- However, for more complex formatting requirements or error-handling scenarios, additional considerations and enhancements may be needed to ensure a robust and adaptable solution.




## Visitor

- The Visitor pattern is a behavioral design pattern that defines a way to traverse an object structure without changing its core logic.

- It allows you to define new operations on a set of objects without altering their structures.

- This is achieved by separating the algorithm from the objects on which it operates.

- `Element`: Represents the interface for the elements in the object structure.
- `ConcreteElement`: Implements the Element interface and provides an accept method that accepts a visitor.
- `Visitor`: Represents the interface for the concrete visitors.
- `ConcreteVisitor`: Implements the Visitor interface and defines the behavior for each component.
- `ObjectStructure`: Represents the object structure and typically provides a way to iterate over its elements.

- For each interface, `Element` and `Visitor` we can also have an extension that provides us with a default implementation for common use-cases.


### Implementation:

- Consider a mobile app that models a zoo with different animals.
- We want to perform various operations on these animals, such as feeding, cleaning etc...

```swift
// Element protocol representing a zoo animal
protocol ZooAnimal {
  func accept(visitor: ZooAnimalVisitor)
}

// ConcreteElement representing a Lion
class Lion: ZooAnimal {
  func accept(visitor: ZooAnimalVisitor) {
    visitor.visitLion(self)
  }
}

// ConcreteElement representing a Monkey
class Monkey: ZooAnimal {
  func accept(visitor: ZooAnimalVisitor) {
    visitor.visitMonkey(self)
  }
}

// ZooAnimalVisitor protocol
protocol ZooAnimalVisitor {
  func visitLion(_ lion: Lion)
  func visitMonkey(_ monkey: Monkey)
}

// ConcreteVisitor implementing operations on zoo animals
class Zookeeper: ZooAnimalVisitor {

  func visitLion(_ lion: Lion) {
    print("Feeding the lion")
  }

  func visitMonkey(_ monkey: Monkey) {
    print("Cleaning the monkey enclosure")
  }

}

// @Kevin_Topollaj

// ObjectStructure representing the zoo
class Zoo {
  private var zooAnimals: [ZooAnimal] = []
  private let zooAnimalVisitor: ZooAnimalVisitor

  init(zooAnimalVisitor: ZooAnimalVisitor) {
    self.zooAnimalVisitor = zooAnimalVisitor
  }

  func addAnimal(_ zooAnimal: ZooAnimal) {
    zooAnimals.append(zooAnimal)
  }

  func performOperations() {
    for zooAnimal in zooAnimals {
      zooAnimal.accept(visitor: zooAnimalVisitor)
    }
  }
}

// Example Usage
let zookeeper = Zookeeper()
let zoo = Zoo(zooAnimalVisitor: zookeeper)

zoo.addAnimal(Lion())
zoo.addAnimal(Monkey())

zoo.performOperations()
```



### Positive aspects:

- `Separation of Concerns`: The Visitor pattern separates the algorithm (visitor) from the object structure, promoting a clean and modular design.

- `Open/Closed Principle`: It allows for easy addition of new operations (ConcreteVisitor) without modifying the existing elements (ConcreteElement).

- `Maintainability`: Since the logic for each operation is encapsulated within the concrete visitor classes, modifications to one operation do not affect others.



### Negative aspects:

- `Complexity`: The Visitor pattern introduces additional classes and protocols, which can lead to an increased overall complexity of the code. 

- `Performance Overhead`: The Visitor pattern might introduce some performance overhead due to the dynamic dispatch of methods.

- `Limited Reusability`: The pattern may not be the best fit for every situation. It's more suitable for scenarios where the object structure is relatively stable, and new operations are added frequently. In cases where the object structure changes frequently, the pattern may not provide significant benefits.


### Conclusions:

- The Visitor Design Pattern is a powerful tool when you need to perform frequent changes or additions to operations on a stable set of classes.

- It enhances maintainability and flexibility at the cost of increased complexity.

- However, like any design pattern, it should be used judiciously, considering the specific requirements and trade-offs.



## Iterator

- The Iterator Design Pattern is a behavioral design pattern that provides a way to access the elements of a collection sequentially without exposing its underlying representation.

- It involves defining an interface for accessing the elements of a collection and keeping track of the current position within that collection.


### Implementation:

- Let's consider a real-world scenario where we have a collection of tasks in a to-do list, and we want to iterate through these tasks using the Iterator Design Pattern.

```swift
import Foundation

// Task represents an element in the collection
struct Task {
  let title: String
  let priority: Int
}

// Iterator protocol defines methods for iterating through the collection
protocol TaskIterator {
  func hasNext() -> Bool
  func next() -> Task?
}

// Concrete implementation of the Iterator protocol
class ToDoListIterator: TaskIterator {
  private var tasks: [Task]
  private var position: Int = 0

  init(tasks: [Task]) {
    self.tasks = tasks
  }

  func hasNext() -> Bool {
    return position < tasks.count
  }

  func next() -> Task? {
    guard hasNext() else { return nil }
    defer { position += 1 }
    return tasks[position]
  }
}

// @Kevin_Topollaj

// Collection interface with a method to create an iterator
protocol ToDoList {
  func createIterator() -> TaskIterator
}

// Concrete implementation of the Collection interface
class ToDoListCollection: ToDoList {
  private var tasks: [Task] = []

  func addTask(_ task: Task) {
    tasks.append(task)
  }

  func createIterator() -> TaskIterator {
    return ToDoListIterator(tasks: tasks)
  }
}

// Example usage
let toDoList = ToDoListCollection()
toDoList.addTask(Task(title: "Buy groceries", priority: 1))
toDoList.addTask(Task(title: "Complete project", priority: 2))
toDoList.addTask(Task(title: "Exercise", priority: 3))

let iterator = toDoList.createIterator()

while iterator.hasNext() {
  if let task = iterator.next() {
    print("Task: \(task.title), Priority: \(task.priority)")
  }
}
```



### Positive aspects:

- `Separation of Concerns`: The Iterator pattern separates the logic for iterating over a collection from the collection itself, promoting a clean and modular design.

- `Encapsulation`: The internal structure of the collection is encapsulated, and clients only interact with the Iterator interface, reducing dependencies.



### Negative aspects:

- `Complexity`: For simple collections, implementing the Iterator pattern might seem like overengineering.

- `Duplication`: In Swift, some collections already provide built-in iterators, so using the Iterator pattern might lead to duplication of functionality.



### Conclusions:

- The Iterator Design Pattern is beneficial when you need to traverse a collection without exposing its internal structure.
- It promotes code flexibility and maintainability, making it easier to change the traversal algorithm without affecting the client code.
