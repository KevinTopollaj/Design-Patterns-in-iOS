# Structural Design Patterns

## Table of contents

* [Intro](#Intro)
* [Adapter](#Adapter)
* [Decorator](#Decorator)
* [Facade](#Facade)
* [Flyweight](#Flyweight)
* [Bridge](#Bridge)
* [Composite](#Composite)




## Intro

![](img/p01.jpeg)


Structural Design Patterns in iOS are a set of design patterns that aim to solve problems related to object composition, interface design, and inheritance.
These patterns help to create flexible and reusable code that can adapt to changing requirements and reduce the complexity of software development.
There are six most common structural design patterns in iOS:

1- Adapter pattern:

The Adapter pattern allows the integration of existing classes that don't have the required interface with other classes. It acts as a bridge between two incompatible interfaces, making it possible for them to work together. In iOS, this pattern is commonly used to convert an object's interface to another object's interface.

2- Decorator pattern:

The Decorator pattern allows adding additional functionality to an object dynamically without changing its structure. In iOS, this pattern is commonly used to add functionality to UIKit objects, such as UIView, by creating a subclass of it and adding extra features.

3- Facade pattern:

The Facade pattern provides a simple interface to a complex system, hiding its internal complexity from clients. In iOS, this pattern is commonly used to simplify the use of complex APIs by providing a simpler interface to the client code.

4- Flyweight pattern:

The Flyweight pattern is used to reduce memory usage by sharing data across multiple objects. In iOS, this pattern is commonly used to optimize the performance of UIKit objects by reusing existing instances instead of creating new ones.

5- Bridge pattern:

The Bridge pattern decouples an abstraction from its implementation so that the two can vary independently. In iOS, this pattern is commonly used to separate the user interface from the underlying data model by defining an interface that connects the two.

6- Composite pattern:

The Composite pattern allows you to treat a group of objects in the same way as a single instance of that object. It creates a hierarchical tree structure of objects, where each object can be treated as a composite or an individual object. In iOS, this pattern is commonly used to create complex views by grouping simple views together into a hierarchy. It allows you to treat the group of views as a single view and apply operations on the group as a whole, making it easier to manage and update the user interface.

In summary, the six structural design patterns in iOS are the Adapter pattern, Decorator pattern, Facade pattern, Flyweight pattern, Bridge pattern, and Composite pattern.

These patterns are used to solve problems related to object composition, interface design, and inheritance, and can help create flexible and reusable code that can adapt to changing requirements.



## Adapter

- The `Adapter Design Pattern` is a structural pattern that allows objects with incompatible interfaces to work together.
- It acts as a bridge between the two interfaces, making them compatible without changing their existing code.
- This pattern is especially useful when integrating existing or third-party components into a new system or when refactoring existing code without modifying its interface.

- The key components of the `Adapter Design Pattern` are:

1- `Target`: This is the interface that the client code expects to work with. It defines the methods that the client code calls.

2- `Adapter`: This is the class that adapts the interface of the `Adaptee` to the `Target` interface. It implements the `Target` interface and internally uses an instance of the `Adaptee` to perform the required operations.

3- `Adaptee`: This is the existing or third-party class that has an incompatible interface. It contains the functionality that we want to integrate with the client code.


### Implementation:

- Let's consider a real-world example in an iOS app where we want to display weather information from a weather data provider: "WeatherProvider".
- The provider has a different interface for retrieving weather data.
- We want to use a common interface, say `WeatherService`, for our app to get weather data, so we need to create adapters for the provider to make it compatible with `WeatherService`.

- First, we have the Weather enum:

```swift
enum Weather: String {
  case sunny, rainy
}
```

- Let's define the `WeatherService` protocol:

```swift
// Target
protocol WeatherService {
  func getCurrentWeather() -> String
}
```

- Now, let's create the `Adaptee` class for the weather provider:

```swift
// Adaptee
class WeatherProvider {
  func fetchWeatherData() -> Weather {
    return .sunny
  }
}
```

- Next, we create the adapter for the provider conforming to the `WeatherService` protocol:

```swift
class WeatherProviderAdapter: WeatherService {
  private let weatherProvider: WeatherProvider

  init(weatherProvider: WeatherProvider) {
    self.weatherProvider = weatherProvider
  }

  func getCurrentWeather() -> String {
    let weather = weatherProvider.fetchWeatherData()
    return weather.rawValue.capitalized
  }
}
```

- Now, the client code can use the `WeatherService` interface to get weather data from the provider without knowing the details for the provider implementation:

```swift
let weatherProvider = WeatherProvider()
let providerService = WeatherProviderAdapter(weatherProvider: weatherProvider)
let weatherString = providerService.getCurrentWeather()
```



### Positive aspects:

1- `Flexibility`: The Adapter pattern allows us to integrate new functionality or third-party components into existing systems without modifying the client code.

2- `Maintainability`: By using adapters, we keep the existing code untouched, reducing the risk of introducing new bugs when integrating new components.

3- `Reusability`: Adapters can be reused in multiple parts of the codebase, making it easier to integrate various implementations of the same interface.

4- `Testability`: The Adapter pattern can be implemented with TDD, ensuring that adapters are thoroughly tested and behave as expected.



### Negative aspects:

1- `Complexity`: The Adapter pattern can introduce additional complexity to the codebase, especially if many adapters are required.

2- `Overhead`: Adapters might introduce some performance overhead due to additional layers of indirection.

3- `Interface bloat`: If there are numerous methods to be adapted, the Adapter class might become too large, leading to an interface with too many methods.



### Conclusions:

- The `Adapter Design Pattern` is a powerful tool for integrating existing or third-party components into your iOS app without disrupting the existing codebase.
- It promotes code reusability, maintainability, and testability.
- By creating adapters, you can ensure that incompatible interfaces work seamlessly together, fostering a flexible and modular architecture.

- However, it's essential to be mindful of potential complexities and overhead that may arise when using this pattern.
- Proper design and consideration of the specific use case can help mitigate any negative aspects.
- Additionally, applying TDD principles to the adapter implementation will help guarantee its correctness and reliability.




## Decorator

- The `Decorator` Design Pattern is a structural pattern that allows you to dynamically add additional behavior or responsibilities to objects without modifying their structure.
- It is useful when you need to extend the functionality of a class in a flexible and reusable way.
- The pattern involves creating a set of decorator classes that wrap the original class and provide additional features.


### Implementation:

- Let's consider a real-world example where we have a basic iOS application that provides different types of beverages (e.g., coffee).
- We want to offer various extras or toppings (e.g., milk, sugar) that can be added to the beverage.
- Instead of creating separate classes for each combination of the beverage and toppings, we'll use the `Decorator` pattern.

- First, let's define the base protocol for the beverage:

```swift
protocol BeverageComponent {
  func cost() -> Double
  func description() -> String
}
```

- Next, we implement a concrete beverage class:

```swift
class Coffee: BeverageComponent {
  func cost() -> Double {
    return 2.0
  }

  func description() -> String {
    return "Coffee"
  }
}
```

- Now, let's create the decorator classes for toppings:

```swift
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
```

- This is how we can initialise and use them together:

```swift
let coffee = Coffee()
print(coffee.description(), ":", coffee.cost())

let sugarDecorator = SugarDecorator(baseBeverage: coffee)
print(sugarDecorator.description(), ":", sugarDecorator.cost())

let milkDecorator = MilkDecorator(baseBeverage: sugarDecorator)
print(milkDecorator.description(), ":", milkDecorator.cost())
```



### Positive aspects:

1- `Flexibility`: The Decorator pattern allows us to add or remove decorations dynamically at runtime without modifying the original classes, making it easy to mix and match functionalities.

2- `Reusability`: Decorators are independent and can be reused in different contexts, providing different combinations of behavior to different objects.

3- `Open/Closed Principle`: The pattern follows the Open/Closed Principle, as it allows extending the behavior of classes without modifying their code, reducing the risk of introducing bugs in existing functionality.


### Negative aspects:

1- `Complexity`: The Decorator pattern can lead to a large number of classes when multiple decorators are used, potentially making the codebase harder to manage.

2- `Order of wrapping`: The order in which decorators are applied can affect the final result, which may lead to unintended behavior if not carefully managed.

3- `Maintenance`: If the base component's interface changes, it can impact the decorators, requiring modifications in multiple classes.



### Conclusions:


- The Decorator pattern is a powerful tool for enhancing the behavior of objects in a flexible and dynamic way.
- It allows us to avoid class explosion and provides a cleaner approach to extend functionalities compared to traditional subclassing.
- However, it should be used judiciously, and careful consideration should be given to the order of decorators to achieve the desired result.



## Facade

- The Facade pattern is a structural design pattern that provides a simplified interface to a complex subsystem, making it easier to use and understand.

- The Facade pattern hides the complexities of a system and provides a unified interface to interact with it.
- It's like a simplified "facade" or front-end that shields clients from the underlying intricacies, making the codebase more maintainable and easier to use.

### Implementation:

- Suppose we are developing an iOS app for a music streaming service.
- This service has various subsystems such as authentication and playlist management.
- We'll use the Facade pattern to simplify interactions with these subsystems.

```swift
// Subsystem: Authentication
protocol AuthServiceProtocol {
  func login(username: String, password: String) -> Bool
}

class AuthService: AuthServiceProtocol {
  func login(username: String, password: String) -> Bool {
    // Simulate authentication logic
    return username == "Bob" && password == "bob123"
  }
}

// Subsystem: Playlist Management
protocol PlaylistServiceProtocol {
  func createPlaylist(name: String) -> String
}

class PlaylistService: PlaylistServiceProtocol {
  func createPlaylist(name: String) -> String {
    // Simulate playlist creation logic
    return "Playlist '\(name)' created"
  }
}
```

```swift
// Facade
class MusicAppFacade {
  private let authService: AuthServiceProtocol
  private let playlistService: PlaylistServiceProtocol

  init(authService: AuthServiceProtocol,
       playlistService: PlaylistServiceProtocol) {

    self.authService = authService
    self.playlistService = playlistService
  }

  func createPlaylist(username: String,
                      password: String,
                      playlistName: String) -> Result<String, Error> {

    if authService.login(username: username, password: password) {
      let welcomeMessage = "Welcome to the music app: \(username)"
      let playlist = playlistService.createPlaylist(name: playlistName)
      return .success("\(welcomeMessage)\n\(playlist)")
    } else {
      return .failure(NSError(domain: "LoginErrorDomain", code: 1, userInfo: nil))
    }
  }
}
```

```swift
// Usage
let authService = AuthService()
let playlistService = PlaylistService()
let musicApp = MusicAppFacade(authService: authService,
                              playlistService: playlistService)

switch musicApp.createPlaylist(username: "Bob",
                               password: "bob123",
                               playlistName: "My Favorites") {
case .success(let result):
  print(result)
case .failure(let error):
  print("Action failed. Error: \(error)")
}
```


### Positive aspects:

1- `Simplified Interface`: The Facade pattern provides a clear and concise interface to interact with complex subsystems, reducing the cognitive load for developers using the system.

2- `Code Organization`: The pattern promotes clean code separation, making the subsystems' implementation details less exposed.

3- `Ease of Use`: Clients only need to interact with the facade, reducing the need to understand the intricate details of each subsystem.


### Negative aspects:

1- `Limited Customization`: The Facade pattern can hide certain functionalities that advanced users might want to customize.

2- `Increased Coupling`: While the facade reduces coupling between clients and subsystems, it can lead to increased coupling between the facade and the subsystems.

3- `Abstraction Leakage`: If the facade isn't designed carefully, changes to the subsystems might necessitate changes to the facade, potentially defeating the purpose of simplification.


### Conclusions:

- The Facade pattern proves invaluable when dealing with complex systems by providing a simplified interface for clients.
- It promotes the separation of concerns, reduces complexity, and enhances maintainability.
- However, it's important to strike a balance between encapsulation and customization to ensure the pattern doesn't hinder the system's extensibility and flexibility.




## Flyweight

- The Flyweight Design Pattern is a structural design pattern that is used to minimize memory usage or computational expenses by sharing as much as possible with related objects.
- It is particularly useful when you need to create a large number of similar objects, which can be split into two parts: `intrinsic` and `extrinsic` state.

1. `Intrinsic State`: This is the part of the object's state that is shared among multiple objects. It's usually immutable and can be shared freely. Intrinsic state is stored in the flyweight objects.

2. `Extrinsic State`: This is the part of the object's state that varies and cannot be shared. It is usually passed as a parameter to the flyweight objects.



### Implementation:


```swift
// Concrete Flyweight

class CircleFlyweight {
  let color: UIColor
  let radius: CGFloat

  init(color: UIColor, radius: CGFloat) {
    self.color = color
    self.radius = radius
  }
}
```

```swift
// Create a Factory to Manage Flyweights

class CircleFlyweightFactory {
  private var flyweights: [String: CircleFlyweight] = [:]

  func getCircleFlyweight(color: UIColor) -> CircleFlyweight {
    let key = color.description

    if let existingFlyweight = flyweights[key] {
      return existingFlyweight
    } else {
      // Shared properties
      let newFlyweight = CircleFlyweight(color: color, radius: 10.0)
      flyweights[key] = newFlyweight
      return newFlyweight
    }
  }

}
```

```swift
class Circle {
  let position: CGPoint
  let flyweight: CircleFlyweight

  init(position: CGPoint, flyweight: CircleFlyweight) {
    self.position = position
    self.flyweight = flyweight
  }

  func draw() {
    print("Drawing a circle at \(position) with radius \(flyweight.radius) and color \(flyweight.color).")
  }
}
```


```swift
// Usage
let flyweightFactory = CircleFlyweightFactory()

let circle1 = Circle(position: CGPoint(x: 10, y: 10),
                     flyweight: flyweightFactory.getCircleFlyweight(color: .red))
let circle2 = Circle(position: CGPoint(x: 20, y: 20),
                     flyweight: flyweightFactory.getCircleFlyweight(color: .red))

circle1.draw() // Both circles will share the same flyweight
circle2.draw()
```



### Positive aspects:

1. `Memory Efficiency`: The Flyweight pattern reduces memory usage by sharing common state across multiple objects.

2. `Performance Improvement`: It can lead to performance improvements by reducing the number of objects that need to be created and managed.

3. `Scalability`: It makes it easier to scale applications when dealing with a large number of objects with shared state.



### Negative aspects:

1. `Complexity`: Introducing the Flyweight pattern can make the code more complex, especially when managing the intrinsic and extrinsic states.

2. `Reduced Encapsulation`: The pattern requires sharing state, which can reduce encapsulation if not managed properly.

3. `Potential Overhead`: In some cases, the overhead of managing the flyweight objects may outweigh the benefits, especially if the number of shared states is small.



### Conclusions:

- The Flyweight Design Pattern is a powerful tool for optimizing memory usage and improving performance in situations where many objects share common state.
- However, it should be applied judiciously, as it can add complexity to the codebase.
- It's most effective in scenarios where a large number of similar objects need to be managed efficiently while keeping memory usage in check.
- When implemented correctly, it can lead to significant improvements in the efficiency of an iOS application.




## Bridge

- The Bridge Design Pattern is a structural pattern that separates an object's `abstraction` from its `implementation`, allowing them to vary independently.

- It involves creating two separate hierarchies - one for `abstractions` and another for `implementations`.

- This separation provides flexibility by allowing you to change or extend either the `abstraction` or `implementation` without affecting the other.

- In iOS development, you might use the Bridge Pattern when you have a complex set of classes that need to work together, and you want to decouple them to make the code more maintainable and extensible.


### Implementation:

- Let's consider an example where we want to create a drawing application.

- We have different shapes (e.g., `circles` and `rectangles`) and want to support multiple drawing tools (e.g., `pencil` and `brush`).

- The Bridge Pattern helps in decoupling the shape `abstraction` from the drawing tool `implementation`.


#### Step 1: Define the Abstraction

```swift
protocol DrawingShape {
    func draw()
}
```


#### Step 2: Implement Abstraction

```swift
class Circle: DrawingShape {
    func draw() {
        print("Draw a circle")
    }
}

class Rectangle: DrawingShape {
    func draw() {
        print("Draw a rectangle")
    }
}
```


#### Step 3: Define the Implementor

```swift
protocol DrawingTool {
    func draw(shape: DrawingShape)
}
```


#### Step 4: Implement Implementor

```swift
class PencilTool: DrawingTool {
    func draw(shape: DrawingShape) {
        print("Drawing with pencil:")
        shape.draw()
    }
}

class BrushTool: DrawingTool {
    func draw(shape: DrawingShape) {
        print("Drawing with brush:")
        shape.draw()
    }
}
```


#### Step 5: Use the Bridge Pattern

```swift
let circle = Circle()
let rectangle = Rectangle()

let pencil = PencilTool()
let brush = BrushTool()

pencil.draw(shape: circle)
brush.draw(shape: rectangle)
```



### Positive aspects:

1. `Decoupling`: The Bridge Pattern decouples the `abstraction` from its `implementation`, making it easier to modify and extend both independently.

2. `Flexibility`: You can add new shapes or drawing tools without affecting existing code.

3. `Readability`: It improves code readability by separating different concerns.

4. `Testing`: Easier to write unit tests as you can mock or substitute implementations.



### Negative aspects:

1. `Complexity`: It can introduce additional complexity, especially for simple applications where the overhead might not be justified.

2. `Overhead`: Managing two hierarchies (abstraction and implementation) can lead to more code.

3. `Learning Curve`: Developers not familiar with the pattern may find it confusing.



### Conclusions:

- The Bridge Design Pattern is a powerful tool for decoupling `abstractions` from their `implementations` in iOS development.
- It promotes `flexibility`, `maintainability`, and `scalability` in your codebase.
- However, it should be used judiciously, as it can add `complexity` in simpler scenarios.

- When employed correctly, it leads to more modular and maintainable iOS applications.
- TDD can be added as a valuable companion to ensure that your implementations adhere to the intended design and continue to function correctly as your codebase evolves.




## Composite

- The Composite Design Pattern is a structural design pattern that allows you to compose objects into tree structures to represent hierarchies.

- It's useful when you need to treat individual objects and compositions of objects uniformly.

- In the context of iOS app development, we can use this pattern to build hierarchical UI components or manage complex structures of data.

- The Composite Design Pattern consists of three key components:

1. `Component`: This is an abstract class or protocol that defines the common interface for `leaf` and `composite` objects. It usually includes methods like `display` or `render`.

2. `Leaf`: These are the individual objects that implement the `Component` interface. They don't have any child components.

3. `Composite`: These are complex objects that also implement the `Component` interface but can contain child components. Composites manage a collection of child components, which can be either `leaves` or other `composites`.




### Implementation:

- Let's implement the Composite Pattern in the context of a graphical user interface where we have a hierarchy of UI elements.

```swift
// Step 1: Create the Component protocol
protocol UIComponent {
  func display()
}
```

```swift
// Step 2: Implement Leaf objects
class UIButton: UIComponent {
  var label: String

  init(label: String) {
    self.label = label
  }

  func display() {
    print("Button: \(label)")
  }
}

class UILabel: UIComponent {
  var text: String

  init(text: String) {
    self.text = text
  }

  func display() {
    print("Label: \(text)")
  }
}
```

```swift
// Step 3: Implement Composite object
class UIView: UIComponent {
  var children: [UIComponent] = []

  func add(child: UIComponent) {
    children.append(child)
  }

  func display() {
    for child in children {
      child.display()
    }
  }
}
```

```swift
// Usage
let view1 = UIView()
let label = UILabel(text: "Welcome!")
let button = UIButton(label: "Click Me")

view1.add(child: label)
view1.add(child: button)

let view2 = UIView()
let anotherButton = UIButton(label: "Submit")

view2.add(child: view1)
view2.add(child: anotherButton)

view2.display()
```



### Positive aspects:

1. `Composition`: It allows you to build complex structures from simple objects through composition.

2. `Uniformity`: It enables clients to treat individual objects and compositions of objects uniformly.

3. `Hierarchical Structures`: Great for representing hierarchical data or UI components.

4. `Open-Closed Principle`: You can add new component types without altering existing code.




### Negative aspects:

1. `Complexity`: Overusing the Composite Pattern can make the code more complex.

2. `Performance`: Depending on the implementation, traversing a deep composite structure can be inefficient.

3. `Limited Type Safety`: In dynamically typed languages, type safety may not be guaranteed.



### Conclusions:

- The Composite Design Pattern is a powerful tool for building complex structures while keeping the code maintainable and extensible.
- It's particularly useful in iOS app development for creating hierarchical UI elements or managing complex data structures.
- However, like any design pattern, it should be used judiciously, considering the specific needs of your application.
