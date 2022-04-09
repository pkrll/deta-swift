//
// Deta
//

import Foundation

public struct Fetch {
    /// The request for the `fetch(model:query:_)` method.
    public struct Request: Encodable {
        
        enum CodingKeys: String, CodingKey {
            case query
            case limit
            case last
        }
        
        let query: [[String: AnyEncodableContainer]]
        let limit: Int?
        let last: String?
        /// The payload for the `update(key:payload:_)` method.
        ///
        /// - Parameter query:  A list of queries. See Deta documentation for more information on how to construct a query.
        /// - Parameter limit:  Number of items to fetch. If set, minimum value must be 1.
        /// - Parameter last:   The last key seen in a previous paginated response.
        public init(query: [[String: AnyEncodableContainer]] = [], limit: Int? = nil, last: String? = nil) {
            self.query = query
            self.limit = limit
            self.last = last
        }
    }
    /// The response of the `fetch(model:query:_)` method.
    public struct Response<Item: DetaModel>: Decodable {
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
