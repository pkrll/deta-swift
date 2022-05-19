//
// Deta
//

import Foundation

extension AnyEncodableContainer: ExpressibleByIntegerLiteral {
    public init(integerLiteral value: Int) {
        self.init(value)
    }
}
