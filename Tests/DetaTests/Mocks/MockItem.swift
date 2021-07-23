//
// Deta
//

import Foundation
import NetworkStack
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

extension MockItem {
    static func items(from keys: [String]) -> [Self] {
        keys.map { MockItem(key: $0, title: $0, subtitle: nil) }
    }
}
