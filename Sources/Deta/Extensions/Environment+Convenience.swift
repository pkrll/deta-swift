//
// Deta
//

import Foundation
import Network

extension Environment {
    init(projectKey: String, base: String) {
        let host = "database.deta.sh"
        let projectId = projectKey.split(separator: "_")[0]
        let pathPrefix = "/v1/\(projectId)/\(base)/"
        let headers = ["X-API-KEY": projectKey]
        
        self.init(host: host, pathPrefix: pathPrefix, headers: headers)
    }
}

