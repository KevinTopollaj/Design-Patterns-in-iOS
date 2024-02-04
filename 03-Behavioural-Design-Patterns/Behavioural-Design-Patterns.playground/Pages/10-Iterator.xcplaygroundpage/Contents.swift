import Foundation

// Task represents an element in the collection
struct Task {
  let title: String
  let priority: Int
}

// Iterator protocol defines methods for iterating through the collection
protocol TaskIterator {
  func hasNext() -> Bool
  func next() -> Task?
}

// Concrete implementation of the Iterator protocol
class ToDoListIterator: TaskIterator {
  private var tasks: [Task]
  private var position: Int = 0

  init(tasks: [Task]) {
    self.tasks = tasks
  }

  func hasNext() -> Bool {
    return position < tasks.count
  }

  func next() -> Task? {
    guard hasNext() else { return nil }
    defer { position += 1 }
    return tasks[position]
  }
}

// @Kevin_Topollaj


// Collection interface with a method to create an iterator
protocol ToDoList {
  func createIterator() -> TaskIterator
}

// Concrete implementation of the Collection interface
class ToDoListCollection: ToDoList {
  private var tasks: [Task] = []

  func addTask(_ task: Task) {
    tasks.append(task)
  }

  func createIterator() -> TaskIterator {
    return ToDoListIterator(tasks: tasks)
  }
}

// Example usage
let toDoList = ToDoListCollection()
toDoList.addTask(Task(title: "Buy groceries", 
                      priority: 1))
toDoList.addTask(Task(title: "Complete project", 
                      priority: 2))
toDoList.addTask(Task(title: "Exercise", 
                      priority: 3))

let iterator = toDoList.createIterator()

while iterator.hasNext() {
  if let task = iterator.next() {
    print("Task: \(task.title), Priority: \(task.priority)")
  }
}





