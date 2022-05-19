//
// Deta
//

import Foundation
import Deta

struct MockItem: DetaModel, Equatable {
    let key: String?
    let title: String
    let subtitle: String?
}

extension MockItem {
    static func items(from keys: [String]) -> [Self] {
        keys.map { MockItem(key: $0, title: $0, subtitle: nil) }
    }
}
