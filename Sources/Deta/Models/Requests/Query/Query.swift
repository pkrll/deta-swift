//
// Deta
//

import Foundation

public struct Query {

    let field: String
    let value: AnyEncodableContainer
    
    public init(_ field: String, equals value: AnyEncodable) {
        self.field = field
        self.value = AnyEncodableContainer(value)
    }
    
    public init(_ field: String, doesNotEqual value: AnyEncodable) {
        self.field = "\(field)?ne"
        self.value = AnyEncodableContainer(value)
    }
    
    public init(_ field: String, isLessThan value: AnyEncodable) {
        self.field = "\(field)?lt"
        self.value = AnyEncodableContainer(value)
    }
    
    public init(_ field: String, isLessThanOrEqualsTo value: AnyEncodable) {
        self.field = "\(field)?lte"
        self.value = AnyEncodableContainer(value)
    }
    
    public init(_ field: String, isGreaterThan value: AnyEncodable) {
        self.field = "\(field)?gt"
        self.value = AnyEncodableContainer(value)
    }
    
    public init(_ field: String, isGreaterThanOrEqualsTo value: AnyEncodable) {
        self.field = "\(field)?gte"
        self.value = AnyEncodableContainer(value)
    }
    
    public init(_ field: String, hasPrefix value: AnyEncodable) {
        self.field = "\(field)?pfx"
        self.value = AnyEncodableContainer(value)
    }
    
    public init(_ field: String, isBetween range: ClosedRange<Int>) {
        self.field = "\(field)?r"
        self.value = [range.lowerBound, range.upperBound]
    }
    
    public init(_ field: String, isBetween range: ClosedRange<Double>) {
        self.field = "\(field)?r"
        self.value = [range.lowerBound, range.upperBound]
    }
    
    public init(_ field: String, contains value: String) {
        self.field = "\(field)?contains"
        self.value = AnyEncodableContainer(value)
    }
    
    public init(_ field: String, doesNotContain value: String) {
        self.field = "\(field)?not_contains"
        self.value = AnyEncodableContainer(value)
    }
}
