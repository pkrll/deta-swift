//
// Deta
//

import Foundation
import Network

extension Environment {
    init(projectKey: String, base: String) {
        let baseUrl = "https://database.deta.sh/v1"
        let projectId = projectKey.split(separator: "_")[0]
        let pathPrefix = "/\(projectId)/\(base)/"
        
        self.init(host: baseUrl, pathPrefix: pathPrefix)
    }
}

