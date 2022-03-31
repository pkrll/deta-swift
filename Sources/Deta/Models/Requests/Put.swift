//
// Deta
//

import Foundation

public struct Put {
    
    struct Request<Item: DetaModel>: Encodable {
        let items: [Item]
    }
    /// The response of the `put(items:_)` method.
    public struct Response<Item: DetaModel>: Decodable {
        public struct Processed: Decodable {
            public let items: [Item]
        }
        
        public struct Failed: Decodable {
            public let items: [Item]
        }
        /// Items that were successfully stored.
        public let processed: Processed?
        /// Items that failed due to internal processing.
        public let failed: Failed?
    }
}
