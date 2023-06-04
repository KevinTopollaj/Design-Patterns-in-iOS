import Foundation

// A protocol defining a data source
protocol DataSource {
    func fetchData() -> String
}

// A class that depends on the DataSource protocol and
// injects it using constructor injection
class DataManager {
    private let dataSource: DataSource

    init(dataSource: DataSource) {
        self.dataSource = dataSource
    }

    func displayData() {
        let data = dataSource.fetchData()
        print("Fetched data: \(data)")
    }
}

// A concrete implementation of the DataSource protocol
class RemoteDataSource: DataSource {
    func fetchData() -> String {
        return "Data from remote server"
    }
}

// Another concrete implementation of the DataSource protocol
class LocalDataSource: DataSource {
    func fetchData() -> String {
        return "Data from local storage"
    }
}

// Create instances of the data sources
let remoteDataSource = RemoteDataSource()
let localDataSource = LocalDataSource()

// Create an instance of DataManager with a remote data source
let dataManager = DataManager(dataSource: remoteDataSource)
dataManager.displayData() // Fetched data: Data from remote server

// Create another instance of DataManager with a local data source
let anotherDataManager = DataManager(dataSource: localDataSource)
anotherDataManager.displayData() // Fetched data: Data from local storage



