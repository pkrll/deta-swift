//
// Deta
//

import Foundation

public struct GroupedQueries {
    let queries: [String: AnyEncodableContainer]
    
    public init(_ queries: Query...) {
        self.queries = queries.reduce(into: [:]) { result, query in
            result[query.field] = query.value
        }
    }
    
    public init(_ queries: [Query]) {
        self.queries = queries.reduce(into: [:]) { result, query in
            result[query.field] = query.value
        }
    }
    
    public init(@QueryBuilder queries: () -> [Query]) {
        self.init(queries())
    }
}
