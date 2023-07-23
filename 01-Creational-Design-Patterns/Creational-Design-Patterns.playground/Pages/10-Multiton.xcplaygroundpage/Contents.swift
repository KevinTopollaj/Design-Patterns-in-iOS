import UIKit

// Create a shared protocol for themes
protocol Theme: Equatable {
  var backgroundColor: UIColor { get }
  var textColor: UIColor { get }
}

// Implement different themes conforming to the Theme protocol
struct LightTheme: Theme {
  var backgroundColor: UIColor = .white
  var textColor: UIColor = .black
}

struct DarkTheme: Theme {
  var backgroundColor: UIColor = .black
  var textColor: UIColor = .white
}

// Implement custom equality comparison for Theme instances
func ==(lhs: any Theme, rhs: any Theme) -> Bool {
  return lhs.backgroundColor == rhs.backgroundColor &&
         lhs.textColor == rhs.textColor
}

// Make ThemeManager a struct for value semantics.
struct ThemeManager {

  enum ThemeColor {
    case light
    case dark
  }

  // Private initializer to prevent external instantiation
  private init() {}

  // Static constant to hold the shared instance
  static var shared = ThemeManager()

  private var themes: [ThemeColor: any Theme] = [
    .light: LightTheme(),
    .dark: DarkTheme()
  ]

  // Function to retrieve themes from the dictionary
  func theme(for themeColor: ThemeColor) -> any Theme {
    return themes[themeColor] ?? LightTheme()
  }
}

// Usage:

let lightTheme = ThemeManager.shared.theme(for: .light)
let darkTheme = ThemeManager.shared.theme(for: .dark)
let anotherLightTheme = ThemeManager.shared.theme(for: .light)

print(lightTheme == anotherLightTheme) // Output: true
print(lightTheme == darkTheme) // Output: false


