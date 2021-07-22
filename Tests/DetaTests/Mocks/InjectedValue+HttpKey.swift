//
// Deta
//

import Foundation
import Network
@testable import Deta

extension InjectedValue {
    var httpResult: HttpResult {
        get { Self[HttpResultKey.self] }
        set { Self[HttpResultKey.self] = newValue }
    }
}

private struct HttpResultKey: InjectionKey {
    static var value: HttpResult = HttpResult(request: Request(.get), data: nil, response: nil, error: nil)
}
