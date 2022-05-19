//
// Deta
//

import Foundation

extension AnyEncodableContainer: ExpressibleByArrayLiteral {
    public init(arrayLiteral elements: Any...) {
        self.init(elements)
    }
}
