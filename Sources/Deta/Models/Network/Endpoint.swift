//
// Deta
//

import Foundation

enum Endpoint {
    case delete(key: String)
    case get(key: String)
    case insert
    case put
    case query
    case update(key: String)
    
    var path: String {
        switch self {
        case .delete(let key), .get(let key), .update(let key):
            return "items/\(key)"
        case .insert, .put:
            return "items"
        case .query:
            return "query"
        }
    }
    
    var httpMethod: String {
        switch self {
        case .delete:
            return "DELETE"
        case .get:
            return "GET"
        case .insert, .query:
            return "POST"
        case .put:
            return "PUT"
        case .update:
            return "PATCH"
        }
    }
}
