//
// Deta
//

import Foundation

public struct FetchResponse<Item: ItemModel>: Decodable {
    
    public struct Paging: Decodable {
        /// Number of items returned
        let size: Int
        /// The last key seen, if paginated.
        /// - Note: This key should be provided in the following request.
        let last: String?
    }
    
    let paging: Paging
    let items: [Item]
}
