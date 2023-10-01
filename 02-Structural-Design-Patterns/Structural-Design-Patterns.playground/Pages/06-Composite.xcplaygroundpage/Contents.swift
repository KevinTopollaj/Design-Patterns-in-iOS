import UIKit

// Step 1: Create the Component protocol
protocol UIComponent {
  func display()
}

// Step 2: Implement Leaf objects
class UIButton: UIComponent {
  var label: String

  init(label: String) {
    self.label = label
  }

  func display() {
    print("Button: \(label)")
  }
}

class UILabel: UIComponent {
  var text: String

  init(text: String) {
    self.text = text
  }

  func display() {
    print("Label: \(text)")
  }
}

// Step 3: Implement Composite object
class UIView: UIComponent {
  var children: [UIComponent] = []

  func add(child: UIComponent) {
    children.append(child)
  }

  func display() {
    for child in children {
      child.display()
    }
  }
}

// @Kevin_Topollaj

// Usage
let view1 = UIView()
let label = UILabel(text: "Welcome!")
let button = UIButton(label: "Click Me")

view1.add(child: label)
view1.add(child: button)

let view2 = UIView()
let anotherButton = UIButton(label: "Submit")

view2.add(child: view1)
view2.add(child: anotherButton)

view2.display()
