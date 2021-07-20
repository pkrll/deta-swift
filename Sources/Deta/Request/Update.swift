//
// Deta
//

import Foundation

public enum Update {
    public struct Request: Encodable {
        public let set: [String: AnyEncodable]
        public let increment: [String: AnyEncodable]
        public let append: [String: [AnyEncodable]]
        public let prepend: [String: [AnyEncodable]]
        public let delete: [String]
        
        public init(set: [String: AnyEncodable] = [:],
                    increment: [String: AnyEncodable] = [:],
                    append: [String: [AnyEncodable]] = [:],
                    prepend: [String: [AnyEncodable]] = [:],
                    delete: [String] = []) {
            self.set = set
            self.increment = increment
            self.append = append
            self.prepend = prepend
            self.delete = delete
        }
    }
    
    public struct Response: Decodable {
        public let set: [String: AnyDecodable]?
        public let increment: [String: AnyDecodable]?
        public let append: [String: [AnyDecodable]]?
        public let prepend: [String: [AnyDecodable]]?
        public let delete: [String]?
    }    
}
