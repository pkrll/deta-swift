//
// Deta
//

import Foundation

public protocol ItemModel: Codable {
    var key: String? { get }
}

public struct PartialItem: Decodable, Error {
    public let key: String
}
