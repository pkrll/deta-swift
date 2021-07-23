//
// Deta
//

import Foundation
import NetworkStack

final class MockOperationBuilder: OperationBuilder {
    override func append(_ operation: Operation) -> Self {
        guard case .transport = operation else {
            _ = super.append(operation)
            
            return self
        }
        
        return append(operator: MockOperator())
    }
}
