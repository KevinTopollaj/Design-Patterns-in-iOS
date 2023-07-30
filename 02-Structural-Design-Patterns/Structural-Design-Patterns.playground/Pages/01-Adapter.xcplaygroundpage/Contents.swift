import Foundation

enum Weather: String {
  case sunny, rainy
}

// Target
protocol WeatherService {
  func getCurrentWeather() -> String
}

// Adaptee
class WeatherProvider {
  func fetchWeatherData() -> Weather {
    return .sunny
  }
}

// Adapter
class WeatherProviderAdapter: WeatherService {
  private let weatherProvider: WeatherProvider

  init(weatherProvider: WeatherProvider) {
    self.weatherProvider = weatherProvider
  }

  func getCurrentWeather() -> String {
    let weather = weatherProvider.fetchWeatherData()
    return weather.rawValue.capitalized
  }
}

// @ Kevin_Topollaj

let weatherProvider = WeatherProvider()
let providerService = WeatherProviderAdapter(weatherProvider: weatherProvider)
let weatherString = providerService.getCurrentWeather()



