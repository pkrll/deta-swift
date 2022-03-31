//
// Deta
//

import Foundation

public struct Configuration {
    
    private static let baseUrl = "database.deta.sh"

    let projectKey: String
    let baseName: String
    let projectId: String
    let baseUrl: String
    let pathPrefix: String

    public init(projectKey: String, baseName: String) {
        let projectId = String(projectKey.split(separator: "_")[0])
        self.projectKey = projectKey
        self.baseName = baseName
        self.projectId = projectId
        self.baseUrl = Self.baseUrl
        self.pathPrefix = "/v1/\(projectId)/\(baseName)"
    }
}
