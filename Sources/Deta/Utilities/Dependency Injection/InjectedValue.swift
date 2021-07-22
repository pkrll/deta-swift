//
// Deta
//

import Foundation

struct InjectedValue {
    private static var current = InjectedValue()
    
    static subscript<Key: InjectionKey>(key: Key.Type) -> Key.Value {
        get { key.value }
        set { key.value = newValue }
    }
    
    static subscript<T>(_ keyPath: WritableKeyPath<InjectedValue, T>) -> T {
        get { current[keyPath: keyPath] }
        set { current[keyPath: keyPath] = newValue }
    }
}
