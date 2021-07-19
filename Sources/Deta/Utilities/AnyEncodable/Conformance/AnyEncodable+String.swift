//
// Deta
//

import Foundation

extension AnyEncodable: ExpressibleByStringLiteral {
    public init(stringLiteral value: String) {
        self.init(value)
    }
}
