//
// Deta
//

import Foundation
import Network

public struct Error: Swift.Error {

    public enum Code {
        case badRequest
        case keyAlreadyExists
        case keyNotFound
        case unknown
    }
    
    public let code: Code
    public let messages: [String]?
    public let underlyingError: Swift.Error?
    
    init(code: Code, messages: [String]? = nil, underlyingError: Swift.Error? = nil) {
        self.code = code
        self.messages = messages
        self.underlyingError = underlyingError
    }
}

extension Error {
    public static let keyAlreadyExists = Error(code: .keyAlreadyExists)
    public static let keyNotFound = Error(code: .keyNotFound)
    public static let unknown = Error(code: .unknown)
}

extension Error {
    
    struct Model: Decodable {
        let errors: [String]
    }
    
    init(from response: Response) {
        let decoder = JSONDecoder()
        let model = try? decoder.decodeIfPossible(Model.self, from: response.data)
        
        switch response.status {
        case .badRequest:
            self.init(code: .badRequest, messages: model?.errors)
        case .conflict:
            self.init(code: .keyAlreadyExists, messages: model?.errors)
        case .notFound:
            self.init(code: .keyNotFound, messages: model?.errors)
        default:
            self.init(code: .unknown, messages: model?.errors)
        }
    }
    
    init(from error: HttpError) {
        self.init(code: .unknown, underlyingError: error)
    }
    
}

extension JSONDecoder {
    func decodeIfPossible<T: Decodable>(_ type: T.Type, from data: Data?) throws -> T {
        guard let data = data else {
            throw Error.unknown
        }
        
        return try decode(type, from: data)
    }
}
