# Creational Design Patterns

## Table of contents

* [Intro](#Intro)
* [Singleton](#Singleton)
* [Factory Method](#Factory-Method)



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
