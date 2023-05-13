# Behavioural Design Patterns

## Table of contents

* [Intro](#Intro)




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
