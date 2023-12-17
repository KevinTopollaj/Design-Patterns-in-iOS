import Foundation

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
