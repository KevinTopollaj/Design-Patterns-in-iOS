import Foundation

// Service protocol
protocol AuthenticationService {
  func login(username: String, password: String) -> Bool
}

// Concrete implementation of AuthenticationService
class FirebaseAuthenticationService: AuthenticationService {

  func login(username: String, password: String) -> Bool {
    print("Logged in using Firebase")
    return true
  }

}

class ServiceLocator {
  static let shared = ServiceLocator()

  private var services: [String: AuthenticationService] = [:]

  private init() {}

  func registerService(_ service: AuthenticationService) {
    let key = String(describing: type(of: service))
    services[key] = service
  }

  func getService<T>() -> T? {
    let key = String(describing: T.self)
    return services[key] as? T
  }
}


// @ Kevin_Topollaj
class AuthenticationManager {
  private let authenticationService: AuthenticationService

  init(authenticationService: AuthenticationService) {
    self.authenticationService = authenticationService
  }

  func login(username: String, password: String) -> Bool {
    return authenticationService.login(username: username,
                                       password: password)
  }

}

ServiceLocator.shared.registerService(FirebaseAuthenticationService())

guard let service = ServiceLocator.shared.getService() as FirebaseAuthenticationService? else {
  fatalError("No authentication service found")
}

let authenticationManager = AuthenticationManager(authenticationService: service)

let success = authenticationManager.login(username: "user123",
                                          password: "password123")
if success {
  print("Login successful")
} else {
  print("Login failed")
}

