//
// Deta
//

import Foundation
import Network

extension Deta {
    func parseError(from response: Response) -> Error {
        guard let data = response.data else {
            return DetaError.missingData
        }
        
        do {
            let decoder = JSONDecoder()
            return try decoder.decode(DetaError.self, from: data)
        } catch {
            return error
        }
    }
    
    func parse<T: Decodable>(_ response: Response, as type: T.Type) throws -> T {
        guard let data = response.data else {
            throw DetaError.missingData
        }

        do {
            let decoder = JSONDecoder()
            return try decoder.decode(T.self, from: data)
        } catch {
            throw error
        }
    }
}
