
import Foundation

// Step 1: Define the Abstraction

protocol DrawingShape {
    func draw()
}

// Step 2: Implement Abstraction

class Circle: DrawingShape {
    func draw() {
        print("Draw a circle")
    }
}

class Rectangle: DrawingShape {
    func draw() {
        print("Draw a rectangle")
    }
}

// Step 3: Define the Implementor

protocol DrawingTool {
    func draw(shape: DrawingShape)
}

// Step 4: Implement Implementor

class PencilTool: DrawingTool {
    func draw(shape: DrawingShape) {
        print("Drawing with pencil:")
        shape.draw()
    }
}

class BrushTool: DrawingTool {
    func draw(shape: DrawingShape) {
        print("Drawing with brush:")
        shape.draw()
    }
}

// Step 5: Use the Bridge Pattern

let circle = Circle()
let rectangle = Rectangle()

let pencil = PencilTool()
let brush = BrushTool()

pencil.draw(shape: circle)
brush.draw(shape: rectangle)
