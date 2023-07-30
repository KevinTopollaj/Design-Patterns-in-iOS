# Structural Design Patterns

## Table of contents

* [Intro](#Intro)
* [Adapter](#Adapter)




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




