//
// Deta
//

import Foundation
import Network

extension Deta {
    func parse<T: Decodable>(_ response: Response, as type: T.Type) throws -> T {
        guard let data = response.data else {
            throw Error(code: .unknown, messages: ["Missing data"], underlyingError: nil)
        }

        do {
            let decoder = JSONDecoder()
            return try decoder.decode(T.self, from: data)
        } catch {
            throw error
        }
    }
}
