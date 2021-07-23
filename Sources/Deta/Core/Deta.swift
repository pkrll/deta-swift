import Foundation
import NetworkStack

public final class Deta {
    
    private let projectKey: String
    private let base: String
    private let environment: Environment
    
    @Injected(\.operationBuilder) private var builder: OperationBuilder
    
    private var standardOperation: Operator {
        let operation = builder
            .append(.transport(URLSession.shared))
            .append(.environment(environment))
            .build()
        
        return operation
    }
    
    public init(projectKey: String, base: String) {
        self.projectKey = projectKey
        self.base = base
        
        environment = .init(projectKey: projectKey, base: base)
    }
    /// Deletes an item from the database that matches the key provided.
    ///
    /// - Parameter key: The key of which item to be deleted.
    public func delete(key: String, completion: @escaping (Result<Void, Error>) -> Void) {
        let request = Request.delete("items/\(key)")
        
        standardOperation.send(request) { result in
            let returnValue: Result<Void, Error>
            
            switch result {
            case .failure(let response):
                let error = Error(from: response)
                returnValue = .failure(error)
            case .success:
                returnValue = .success(())
            }
            
            completion(returnValue)
        }
    }
    /// List items that match a query.
    ///
    /// - Parameter model: The type of the expected model to fetch.
    /// - Parameter query: A query.
    public func fetch<T: Fetchable>(model: T.Type,
                                    query: Fetch.Request? = nil,
                                    _ completion: @escaping (Result<Fetch.Response<T>, Error>) -> Void) {
        var request = Request.post("query")
        
        if let query = query {
            request.body = JSONBody(query)
        }
        
        standardOperation.send(request) { [weak self] result in
            guard let self = self else { return }
            let returnValue: Result<Fetch.Response<T>, Error>
            
            do {
                switch result {
                case .failure(let response):
                    let error = Error(from: response)
                    returnValue = .failure(error)
                case .success(let response) where response.status == .badRequest:
                    let error = Error(from: response)
                    returnValue = .failure(error)
                case .success(let response):
                    let result = try self.parse(response, as: Fetch.Response<T>.self)
                    returnValue = .success(result)
                }
            } catch {
                let error = Error(code: .unknown, underlyingError: error)
                returnValue = .failure(error)
            }
            
            completion(returnValue)
        }
    }
    /// Retrieves an item from the database that matches the key provided.
    ///
    /// - Parameter key:        The key of which item to be retrieved.
    /// - Parameter completion: If the item does not exists, the completion handler will return an error.
    public func get<T: Fetchable>(key: String, for item: T.Type, completion: @escaping (Result<T, Error>) -> Void) {
        let request = Request.get("items/\(key)")
        
        standardOperation.send(request) { [weak self] result in
            guard let self = self else { return }
            let returnValue: Result<T, Error>
            
            do {
                switch result {
                case .failure(let response):
                    let error = Error(from: response)
                    returnValue = .failure(error)
                case .success(let response) where response.status == .ok:
                    let result = try self.parse(response, as: T.self)
                    returnValue = .success(result)
                case .success(let response):
                    let error = Error(from: response)
                    returnValue = .failure(error)
                }
            } catch {
                let error = Error(code: .unknown, underlyingError: error)
                returnValue = .failure(error)
            }
            
            completion(returnValue)
        }
    }
    /// Inserts a single item into a Base. Unlike ``put``, this method will return an error if
    /// an item with the same key already exists.
    ///
    /// - Parameter value:      The model you want to add to the database. If the key property of the model is nil,
    ///                         Deta will automaticallt generate a 12 character long string as key which will be
    ///                         be assigned to the item returned.
    /// - Parameter completion: Called upon completion. If successful, the completion handler will return the newly
    ///                         created item. Otherwise, an error is returned.
    public func insert<T: Fetchable>(_ value: T, completion: @escaping (Result<T, Error>) -> Void) {
        var request = Request.post("items")
        request.body = JSONBody(Insert.Request(item: value))
        
        standardOperation.send(request) { [weak self] result in
            guard let self = self else { return }
            let returnValue: Result<T, Error>
            
            do {
                switch result {
                case .failure(let response):
                    let error = Error(from: response)
                    returnValue = .failure(error)
                case .success(let response) where response.status == .created:
                    let result = try self.parse(response, as: T.self)
                    returnValue = .success(result)
                case .success(let response):
                    let error = Error(from: response)
                    returnValue = .failure(error)
                }
            } catch {
                let error = Error(code: .unknown, underlyingError: error)
                returnValue = .failure(error)
            }
            
            completion(returnValue)
        }
    }
    /// Store an item in the Base.
    /// - Note: This method can also be used to update an item in the database, if the model contains a valid key.
    ///
    /// - Parameter value:      The model you want to add to the database. If the key property of the model is nil,
    ///                         Deta will automaticallt generate a 12 character long string as key which will be
    ///                         be assigned to the item returned.
    /// - Parameter completion: Called upon completion. If successful, the completion handler will return the newly
    ///                         created item. Otherwise, an error is returned.
    public func put<T: Fetchable>(items: [T], _ completion: @escaping (Result<Put.Response<T>, Error>) -> Void) {
        var request = Request.put("items")
        request.body = JSONBody(Put.Request(items: items))
        
        standardOperation.send(request) { [weak self] result in
            guard let self = self else { return }
            let returnValue: Result<Put.Response<T>, Error>
            
            do {
                switch result {
                case .failure(let response):
                    let error = Error(from: response)
                    returnValue = .failure(error)
                case .success(let response) where response.status == .multiStatus:
                    let result = try self.parse(response, as: Put.Response<T>.self)
                    returnValue = .success(result)
                case .success(let response):
                    let error = Error(from: response)
                    returnValue = .failure(error)
                }
            } catch {
                let error = Error(code: .unknown, underlyingError: error)
                returnValue = .failure(error)
            }
            
            completion(returnValue)
        }
    }
    
    public func update(key: String,
                       payload: Update.Request,
                       _ completion: @escaping (Result<Update.Response, Error>) -> Void) {
        var request = Request.patch("items/\(key)")
        request.body = JSONBody(payload)
        
        standardOperation.send(request) { [weak self] result in
            guard let self = self else { return }
            let returnValue: Result<Update.Response, Error>
            
            do {
                switch result {
                case .failure(let response):
                    let error = Error(from: response)
                    returnValue = .failure(error)
                case .success(let response) where response.status == .ok:
                    let result = try self.parse(response, as: Update.Response.self)
                    returnValue = .success(result)
                case .success(let response):
                    let error = Error(from: response)
                    returnValue = .failure(error)
                }
            } catch {
                let error = Error(code: .unknown, underlyingError: error)
                returnValue = .failure(error)
            }
            
            completion(returnValue)
        }
    }
}
