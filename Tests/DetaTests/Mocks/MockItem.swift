//
// Deta
//

import Foundation
import Network
import Deta

struct MockItem: Fetchable, Equatable {
    let key: String?
    let title: String
    let subtitle: String?
}

extension MockItem {
    func convert() -> Data? {
        try? JSONBody(self).encode()
    }
}
