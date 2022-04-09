import Foundation

@resultBuilder
public struct QueryBuilder {
    public static func buildBlock(_ components: Query) -> [Query] {
        [components]
    }

    public static func buildBlock(_ components: Query...) -> [Query] {
        components
    }
    
    public static func buildBlock(_ components: [Query]...) -> [Query] {
        components.flatMap { $0 }
    }

    public static func buildBlock(_ components: [Query]) -> [Query] {
        components
    }
    
    public static func buildEither(first component: [Query]) -> [Query] {
        component
    }
    
    public static func buildEither(second component: [Query]) -> [Query] {
        component
    }

    public static func buildExpression(_ expression: ()) -> [Query] {
        []
    }
    
    public static func buildExpression(_ expression: Query) -> [Query] {
        [expression]
    }
    
    public static func buildOptional(_ component: [Query]?) -> [Query] {
        component ?? []
    }
    
    public static func buildBlock(_ components: [Query?]) -> [Query] {
        components.compactMap { $0 }
    }
    
    public static func buildExpression(_ expression: Query?) -> [Query] {
        guard let expression = expression else {
            return []
        }
        
        return [expression]
    }
    
    public static func buildExpression(_ expression: [Query]?) -> [Query] {
        expression ?? []
    }
}

@resultBuilder
public struct GroupingQueryBuilder {
    public static func buildBlock(_ components: GroupedQueries) -> [GroupedQueries] {
        [components]
    }

    public static func buildBlock(_ components: GroupedQueries...) -> [GroupedQueries] {
        components
    }
    
    public static func buildBlock(_ components: [GroupedQueries]...) -> [GroupedQueries] {
        components.flatMap { $0 }
    }

    public static func buildBlock(_ components: [GroupedQueries]) -> [GroupedQueries] {
        components
    }
    
    public static func buildEither(first component: [GroupedQueries]) -> [GroupedQueries] {
        component
    }
    
    public static func buildEither(second component: [GroupedQueries]) -> [GroupedQueries] {
        component
    }

    public static func buildExpression(_ expression: ()) -> [GroupedQueries] {
        []
    }
    
    public static func buildExpression(_ expression: GroupedQueries) -> [GroupedQueries] {
        [expression]
    }
    
    public static func buildOptional(_ component: [GroupedQueries]?) -> [GroupedQueries] {
        component ?? []
    }
    
    public static func buildBlock(_ components: [GroupedQueries?]) -> [GroupedQueries] {
        components.compactMap { $0 }
    }
    
    public static func buildExpression(_ expression: GroupedQueries?) -> [GroupedQueries] {
        guard let expression = expression else {
            return []
        }
        
        return [expression]
    }
    
    public static func buildExpression(_ expression: [GroupedQueries]?) -> [GroupedQueries] {
        expression ?? []
    }
    
    public static func buildBlock(_ components: Query) -> [GroupedQueries] {
        [GroupedQueries([components])]
    }
}
