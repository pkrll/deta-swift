//
// Deta
//

import Foundation

public struct Insert {
    struct Request<Item: Encodable>: Encodable {
        let item: Item
    }
}
