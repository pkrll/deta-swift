//
// Deta
//

import Foundation

extension AnyEncodableContainer: ExpressibleByBooleanLiteral {
    public init(booleanLiteral value: BooleanLiteralType) {
        self.init(value)
    }
}
