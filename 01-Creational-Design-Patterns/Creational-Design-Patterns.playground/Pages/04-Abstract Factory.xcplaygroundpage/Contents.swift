import Foundation

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

// Create instances of concrete factories
let italianRestaurantFactory = ItalianRestaurantFactory()
let mexicanRestaurantFactory = MexicanRestaurantFactory()

// Create instances of FoodDeliveryApp using the desired factories
let italianApp = FoodDeliveryApp(restaurantFactory: italianRestaurantFactory)
let mexicanApp = FoodDeliveryApp(restaurantFactory: mexicanRestaurantFactory)

// Display menus using the respective app instances
italianApp.displayMenu()
mexicanApp.displayMenu()

