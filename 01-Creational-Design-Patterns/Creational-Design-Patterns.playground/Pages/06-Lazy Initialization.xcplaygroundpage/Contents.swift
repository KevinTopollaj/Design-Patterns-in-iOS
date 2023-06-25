import UIKit

class DatabaseConnection {
  init() {
    print("Establishing database connection...")
    // ...
    print("Database connection established!")
  }
  // ...
}

class DatabaseManager {
  private var databaseConnection: DatabaseConnection?

  static let shared = DatabaseManager()
  // Private initializer to prevent direct instantiation
  private init() { }

  func connect() -> DatabaseConnection {
    if let connection = databaseConnection {
      // Return the existing connection if it already exists
      return connection
    } else {
      // Create a new connection if it doesn't exist
      let connection = DatabaseConnection()
      databaseConnection = connection
      return connection
    }
  }
}

class ResponsibleViewForDBConnection {
  // Lazy initialization
  private lazy var databaseManager: DatabaseManager = {
    return DatabaseManager.shared
  }()

  func performDatabaseOperations() {
    let connection = databaseManager.connect()
    // Perform database operations using the connection
  }
}

let view = ResponsibleViewForDBConnection()
view.performDatabaseOperations()



