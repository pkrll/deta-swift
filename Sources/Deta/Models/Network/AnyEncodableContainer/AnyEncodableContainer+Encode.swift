//
// Deta
//

import Foundation

extension AnyEncodableContainer {
    public func encode(to encoder: Encoder) throws {
        var container = encoder.singleValueContainer()
        
        switch value {
        case let value as Bool:
            try container.encode(value)
        case let value as Date:
            try container.encode(value)
        case let value as Double:
            try container.encode(value)
        case let value as Float:
            try container.encode(value)
        case let value as Int:
            try container.encode(value)
        case let value as Int8:
            try container.encode(value)
        case let value as Int16:
            try container.encode(value)
        case let value as Int32:
            try container.encode(value)
        case let value as Int64:
            try container.encode(value)
        case let value as String:
            try container.encode(value)
        case let value as UInt:
            try container.encode(value)
        case let value as UInt8:
            try container.encode(value)
        case let value as UInt16:
            try container.encode(value)
        case let value as UInt32:
            try container.encode(value)
        case let value as UInt64:
            try container.encode(value)
        case let value as [Any?]:
            try container.encode(value.map(AnyEncodableContainer.init))
        case let value as [String: Any?]:
            try container.encode(value.mapValues(AnyEncodableContainer.init))
        default:
            let context = EncodingError.Context(codingPath: container.codingPath, debugDescription: "Invalid type.")
            throw EncodingError.invalidValue(value, context)
        }
    }
}
