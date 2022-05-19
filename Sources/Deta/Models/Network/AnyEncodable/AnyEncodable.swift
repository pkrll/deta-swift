//
// Deta
//

import Foundation

public protocol AnyEncodable: Encodable {}

extension Int: AnyEncodable {}
extension Double: AnyEncodable {}
extension String: AnyEncodable {}
extension Array: AnyEncodable where Element: AnyEncodable {}
extension Dictionary: AnyEncodable where Key == String, Value: AnyEncodable {}
