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
    
    func parse<T: Decodable>(response: Response, as type: T.Type) -> Result<T, Error> {
        guard let data = response.data else {
            return .failure(DetaError.missingData)
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
