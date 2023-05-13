# Creational Design Patterns

## Table of contents

* [Intro](#Intro)




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
