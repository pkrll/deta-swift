//
// Deta
//

import Foundation

extension AnyEncodable: ExpressibleByDictionaryLiteral {
    public init(dictionaryLiteral elements: (AnyHashable, Any)...) {
        self.init([AnyHashable: Any](elements, uniquingKeysWith: { first, _ in first }))
    }
}
