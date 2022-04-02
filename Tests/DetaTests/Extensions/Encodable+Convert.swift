//
// Deta
//

import Foundation

extension Encodable {
    func convert() -> Data? {
        try? JSONEncoder().encode(self)
    }
}
