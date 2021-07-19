//
// Deta
//

import Foundation

extension AnyEncodable: ExpressibleByArrayLiteral {
    public init(arrayLiteral elements: Any...) {
        self.init(elements)
    }
}
