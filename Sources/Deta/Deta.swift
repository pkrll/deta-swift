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
        let request = try URLRequest(for: .delete(key: key), using: configuration)
        let (_, response) = try await session.data(for: request)
        
        guard let response = response as? HTTPURLResponse else {
            throw Error.unexpectedResponse
        }
        
        let status = HttpStatus(response.statusCode)
        if !status.isSuccess {
            throw Error(from: status)
        }
    }
    
    public func get<T: DetaModel>(model: T.Type, key: String) async throws -> T {
        let request = try URLRequest(for: .get(key: key), using: configuration)
        let (data, response) = try await session.data(for: request)
        
        guard let response = response as? HTTPURLResponse else {
            throw Error.unexpectedResponse
        }
        
        let status = HttpStatus(response.statusCode)
        guard status.isSuccess else {
            throw Error(from: status)
        }
        
        let decoder = JSONDecoder()
        let value = try decoder.decode(T.self, from: data)
        
        return value
    }
    
    public func insert<T: DetaModel>(item: T) async throws -> T {
        let payload = Insert.Request(item: item)
        let encoder = JSONEncoder()
        var request = try URLRequest(for: .insert, using: configuration)
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
        let value = try decoder.decode(T.self, from: data)
        
        return value
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
    
    public func fetch<T: DetaModel>(model: T.Type, @GroupingQueryBuilder _ query: () -> [GroupedQueries]) async throws -> Fetch.Response<T> {
        let queries = query().map(\.queries)
        let payload = Fetch.Request(query: queries, limit: nil, last: nil)
        let encoder = JSONEncoder()
        var request = try URLRequest(for: .query, using: configuration)
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
        let value = try decoder.decode(Fetch.Response<T>.self, from: data)
        
        return value
    }
}
