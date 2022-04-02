//
// Deta
//

import Foundation
@testable import Deta

extension Put.Response {
    init(items: [Item]) {
        self.init(processed: .init(items: items), failed: nil)
    }
}