//
// Deta
//

import Foundation

extension AnyEncodableContainer: ExpressibleByStringLiteral, ExpressibleByStringInterpolation {
    public init(stringLiteral value: String) {
        self.init(value)
    }
}
