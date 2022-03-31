//
// Deta
//

import Foundation

public struct AnyEncodable: Encodable {
    public let value: Any
    
    public init<T>(_ value: T?) {
        self.value = value ?? ()
    }
}
