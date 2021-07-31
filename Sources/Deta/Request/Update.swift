//
// Deta
//

import Foundation

public enum Update {
    /// The payload for the `update(key:payload:_)` method.
    public struct Request: Encodable {
        let set: [String: AnyEncodable]
        let increment: [String: AnyEncodable]
        let append: [String: [AnyEncodable]]
        let prepend: [String: [AnyEncodable]]
        let delete: [String]
        /// The payload for the `update(key:payload:_)` method.
        ///
        /// Use this data structure to define what to change when updating an item.
        ///
        /// - Parameter set:        The attributes to be updated or created.
        /// - Parameter increment:  The attributes to be incremented. Increment value can be negative.
        /// - Parameter append:     The attributes to append a value to. Appended value must be a list.
        /// - Parameter prepend:    The attributes to prepend a value to. Prepended value must be a list.
        /// - Parameter delete:     The attributes to be deleted.
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
    /// The response of the `update(key:payload:_)` method.
    public struct Response: Decodable {
        /// The attributes that were updated or created.
        public let set: [String: AnyDecodable]?
        /// The attributes that were incremented
        public let increment: [String: AnyDecodable]?
        /// The attributes that were appended to.
        public let append: [String: [AnyDecodable]]?
        /// The attributes that were prepended to.
        public let prepend: [String: [AnyDecodable]]?
        /// The attributes that were deleted.
        public let delete: [String]?
    }    
}
