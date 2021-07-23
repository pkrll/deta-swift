//
// Deta
//

import Foundation
import NetworkStack
@testable import Deta

final class MockOperator: Operator {

    @Injected(\.httpResult) var result: HttpResult
    
    init() {
        super.init(next: nil)
    }
    
    override func load(_ task: Task) {
        task.complete(with: result)
    }
    
}
