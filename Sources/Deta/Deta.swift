import Foundation
import Network

public final class Deta {
    
    private let projectKey: String
    private let base: String
    private let environment: Environment
    private let builder: OperationBuilder

    private var standardOperation: Operator {
        let operation = builder
            .append(.session(.shared))
            .append(.environment(environment))
            .build()
        
        return operation
    }
    
    public init(projectKey: String, base: String) {
        self.projectKey = projectKey
        self.base = base
        
        environment = .init(projectKey: projectKey, base: base)
        builder = OperationBuilder()
    }
    /// Deletes an item from the database that matches the key provided.
    ///
    /// - Parameter key: The key of which item to be deleted.
    public func delete(key: String, completion: @escaping () -> Void) {
        fatalError("Not implemented.")
    }
    /// Retrieves an item from the database that matches the key provided.
    ///
    /// - Parameter key:        The key of which item to be retrieved.
    /// - Parameter completion: If the item does not exists, the completion handler will return an error.
    public func get<T: ItemModel>(key: String, completion: @escaping (Result<T, Error>) -> Void) {
        fatalError("Not implemented.")
    }
    /// Inserts a single item into a Base. Unlike ``put``, this method will return an error if
    /// an item with the same key already exists.
    ///
    /// - Parameter value:      The model you want to add to the database. If the key property of the model is nil,
    ///                         Deta will automaticallt generate a 12 character long string as key which will be
    ///                         be assigned to the item returned.
    /// - Parameter completion: Called upon completion. If successful, the completion handler will return the newly
    ///                         created item. Otherwise, an error is returned.
    public func insert<T: ItemModel>(_ value: T, completion: @escaping (Result<T, Error>) -> Void) {
        fatalError("Not implemented.")
    }
    /// Store an item in the Base.
    /// - Note: This method can also be used to update an item in the database, if the model contains a valid key.
    ///
    /// - Parameter value:      The model you want to add to the database. If the key property of the model is nil,
    ///                         Deta will automaticallt generate a 12 character long string as key which will be
    ///                         be assigned to the item returned.
    /// - Parameter completion: Called upon completion. If successful, the completion handler will return the newly
    ///                         created item. Otherwise, an error is returned.
    public func put<T: ItemModel>(_ value: T, completion: @escaping (Result<T, Error>) -> Void) {
        fatalError("Not implemented.")
    }
    /// Stores up to 25 items in the Base.
    ///
    /// - Note: This method can also be used to update an item in the database, if the model contains a valid key.
    ///
    /// - Parameter values:     The list of model you want to add to the database.
    /// - Parameter completion: Called upon completion. If successful, the completion handler will return the newly
    ///                         created items. Otherwise, an error is returned.
    public func put<T: ItemModel>(many values: [T], completion: @escaping (Result<[T], Error>) -> Void) {
        guard values.count <= 25 else {
            fatalError("This should throw an error.")
        }
    }
    
    public func update() {
        fatalError("Not implemented.")
    }
    
    public func fetch<T: ItemModel>(model: T.Type, _ completion: @escaping (Result<FetchResponse<T>, Error>) -> Void) {
        standardOperation.send(.post("query")) { [weak self] result in
            guard let self = self else { return }

            switch result {
            case .failure(let error):
                completion(.failure(error))
            case .success(let response):
                let result = self.parse(response: response, as: FetchResponse<T>.self)
                completion(result)
            }
        }
    }
    
    private func parse<T: Decodable>(response: Response, as type: T.Type) -> Result<T, Error> {
        guard let data = response.data else {
            return .failure(DetaError.noData)
        }
        
        let decoder = JSONDecoder()
        let result: Result<T, Error>
        
        do {
            let response = try decoder.decode(T.self, from: data)
            result = .success(response)
        } catch {
            result = .failure(error)
        }
        
        return result
    }
}
