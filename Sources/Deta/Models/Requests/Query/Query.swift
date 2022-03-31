//
// Deta
//

import Foundation

public struct GroupedQueries {
    let queries: [String: AnyEncodable]
    
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

public struct Query {

    let field: String
    let value: AnyEncodable
    
    private init(field: String, value: AnyEncodable) {
        self.field = field
        self.value = value
    }
    
    
    public init(_ field: String, equals value: AnyEncodable) {
        self.field = field
        self.value = value
    }
    
    public init(_ field: String, doesNotEqual value: AnyEncodable) {
        self.field = "\(field)?ne"
        self.value = value
    }
    
    public init(_ field: String, isLessThan value: AnyEncodable) {
        self.field = "\(field)?lt"
        self.value = value
    }
    
    public init(_ field: String, isLessThanOrEqualsTo value: AnyEncodable) {
        self.field = "\(field)?lte"
        self.value = value
    }
    
    public init(_ field: String, isGreaterThan value: AnyEncodable) {
        self.field = "\(field)?gt"
        self.value = value
    }
    
    public init(_ field: String, isGreaterThanOrEqualsTo value: AnyEncodable) {
        self.field = "\(field)?gte"
        self.value = value
    }
    
    public init(_ field: String, hasPrefix value: AnyEncodable) {
        self.field = "\(field)?pfx"
        self.value = value
    }
    
    public init(_ field: String, isBetween range: ClosedRange<Int>) {
        self.field = "\(field)?r"
        self.value = [range.lowerBound, range.upperBound]
    }
    
    public init(_ field: String, isBetween range: ClosedRange<Double>) {
        self.field = "\(field)?r"
        self.value = [range.lowerBound, range.upperBound]
    }
    
    public init(_ field: String, contains value: AnyEncodable) {
        self.field = "\(field)?contains"
        self.value = value
    }
    
    public init(_ field: String, doesNotContain value: AnyEncodable) {
        self.field = "\(field)?not_contains"
        self.value = value
    }
}
