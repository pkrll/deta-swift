//
// Deta
//

import Foundation
import Network

extension Deta {
    func parse<T: Decodable>(response: Response, as type: T.Type) -> Result<T, Error> {
        guard let data = response.data else {
            return .failure(DetaError.noData)
        }
        
        let decoder = JSONDecoder()
        let result: Result<T, Error>
        
        do {
            let response = try decoder.decode(T.self, from: data)
            result = .success(response)
        } catch {
            result = .failure(error)
        }
        
        return result
    }
}
