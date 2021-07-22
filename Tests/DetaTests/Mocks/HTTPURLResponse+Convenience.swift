//
// Deta
//

import Foundation

extension HTTPURLResponse {
    static var success: HTTPURLResponse? {
        HTTPURLResponse(url: URL(string: "https://github.com")!,
                        statusCode: 200,
                        httpVersion: nil,
                        headerFields: nil)
    }
    
    static var failure: HTTPURLResponse? {
        HTTPURLResponse(url: URL(string: "https://github.com")!,
                        statusCode: 400,
                        httpVersion: nil,
                        headerFields: nil)
    }
}
