//
// Deta
//

import Foundation

public struct DetaError: Error, Decodable {
    
    static let missingData: Self = Self(errors: ["Missing data"])
    
    public let errors: [String]
}
