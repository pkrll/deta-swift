//
//  Deta
//

import Foundation

public struct Fetch {
    /// The request model for the Fetch function.
    public struct Request: Encodable {

        public let query: [[String: AnyEncodable]]
        public let limit: Int?
        public let last: String?
        
        public init(query: [[String: AnyEncodable]] = [], limit: Int? = nil, last: String? = nil) {
            self.query = query
            self.limit = limit
            self.last = last
        }
    }
    
    public struct Response<Item: ItemModel>: Decodable {
        public struct Paging: Decodable {
            /// Number of items returned
            public let size: Int
            /// The last key seen, if paginated.
            /// - Note: This key should be provided in the following request.
            public let last: String?
        }
        
        public let paging: Paging
        public let items: [Item]
    }
}
