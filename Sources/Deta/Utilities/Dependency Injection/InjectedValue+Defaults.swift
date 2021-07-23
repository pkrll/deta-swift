//
// Deta
//

import Foundation
import NetworkStack

extension InjectedValue {
    var operationBuilder: OperationBuilder {
        get { Self[OperationBuilderKey.self] }
        set { Self[OperationBuilderKey.self] = newValue }
    }
}

private struct OperationBuilderKey: InjectionKey {
    static var value: OperationBuilder = OperationBuilder()
}
