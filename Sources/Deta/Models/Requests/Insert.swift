//
// Deta
//

import Foundation

struct Insert {
    struct Request<Item: Encodable>: Encodable {
        let item: Item
    }
}
