//
// Deta
//

import Foundation

extension AnyEncodable: ExpressibleByFloatLiteral {
    public init(floatLiteral value: Double) {
        self.init(value)
    }
}
