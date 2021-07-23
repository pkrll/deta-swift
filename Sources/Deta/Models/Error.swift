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
    public let message: String?
    public let underlyingError: Swift.Error?
    
    init(code: Code, message: String? = nil, underlyingError: Swift.Error? = nil) {
        self.code = code
        self.message = message
        self.underlyingError = underlyingError
    }
}

extension Error {
    public static let keyAlreadyExists = Error(code: .keyAlreadyExists, message: nil)
    public static let keyNotFound = Error(code: .keyNotFound, message: nil)
    public static let unknown = Error(code: .unknown, message: nil)
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
            self.init(code: .badRequest, message: model?.errors.first)
        case .conflict:
            self.init(code: .keyAlreadyExists, message: model?.errors.first)
        case .notFound:
            self.init(code: .keyNotFound, message: model?.errors.first)
        default:
            self.init(code: .unknown, message: model?.errors.first)
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
