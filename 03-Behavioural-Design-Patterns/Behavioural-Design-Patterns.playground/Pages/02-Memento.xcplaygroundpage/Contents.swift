import Foundation

// Originator - the object whose state needs to be saved

class Task {
  var title: String
  var completed: Bool

  init(title: String) {
    self.title = title
    self.completed = false
  }

  // Create a Memento to save the state
  func createMemento() -> TaskMemento {
    return TaskMemento(title: title,
                       completed: completed)
  }

  // Restore the state from a Memento
  func restore(from memento: TaskMemento) {
    title = memento.title
    completed = memento.completed
  }
}

// Memento - represents the state of the object

struct TaskMemento {
  let title: String
  let completed: Bool
}

// Caretaker class - is responsible for maintaining the history of the Task object's state.

class TaskHistory {
  private(set) var history: [TaskMemento] = []

  func addMemento(_ memento: TaskMemento) {
    history.append(memento)
  }

  func getMemento(at index: Int) -> TaskMemento {
    return history[index]
  }
}

// Example: @Kevin_Topollaj

let task = Task(title: "Buy groceries")
task.completed = true

let memento = task.createMemento()

let taskHistory = TaskHistory()
taskHistory.addMemento(memento)

let lastMemento = taskHistory.getMemento(at: taskHistory.history.count - 1)

task.restore(from: lastMemento)

print(task.title)
print(task.completed)
