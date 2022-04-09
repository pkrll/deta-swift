//
// Deta
//

import Foundation

extension AnyEncodableContainer: ExpressibleByFloatLiteral {
    public init(floatLiteral value: Double) {
        self.init(value)
    }
}
