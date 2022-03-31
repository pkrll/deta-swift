//
// Deta
//

import Foundation
#if canImport(FoundationNetworking)
import FoundationNetworking
#endif

extension URLRequest {    
    init(for endpoint: Endpoint, using configuration: Configuration) throws {
        var components = URLComponents()
        components.scheme = "https"
        components.host = configuration.baseUrl
        components.path = endpoint.path
        
        guard let url = components.url else {
            throw Error.invalidUrl
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = endpoint.httpMethod
        
        self = request
    }
}
