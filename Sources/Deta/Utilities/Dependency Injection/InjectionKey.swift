//
// Deta
//

import Foundation

protocol InjectionKey {
    associatedtype Value
    static var value: Value { get set }
}
