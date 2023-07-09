import Foundation

// 1. Create a DatabaseConnection class as a reusable resource
class DatabaseConnection {
  private let connectionString: String

  init(connectionString: String) {
    self.connectionString = connectionString
    // Perform expensive initialization here, e.g., establish a connection to the database
  }

  func executeQuery(_ query: String) {
    // Execute the database query
    // ...
  }
}

// 2. Create a DatabaseConnectionPool class to manage DatabaseConnection objects
class DatabaseConnectionPool {
  private let maxConnections: Int
  private var availableConnections: [DatabaseConnection] = []
  private var inUseConnections: [DatabaseConnection] = []

  init(maxConnections: Int, connectionString: String) {
    self.maxConnections = maxConnections

    for _ in 0..<maxConnections {
      let connection = DatabaseConnection(connectionString: connectionString)
      availableConnections.append(connection)
    }
  }

  func getConnection() -> DatabaseConnection? {
    guard !availableConnections.isEmpty else {
      return nil // Pool is empty, return nil or wait for a connection to become available
    }

    let connection = availableConnections.removeLast()
    inUseConnections.append(connection)
    return connection
  }

  func releaseConnection(_ connection: DatabaseConnection) {
    if let index = inUseConnections.firstIndex(where: { $0 === connection }) {
      let connection = inUseConnections.remove(at: index)
      availableConnections.append(connection)
    }
  }
}

// Step 3: Initialize the pool
let maxConnections = 10
let connectionString = "your_database_connection_string"
let connectionPool = DatabaseConnectionPool(maxConnections: maxConnections,
                                            connectionString: connectionString)

// Step 4: Acquire and release objects
if let connection = connectionPool.getConnection() {
  // Use the connection for your database operations
  // ...
  connectionPool.releaseConnection(connection)
} else {
  // Handle the case when no connections are available
  // ...
}





