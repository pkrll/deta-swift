//
// Deta
//

import Foundation
import Network
@testable import Deta

extension Fetch.Response: Encodable, Equatable where Item: Equatable {
    
    public static func == (lhs: Fetch.Response<Item>, rhs: Fetch.Response<Item>) -> Bool {
        lhs.paging.size == rhs.paging.size && lhs.paging.last == rhs.paging.last && lhs.items == rhs.items
    }

    private enum CodingKeys: String, CodingKey {
        case paging
        case items
    }
    
    public func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(paging, forKey: .paging)
        try container.encode(items, forKey: .items)
    }
    
    func convert() -> Data? {
        try? JSONBody(self).encode()
    }
}

extension Fetch.Response.Paging: Encodable {
    
    private enum CodingKeys: String, CodingKey {
        case size
        case last
    }
    
    public func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(size, forKey: .size)
        try container.encode(last, forKey: .last)
    }
}
