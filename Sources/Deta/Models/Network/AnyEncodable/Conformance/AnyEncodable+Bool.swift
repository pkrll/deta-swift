//
// Deta
//

import Foundation

extension AnyEncodable: ExpressibleByBooleanLiteral {
    public init(booleanLiteral value: BooleanLiteralType) {
        self.init(value)
    }
}
