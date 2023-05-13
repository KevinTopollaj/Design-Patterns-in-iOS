# Architectural Design Patterns

## Table of contents

* [Intro](#Intro)




## Intro

![](img/p01.jpeg)


Here is a detailed explanation of the most popular architectural design patterns used in iOS development:

1- Model-View-Controller: MVC is one of the oldest and most widely used design patterns for building iOS applications. It separates an application into three components: Model, View, and Controller. The Model represents the data and the business logic, the View represents the user interface, and the Controller acts as an intermediary between the Model and View.

2- Model-View-Presenter: MVP is a variation of the MVC pattern that separates the responsibilities between the View and Controller into two different components, the View and Presenter. The View is responsible for rendering the user interface, while the Presenter manages the logic and interaction between the Model and the View.

3- Model-View-ViewModel: MVVM is another variation of the MVC pattern that separates the View and Controller into two different components, the View and ViewModel. The View is responsible for rendering the user interface, while the ViewModel manages the state and behavior of the View. The ViewModel interacts with the Model to retrieve and manipulate data and exposes this data to the View.

4- VIPER: This is a more recent architecture pattern that stands for View, Interactor, Presenter, Entity, and Router. Each component has a specific role in the application's architecture. The View is responsible for rendering the user interface, the Interactor manages the business logic, the Presenter manages the interaction between the View and Interactor, the Entity represents the data model, and the Router handles navigation between components.

5- Clean Architecture: This is a design pattern that emphasizes the separation of concerns between different components of an application. This pattern separates the application into four main layers: Entities, Use Cases, Interface Adapters, and Frameworks & Drivers. The Entities layer represents the application's data and business logic, the Use Cases layer manages the application's use cases, the Interface Adapters layer handles communication between the Use Cases and the Frameworks & Drivers layer manages the external interfaces to the system.

At last, an important programming paradigm worth mentioning is Reactive Programming which focuses on the flow of data and how it changes over time. It uses a declarative and functional approach to handle events and data streams. Reactive programming can be used in conjunction with other architectural patterns, such as MVC, MVP, and MVVM, to simplify the handling of data and events in the application.

In summary, these are some of the most popular and widely used architectural patterns in iOS development. Each pattern has its strengths and weaknesses and is suitable for different types of applications.
