//
// Deta
//

import Foundation

struct Insert {
    struct Request<Item: DetaModel>: Encodable {
        let item: Item
    }
}
