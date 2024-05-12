//
// Deta
//

import Foundation
#if canImport(FoundationNetworking)
import FoundationNetworking
#endif

public final class Deta {    
    
    private let configuration: Configuration
    private let transport: Transporting
    
    public convenience init(with configuration: Configuration) {
        self.init(configuration: configuration, transport: URLSession.shared)
    }
    
    init(configuration: Configuration, transport: Transporting) {
        self.configuration = configuration
        self.transport = transport
    }

    public func delete(key: String) async throws {
        let request = try URLRequest(for: .delete(key: key), using: configuration)
        let _ = try await execute(request: request)
    }
    
    public func get<T: DetaModel>(model: T.Type, key: String) async throws -> T {
        let request = try URLRequest(for: .get(key: key), using: configuration)
        
        let data = try await execute(request: request)
        let decoder = JSONDecoder()
        let value = try decoder.decode(T.self, from: data)
        
        return value
    }
    
    public func insert<T: DetaModel>(item: T) async throws -> T {
        let payload = Insert.Request(item: item)
        let encoder = JSONEncoder()
        var request = try URLRequest(for: .insert, using: configuration)
        request.httpBody = try encoder.encode(payload)
        
        let data = try await execute(request: request)
        let decoder = JSONDecoder()
        let value = try decoder.decode(T.self, from: data)
        
        return value
    }
    
    public func put<T: DetaModel>(items: [T]) async throws -> Put.Response<T> {
        let payload = Put.Request(items: items)
        let encoder = JSONEncoder()
        var request = try URLRequest(for: .put, using: configuration)
        request.httpBody = try encoder.encode(payload)
        
        let data = try await execute(request: request)
        let decoder = JSONDecoder()
        let value = try decoder.decode(Put.Response<T>.self, from: data)
        
        return value
    }
    
    public func fetch<T: DetaModel>(
        model: T.Type,
        limit: Int? = nil,
        last: String? = nil,
        @GroupingQueryBuilder _ query: () -> [GroupedQueries]
    ) async throws -> Fetch.Response<T> {
        let queries = query().map(\.queries)
        let payload = Fetch.Request(query: queries, limit: limit, last: last)
        let encoder = JSONEncoder()
        var request = try URLRequest(for: .query, using: configuration)
        request.httpBody = try encoder.encode(payload)
        
        let data = try await execute(request: request)
        let decoder = JSONDecoder()
        let value = try decoder.decode(Fetch.Response<T>.self, from: data)
        
        return value
    }

    @discardableResult
    private func execute(request: URLRequest) async throws -> Data {
        let (data, response) = try await transport.data(for: request)
        
        guard let response = response as? HTTPURLResponse else {
            throw Error.unexpectedResponse
        }
        
        let status = HttpStatus(response.statusCode)
        guard status.isSuccess else {
            throw Error(from: status)
        }
        
        return data
    }
}
