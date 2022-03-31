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
        components.path = "\(configuration.pathPrefix)/\(endpoint.path)"
        
        guard let url = components.url else {
            throw Error.invalidUrl
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = endpoint.httpMethod
        request.setValue(configuration.projectKey, forHTTPHeaderField: "X-API-KEY")
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")

        self = request
    }
}
