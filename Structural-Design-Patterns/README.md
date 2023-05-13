# Structural Design Patterns

## Table of contents

* [Intro](#Intro)




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
