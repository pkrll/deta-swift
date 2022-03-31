//
// Deta
//

import Foundation
#if canImport(FoundationNetworking)
import FoundationNetworking
#endif

public final class Deta {    
    
    private let configuration: Configuration
    private let session: URLSession
    
    public convenience init(with configuration: Configuration) {
        self.init(configuration: configuration, session: .shared)
    }
    
    init(configuration: Configuration, session: URLSession) {
        self.configuration = configuration
        self.session = session
    }

    public func delete(key: String) async throws {
        fatalError("Not implemented.")
    }
    
    public func get<T: DetaModel>(key: String) async throws -> T {
        fatalError("Not implemented")
    }
    
    public func insert<T: DetaModel>(item: T) async throws -> T {
        fatalError("Not implemented")
    }
    
    public func put<T: DetaModel>(items: [T]) async throws -> Put.Response<T> {
        let payload = Put.Request(items: items)
        let encoder = JSONEncoder()
        var request = try URLRequest(for: .put, using: configuration)
        request.httpBody = try encoder.encode(payload)
        
        let (data, response) = try await session.data(for: request)
        
        guard let response = response as? HTTPURLResponse else {
            throw Error.unexpectedResponse
        }
        
        let status = HttpStatus(response.statusCode)
        guard status.isSuccess else {
            throw Error(from: status)
        }
        
        let decoder = JSONDecoder()
        let value = try decoder.decode(Put.Response<T>.self, from: data)
        
        return value
    }
    
    public func update<T: DetaModel>(item: T) async throws {
        fatalError("Not implemented")
    }
    
    public func query<T: DetaModel>() async throws -> [T] {
        fatalError("Not implemented")
    }
}
