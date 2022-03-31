//
// Deta
//

import Foundation

@resultBuilder
public struct QueryBuilder {
    public static func buildBlock(_ components: Query) -> [Query] {
        [components]
    }
    
    public static func buildBlock(_ components: Query...) -> [Query] {
        components
    }
}

@resultBuilder
public struct GroupingQueryBuilder {    
    public static func buildBlock(_ components: Query...) -> [GroupedQueries] {
        [GroupedQueries(components)]
    }
    
    public static func buildBlock(_ components: GroupedQueries...) -> [GroupedQueries] {
        components
    }
}
