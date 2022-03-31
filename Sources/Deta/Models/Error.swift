//
// Deta
//

import Foundation

enum Error: Swift.Error {
    case badRequest
    case invalidUrl
    case unauthorized
    case unexpectedResponse
    case httpStatus(Int)
    
    init(from status: HttpStatus) {
        switch status {
        case .badRequest:
            self = .badRequest
        case .unauthorized:
            self = .unauthorized
        default:
            self = .httpStatus(status.rawValue)
        }
    }
}
