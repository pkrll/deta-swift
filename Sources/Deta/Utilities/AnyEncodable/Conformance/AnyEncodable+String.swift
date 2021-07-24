//
// Deta
//

import Foundation

extension AnyEncodable: ExpressibleByStringLiteral, ExpressibleByStringInterpolation {
    public init(stringLiteral value: String) {
        self.init(value)
    }
}
