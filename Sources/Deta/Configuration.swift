//
// Deta
//

import Foundation

public struct Configuration {
    
    private static let baseUrl = "detabase.deta.sh/v1"

    let projectKey: String
    let baseName: String
    let projectId: String
    let baseUrl: String

    public init(projectKey: String, baseName: String) {
        let projectId = String(projectKey.split(separator: "_")[0])
        self.projectKey = projectKey
        self.baseName = baseName
        self.projectId = projectId
        self.baseUrl = "\(Self.baseUrl)/\(projectId)/\(baseName)/"
    }
}
