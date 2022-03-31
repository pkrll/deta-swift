//
// Deta
//

import Foundation
#if canImport(FoundationNetworking)
import FoundationNetworking
#endif

public final class Deta {    
    
    private let configuration: Configuration
    private let session: URLSession
    
    public convenience init(with configuration: Configuration) {
        self.init(configuration: configuration, session: .shared)
    }
    
    init(configuration: Configuration, session: URLSession) {
        self.configuration = configuration
        self.session = session
    }
}
