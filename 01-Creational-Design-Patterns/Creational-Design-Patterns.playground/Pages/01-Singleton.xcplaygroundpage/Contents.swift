import Foundation

final class Singleton {
    static let shared = Singleton()

    private init() { }

    func printSomething() {
        print("This is a Singleton")
    }
}

let singleton = Singleton.shared

singleton.printSomething()



