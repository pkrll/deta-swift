//
// Deta
//

import Foundation

extension AnyEncodable: ExpressibleByIntegerLiteral {
    public init(integerLiteral value: Int) {
        self.init(value)
    }
}
