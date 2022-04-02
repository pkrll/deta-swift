//
// Deta
//

import Foundation
#if canImport(FoundationNetworking)
import FoundationNetworking
#endif

protocol Transporting {
    func data(for request: URLRequest) async throws -> (Data, URLResponse)
}
