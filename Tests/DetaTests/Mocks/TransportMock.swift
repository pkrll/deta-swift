//
// Deta
//

import Foundation
#if canImport(FoundationNetworking)
import FoundationNetworking
#endif
@testable import Deta

final class TransportMock: Transporting {

    var data: Data!
    var response: HTTPURLResponse!

    func data(for request: URLRequest) async throws -> (Data, URLResponse) {
        (data, response)
    }
}