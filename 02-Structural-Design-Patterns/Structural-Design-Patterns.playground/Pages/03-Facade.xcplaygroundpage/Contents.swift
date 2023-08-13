import Foundation

// Subsystem: Authentication
protocol AuthServiceProtocol {
  func login(username: String, password: String) -> Bool
}

class AuthService: AuthServiceProtocol {
  func login(username: String, password: String) -> Bool {
    // Simulate authentication logic
    return username == "Bob" && password == "bob123"
  }
}

// Subsystem: Playlist Management
protocol PlaylistServiceProtocol {
  func createPlaylist(name: String) -> String
}

class PlaylistService: PlaylistServiceProtocol {
  func createPlaylist(name: String) -> String {
    // Simulate playlist creation logic
    return "Playlist '\(name)' created"
  }
}

// Facade
class MusicAppFacade {
  private let authService: AuthServiceProtocol
  private let playlistService: PlaylistServiceProtocol

  init(authService: AuthServiceProtocol,
       playlistService: PlaylistServiceProtocol) {

    self.authService = authService
    self.playlistService = playlistService
  }

  func createPlaylist(username: String,
                      password: String,
                      playlistName: String) -> Result<String, Error> {

    if authService.login(username: username, password: password) {
      let welcomeMessage = "Welcome to the music app: \(username)"
      let playlist = playlistService.createPlaylist(name: playlistName)
      return .success("\(welcomeMessage)\n\(playlist)")
    } else {
      return .failure(NSError(domain: "LoginErrorDomain", code: 1, userInfo: nil))
    }
  }
}

// Usage
let authService = AuthService()
let playlistService = PlaylistService()
let musicApp = MusicAppFacade(authService: authService,
                              playlistService: playlistService)

switch musicApp.createPlaylist(username: "Bob",
                               password: "bob123",
                               playlistName: "My Favorites") {
case .success(let result):
  print(result)
case .failure(let error):
  print("Action failed. Error: \(error)")
}
