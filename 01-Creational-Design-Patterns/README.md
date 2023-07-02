# Creational Design Patterns

## Table of contents

* [Intro](#Intro)
* [Singleton](#Singleton)
* [Factory Method](#Factory-Method)
* [Dependency Injection](#Dependency-Injection)
* [Abstract Factory](#Abstract-Factory)
* [Builder](#Builder)
* [Lazy Initialization](#Lazy-Initialization)
* [Prototype](#Prototype)



## Intro

![](img/p01.jpeg)


In iOS development, Creational Design Patterns can help simplify the creation of objects and provide a flexible, reusable code structure. Creational Design Patterns that are commonly used in iOS development:

1- Singleton Design Pattern:

The Singleton Design Pattern ensures that only one instance of a class is created in the application, making it a globally accessible object that can be used throughout the application.

2- Factory Method Design Pattern:

The Factory Method Design Pattern is used to create objects without exposing the creation logic to the client. This pattern provides an interface for creating objects but allows subclasses to alter the type of objects that will be created.

3- Dependency Injection Design Pattern:

The Dependency Injection Design Pattern is used to provide objects with their dependencies, rather than having them create their dependencies themselves. This pattern involves passing dependencies to an object through its constructor, properties, or methods.

4- Abstract Factory Design Pattern:

The Abstract Factory Design Pattern provides an interface for creating families of related or dependent objects without specifying their concrete classes. This pattern is useful when you want to create objects that share some common properties but have varying properties.

5- Builder Design Pattern:

The Builder Design Pattern separates the construction of a complex object from its representation. This pattern involves creating a builder class that knows how to create the object and a director class that controls the construction process.

6- Lazy Initialization Design Pattern:

The Lazy Initialization Design Pattern is used to defer the creation of an object until it's actually needed. This pattern involves creating a placeholder for an object that is only created when it's requested.

7- Prototype Design Pattern:

The Prototype Design Pattern allows you to create new objects by cloning existing objects, rather than creating new ones from scratch.

8- Object Pool Design Pattern:

The Object Pool Design Pattern is used to manage a pool of reusable objects that can be shared among multiple clients. This pattern involves creating a pool of objects and providing an interface for clients to request and return objects to the pool.

9- Service Locator Design Pattern:

The Service Locator Design Pattern is used to provide a centralized registry of services that can be accessed throughout the application.

10- Multiton Design Pattern:

The Multiton Design Pattern is used to create a limited number of instances of a class, each with a unique key. This pattern involves creating a dictionary that maps keys to instances of a class and provides a way to retrieve and create new instances based on a key.



## Singleton

- The Singleton design pattern is a creational pattern that ensures that only one instance of a class can be created and used throughout the lifetime of an application.
- This is useful in scenarios where you need to ensure that a single, globally accessible instance is used to coordinate activities across multiple parts of an application.
- In the Singleton pattern, a class has a private initializer that can only be accessed from within the class itself, preventing any other instance from being created.
- Instead, a static method or property is provided to access the single instance of the class.
- In Swift, it's best practice to use a `final` class for the Singleton, which prevents subclassing and ensures that the Singleton remains a single instance.
- Additionally, it's best practice to use a `static` constant property (`static let`) to hold the single instance, as this guarantees that the instance is only created once and is always available.

- 


### Implementation

```swift
import Foundation

final class Singleton {
    static let shared = Singleton()

    private init() { }

    func printSomething() {
        print("This is a Singleton")
    }
}
```

- To use the Singleton in your code, you simply call the `shared` property to get the single instance of the class, like this:

```swift
let singleton = Singleton.shared
```

- Once you have a reference to the Singleton, you can call methods or access properties as needed:

```swift
singleton.printSomething()    // This is a Singleton
```


### Positive aspects:

1. `Global Access`: The Singleton allows for a globally accessible instance, providing a convenient way to access its functionality throughout the application.

2. `Single Instance`: The pattern guarantees that only one instance of the class exists, eliminating the possibility of multiple instances causing conflicts or synchronization issues.

3. `Resource Sharing`: Singleton instances are useful for sharing resources that need to be accessed by multiple objects.

4. `Lazy Initialization`: The singleton instance is created only when it's accessed for the first time, allowing for efficient resource utilization.

5. `Thread Safety`: By default, Swift guarantees thread safety for lazy initialization, ensuring that only one instance is created even in concurrent environments.


### Negative aspects:

1. `Tight Coupling`: Singleton instances are globally accessible, which can lead to tight coupling between classes. This can make your code less modular and harder to test.

2. `Global State`: The use of singletons can introduce global state, which can make your codebase harder to reason about and debug. Changes made to the singleton can affect the behavior of multiple components.

3. `Dependency Management`: Singleton instances can make it challenging to manage dependencies and can result in hidden dependencies between classes.

4. `Testing Complexity`: Because singletons are globally accessible, it can be difficult to isolate and test components that depend on them. This can lead to complex unit tests.


### Conclusions:

- The Singleton pattern is a powerful tool for ensuring a single instance of a class and providing global access to it.
- It offers advantages such as global accessibility, resource sharing, and lazy initialization.
- However, it also has drawbacks like tight coupling, global state, and testing complexity.
- It's essential to evaluate whether the Singleton pattern is the best solution for your specific use case, considering the pros and cons mentioned above.



## Factory Method


- The `Factory Method` design pattern is a creational pattern that provides an interface for creating objects but allows subclasses to decide which class to instantiate.

- It encapsulates object creation logic within a method, known as the factory method, which is responsible for creating and returning instances of related classes.

- This pattern promotes loose coupling and flexibility by allowing the client code to work with the abstract interface instead of dealing with concrete class instantiations directly.


### Implementation

- To illustrate the `Factory Method` pattern in iOS, let's consider a scenario where we have a messaging app that supports multiple types of message senders, such as `EmailSender` and `SMSSender`.

- We create an abstract `MessageSender` protocol and two concrete classes, `EmailSender` and `SMSSender`, which will implement the `MessageSender` protocol and provide concrete implementations of the `sendMessage` method.

```swift
// Abstract MessageSender protocol
protocol MessageSender {
    func sendMessage(message: String)
}

// Concrete EmailSender class
class EmailSender: MessageSender {
    func sendMessage(message: String) {
        print("Sending email message: \(message)")
    }
}

// Concrete SMSSender class
class SMSSender: MessageSender {
    func sendMessage(message: String) {
        print("Sending SMS message: \(message)")
    }
}
```

- The `MessageSenderFactory` class serves as the factory class and provides a `static` `createMessageSender` method.
- This method takes a `MessageType` parameter to determine which concrete subclass to instantiate.
- If the type is `.email`, it creates and returns an `EmailSender` instance; if it's `.sms`, it creates and returns a `SMSSender` instance.

```swift
// MessageSenderFactory class implementing the Factory Method pattern
class MessageSenderFactory {
    enum MessageType {
        case email
        case sms
    }
    
    static func createMessageSender(type: MessageType) -> MessageSender {
        switch type {
        case .email:
            return EmailSender()
        case .sms:
            return SMSSender()
        }
    }
}
```

- To use the `MessageSenderFactory` in your code, you can follow these steps:

```swift
let sender = MessageSenderFactory.createMessageSender(type: .sms)
sender.sendMessage(message: "Hello Linkedin!")  // Sending SMS message: Hello Linkedin!
```


### Positive aspects:

1. Provides a way to encapsulate object creation logic, allowing client code to work with the abstract interface and reducing dependencies on concrete classes.

2. Supports the Open-Closed Principle by allowing the addition of new subclasses without modifying the existing factory class.

3. Enhances code readability and maintainability by separating object creation from the client code.

4. Promotes code reuse by providing a common interface for creating related objects.


### Negative aspects:

1. Introduces additional complexity, especially when dealing with a large number of subclasses and product variations.

2. Can lead to an increase in the number of classes and files, which may make the codebase harder to navigate.

3. Requires careful design and consideration to ensure the proper organization and relationship between the factory class and the product subclasses.


### Conclusions:

- The Factory Method design pattern is a valuable tool in iOS development for creating objects in a flexible and extensible manner.
- By encapsulating object creation logic and using a factory method, it promotes loose coupling, code reusability, and maintainability. 
- It's important to carefully consider the trade-offs and apply this pattern judiciously to avoid unnecessary complexity and potential drawbacks.
- You can adapt the implementation to your specific needs and requirements.



## Dependency Injection

- The Dependency Injection design pattern is a software design principle that aims to reduce dependencies between components by allowing dependencies to be injected from the outside rather than being created or managed internally.
- It promotes loose coupling and improves the testability, maintainability, and flexibility of the codebase.
- In the Dependency Injection design pattern, dependencies are "injected" into a class through `constructor injection`, `property injection`, or `method injection`.

- `Constructor Injection`: Dependencies are passed to a class through its constructor.
- `Property Injection`: Dependencies are set through properties or variables of a class.
- `Method Injection`: Dependencies are provided through method parameters.

- Now let's dive into a detailed implementation example using constructor injection.


### Implementation

- In this example, we have a `DataManager` class that depends on a `DataSource` protocol.
- The `DataManager` is decoupled from specific implementations of the `DataSource` protocol, making it more flexible and easier to test.
- We provide the appropriate implementation of the `DataSource` protocol during initialization of the `DataManager` using `constructor injection`.

```swift
// A protocol defining a data source
protocol DataSource {
    func fetchData() -> String
}

// A class that depends on the DataSource protocol and
// injects it using constructor injection
class DataManager {
    private let dataSource: DataSource

    init(dataSource: DataSource) {
        self.dataSource = dataSource
    }

    func displayData() {
        let data = dataSource.fetchData()
        print("Fetched data: \(data)")
    }
}

// A concrete implementation of the DataSource protocol
class RemoteDataSource: DataSource {
    func fetchData() -> String {
        return "Data from remote server"
    }
}

// Another concrete implementation of the DataSource protocol
class LocalDataSource: DataSource {
    func fetchData() -> String {
        return "Data from local storage"
    }
}
```

- To use the `DataManager` in your code, you can follow these steps:

```swift
// Create instances of the data sources
let remoteDataSource = RemoteDataSource()
let localDataSource = LocalDataSource()

// Create an instance of DataManager with a remote data source
let dataManager = DataManager(dataSource: remoteDataSource)
dataManager.displayData() // Output: Fetched data: Data from remote server

// Create another instance of DataManager with a local data source
let anotherDataManager = DataManager(dataSource: localDataSource)
anotherDataManager.displayData() // Output: Fetched data: Data from local storage
```


### Positive aspects:

1. `Testability`: With Dependency Injection, it's easy to provide mock or stub implementations of dependencies during testing, allowing for comprehensive unit testing.

2. `Modularity and reusability`: By injecting dependencies, components become more modular and can be reused in different contexts or scenarios.

3. `Flexibility`: Dependency Injection makes it easier to switch or substitute dependencies without modifying the consuming class. This promotes flexibility and makes the code more maintainable.


### Negative aspects:

1. `Increased complexity`: Introducing Dependency Injection can add complexity to the codebase, especially in larger projects. Managing dependencies, their lifecycles, and configuration can become challenging.

2. `Indirect dependencies`: Dependency Injection can result in a chain of dependencies, making it harder to trace and understand the flow of data throughout the application.

3. `Increased setup and boilerplate code`: Dependency Injection often requires writing additional code for dependency management, configuration, and injection, which can increase the overall codebase size.


### Conclusions:

- Dependency Injection is a powerful design pattern that promotes loose coupling, testability, and modularity.
- By allowing dependencies to be injected from the outside, it enhances flexibility and makes the code more maintainable.
- However, it's important to strike a balance and carefully consider the complexity and overhead it introduces to ensure the benefits outweigh the drawbacks.

- Remember, the specific implementation and usage of Dependency Injection can vary based on the requirements and architectural choices of your iOS project.



## Abstract Factory

- The Abstract Factory design pattern is a creational pattern that provides an interface for creating families of related or dependent objects without specifying their concrete classes.
- It allows clients to create objects without knowing the specific classes they belong to, promoting loose coupling and enhancing flexibility in the codebase.

- The main idea behind the Abstract Factory pattern is to define an abstract factory class that declares methods for creating different types of related objects.
- Concrete factory classes are then responsible for implementing these methods and producing concrete instances of the objects.
- This approach allows clients to work with the abstract factory and its product interfaces, without being tightly coupled to specific implementations.

- For example in a food delivery app, there are different types of restaurants offering various cuisines.
- Each restaurant can have its own menu items, such as pizzas, burgers, or sushi.
- The Abstract Factory pattern can be used to create families of related objects, where each family corresponds to a specific restaurant and its menu items.

- The Abstract Factory pattern involves the following key components:

1. `Abstract Factory`: Defines the interface for creating the families of related objects.

2. `Concrete Factories`: Implement the Abstract Factory interface and are responsible for creating specific families of objects.

3. `Abstract Products`: Define the interfaces for the different types of objects created by the factory.

4. `Concrete Products`: Implement the Abstract Product interfaces and represent the specific objects created by the concrete factories.



### Implementation

- Let's start by defining the abstract factory and product interfaces:

```swift
// Abstract factory
protocol RestaurantFactory {
    func createAppetizer() -> Appetizer
    func createMainCourse() -> MainCourse
    func createDessert() -> Dessert
}

// Abstract products
protocol Appetizer {
    func display()
}

protocol MainCourse {
    func display()
}

protocol Dessert {
    func display()
}
```

- Next, we create concrete factories that implement the `RestaurantFactory` protocol for different types of restaurants:

```swift
// Concrete factory for an Italian restaurant
class ItalianRestaurantFactory: RestaurantFactory {
    func createAppetizer() -> Appetizer {
        return ItalianAppetizer()
    }
    
    func createMainCourse() -> MainCourse {
        return ItalianMainCourse()
    }
    
    func createDessert() -> Dessert {
        return ItalianDessert()
    }
}

// Concrete factory for a Mexican restaurant
class MexicanRestaurantFactory: RestaurantFactory {
    func createAppetizer() -> Appetizer {
        return MexicanAppetizer()
    }
    
    func createMainCourse() -> MainCourse {
        return MexicanMainCourse()
    }
    
    func createDessert() -> Dessert {
        return MexicanDessert()
    }
}
```

- Now, we define concrete product implementations for each type of restaurant and their menu items:

```swift
// Italian restaurant products
class ItalianAppetizer: Appetizer {
    func display() {
        print("Italian appetizer: Bruschetta")
    }
}

class ItalianMainCourse: MainCourse {
    func display() {
        print("Italian main course: Margherita pizza")
    }
}

class ItalianDessert: Dessert {
    func display() {
        print("Italian dessert: Tiramisu")
    }
}

// Mexican restaurant products
class MexicanAppetizer: Appetizer {
    func display() {
        print("Mexican appetizer: Guacamole")
    }
}

class MexicanMainCourse: MainCourse {
    func display() {
        print("Mexican main course: Tacos")
    }
}

class MexicanDessert: Dessert {
    func display() {
        print("Mexican dessert: Churros")
    }
}
```

- In the client code, we can utilize the abstract factory and its products to create and display menu items without knowing the specific restaurant or its menu items:

```swift
class FoodDeliveryApp {
  private let restaurantFactory: RestaurantFactory

  init(restaurantFactory: RestaurantFactory) {
    self.restaurantFactory = restaurantFactory
  }

  func displayMenu() {
    let appetizer = restaurantFactory.createAppetizer()
    let mainCourse = restaurantFactory.createMainCourse()
    let dessert = restaurantFactory.createDessert()

    print("Appetizer:")
    appetizer.display()

    print("Main Course:")
    mainCourse.display()

    print("Dessert:")
    dessert.display()
  }
}
```

- Now, when we run the app and select a specific restaurant, we can create and display the menu items using the abstract factory:

```swift
let app = FoodDeliveryApp()

// Select Italian restaurant
app.restaurantFactory = ItalianRestaurantFactory()
app.displayMenu()

// Select Mexican restaurant
app.restaurantFactory = MexicanRestaurantFactory()
app.displayMenu()
```

- Output:

```swift
/*
Appetizer:
Italian appetizer: Bruschetta
Main Course:
Italian main course: Margherita pizza
Dessert:
Italian dessert: Tiramisu

Appetizer:
Mexican appetizer: Guacamole
Main Course:
Mexican main course: Tacos
Dessert:
Mexican dessert: Churros
*/
```


### Positive aspects:

1. `Encourages modularity and extensibility`: The Abstract Factory pattern provides a structured approach to creating families of related objects. It allows for the easy addition of new concrete factories and products without modifying the existing codebase.

2. `Promotes loose coupling`: The client code depends only on the abstract factory and product interfaces, ensuring low coupling between the client and the concrete implementations. This facilitates easier maintenance and testing.

3. `Supports consistent object creation`: The Abstract Factory pattern ensures that the created objects within a family are consistent and compatible with each other.



### Negative aspects:

1. `Increased complexity`: As the number of families of related objects and concrete factories grows, the complexity of the codebase can increase.

2. `Limited flexibility`: The Abstract Factory pattern is best suited when there are well-defined families of objects with limited variation. If the object creation logic varies significantly or dynamically, other creational patterns like the Factory Method or Builder pattern may be more suitable.



### Conclusions:

- The Abstract Factory pattern provides a structured approach for creating families of related objects in a modular and extensible manner.
- It promotes loose coupling and consistent object creation, making it a valuable pattern in scenarios where different families of objects need to be created based on a specific context or configuration.
- However, it's important to carefully consider the complexity and variation in object creation to determine whether the Abstract Factory pattern is the most appropriate choice for a given situation in your application.




## Builder

- The Builder Design Pattern is a creational design pattern that provides a way to construct complex objects step by step.
- It separates the construction of an object from its representation, allowing for more control and flexibility in the construction process.
- The pattern is especially useful when dealing with objects that have many configurable parameters.


### Implementation

- Let's consider an example where we have a `Car` object that needs to be constructed.
- The `Car` object has various properties such as `brand`, `model`, `color`, `engineType`, and `numberOfDoors`.
- We'll implement the Builder Design Pattern to construct the `Car` object:

```swift
struct Car {
  let brand: String
  let model: String
  let color: String
  let engineType: String
  let numberOfDoors: Int
}
```

```swift
enum BuilderError: Error {
    case incompleteData
}
```

```swift
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
```

- In the above example, the `CarBuilder` class is responsible for constructing the `Car` object.
- It provides methods to set each property of the `Car` object and returns a reference to the builder itself, enabling method chaining.
- The `build()` method throws an error if any required data is missing, ensuring the builder enforces data completeness.

- Here's an example usage of the builder pattern:

```swift
let carBuilder = CarBuilder()

let car = try carBuilder
                .setBrand("BMW")
                .setModel("X5")
                .setColor("Black")
                .setEngineType("V8")
                .setNumberOfDoors(4)
                .build()
```

- In this example, we create a `CarBuilder` instance, chain the method calls to set the car's properties, and finally call `build()` to retrieve the constructed `Car` object.


### Positive aspects:

1. Encourages a clear separation between object construction and representation, promoting code maintainability.

2. Provides a flexible and expressive way to construct objects, allowing for different configurations.

3. Supports testability by enabling the creation and testing of various object variations.



### Negative aspects:

1. Introduces additional code for the builder, potentially increasing the overall complexity, especially for simpler objects.

2. Requires careful handling of optional properties and error management during object construction.


### Conclusions:

- The Builder Design Pattern, when implemented with attention to best practices, offers a powerful and flexible approach to constructing complex objects.
- It separates the construction process from the object's representation, facilitating code maintenance and testability.
- However, it should be applied judiciously, considering the complexity and requirements of the project.

- Remember, the implementation of design patterns should align with the specific needs and constraints of your application, and the `Builder` pattern is particularly useful when dealing with complex object creation that requires multiple steps and variations.




## Lazy Initialization

- Lazy Initialization is a design pattern that aims to defer the creation of an object until it is actually needed.
- This pattern is particularly useful when dealing with expensive resources or heavy dependencies, such as establishing a database connection.
- By lazily initializing objects, you can optimize resource usage and improve the overall performance of your application.


### Implementation

- The provided example demonstrates the Lazy Initialization design pattern.

```swift
class DatabaseConnection {
  // Simulated heavy initialization process
  init() {
    print("Establishing database connection...")
    // ...
    print("Database connection established!")
  }
  // Database-related operations
  // ...
}
```

```swift
class DatabaseManager {
  private var databaseConnection: DatabaseConnection?

  static let shared = DatabaseManager()
  // Private initializer to prevent direct instantiation
  private init() { }

  func connect() -> DatabaseConnection {
    if let connection = databaseConnection {
      // Return the existing connection if it already exists
      return connection
    } else {
      // Create a new connection if it doesn't exist
      let connection = DatabaseConnection()
      databaseConnection = connection
      return connection
    }
  }
}
```

```swift
class ResponsibleViewForDBConnection {
  // Lazy initialization
  private lazy var databaseManager: DatabaseManager = {
    return DatabaseManager.shared
  }()

  func performDatabaseOperations() {
    let connection = databaseManager.connect()
    // Perform database operations using the connection
  }
}

let view = ResponsibleViewForDBConnection()
view.performDatabaseOperations()
```

- The `DatabaseConnection` class represents a database connection.
- It contains an initializer that simulates the process of establishing a database connection.

- The `DatabaseManager` class is responsible for managing database connections.
- It utilizes the Singleton pattern to ensure a single instance is used throughout the application.
- The `connect()` method lazily initializes a `DatabaseConnection` object.
- If there is an existing connection, it returns it; otherwise, it creates a new connection.

- The `ResponsibleViewForDBConnection` class represents a view responsible for performing database operations.
- It utilizes lazy initialization by declaring a private property `databaseManager` that lazily initializes the shared instance of `DatabaseManager`.
- The `performDatabaseOperations()` method accesses the `databaseManager` and calls the `connect()` method to obtain a `DatabaseConnection` object for performing the database operations.


### Positive aspects:

1. `Resource optimization`: Lazy initialization allows you to create expensive objects only when they are actually needed, conserving system resources and improving performance.

2. `Reusability`: The Lazy Initialization pattern facilitates reusability by ensuring that the same instance of an object is utilized throughout the application, avoiding unnecessary duplications.

3. `Modularity`: Lazy initialization promotes a modular and decoupled design by separating object creation from usage, enhancing flexibility and maintainability.

4. `Testability`: By utilizing lazy initialization, you can easily test the behavior of objects in isolation, as you have control over when the object is initialized.


### Negative aspects:

1. `Potential delays`: The initial access to a lazily initialized object may introduce a slight delay, as the creation process is triggered. However, subsequent accesses benefit from the already created object.

2. `Thread safety`: Care must be taken to ensure thread safety when lazily initializing objects, especially in multi-threaded environments. Proper synchronization mechanisms should be employed to prevent race conditions.


### Conclusions:

- The Lazy Initialization design pattern is a valuable tool for optimizing resource usage and improving performance in iOS applications.
- By deferring the creation of expensive objects until they are needed, you can minimize unnecessary overhead and enhance scalability.
- This pattern promotes modularity and testability, allowing for more maintainable and robust code.
- However, it is crucial to handle potential delays and ensure thread safety when implementing lazy initialization.

- By following best practices and incorporating TDD, you can ensure that the code is reliable, testable, and adheres to good software development principles.




## Prototype

- The Prototype design pattern is a creational design pattern that allows the creation of new objects by cloning existing objects.
- Instead of creating objects from scratch, the `Prototype` pattern involves creating a copy of an existing object and modifying it as needed.
- This pattern is useful when creating complex objects can be time-consuming or costly, and when it's more efficient to clone an existing object rather than creating a new one.


### Implementation:

- Let's consider an example where we have a mobile app that allows users to create and customize their profiles.
- We want to provide a default profile template that users can clone and modify as per their preferences.

```swift
// Step 1: Create a protocol that defines the clone method
protocol ProfileClonable {
  func clone() -> Self
}
```

```swift
// Step 2: Create a concrete class that adopts the clonable protocol
final class Profile: ProfileClonable {
  private(set) var username: String
  private(set) var bio: String

  init(username: String, bio: String) {
    self.username = username
    self.bio = bio
  }

  // Step 3: Implement the clone method to create a copy of the object
  func clone() -> Profile {
    let clone = Profile(username: self.username, bio: self.bio)
    return clone
  }

  func customize(username: String, bio: String) -> Profile {
    let clone = self.clone()
    clone.username = username
    clone.bio = bio
    return clone
  }
}
```

```swift
// Step 4: Usage
let defaultProfile = Profile(username: "DefaultUser",
                             bio: "This is a default profile.")

let user1Profile = defaultProfile.clone().customize(username: "User1",
                                                    bio: "This is User1's profile.")
```



### Positive aspects:

1. `Encapsulation`: The Prototype pattern encapsulates the cloning process within the object itself, providing a simple interface for creating new objects.

2. `Flexibility`: The Prototype pattern allows dynamic creation of objects at runtime by cloning existing objects, providing flexibility in object creation.

3. `Performance`: Cloning an existing object is often more efficient than creating a new object from scratch, especially for complex objects with a lot of initialization logic.



### Negative aspects:

1. `Deep copying`: Depending on the complexity of the object being cloned, implementing a deep copy can be challenging. Deep copying ensures that all object properties are also cloned instead of being referenced.

2. `Managing mutable state`: If the cloned object contains a mutable state, you need to handle it carefully to prevent unexpected behavior or unintended sharing of the state.



### Conclusions:

- The Prototype design pattern is a valuable tool in iOS app development when you need to create new objects by cloning existing ones.
- It offers encapsulation, flexibility, and performance benefits.
- However, be cautious when dealing with mutable states and implementing deep copying to ensure the integrity of the cloned objects.

- Remember to adapt the implementation to your specific use case and project requirements.


