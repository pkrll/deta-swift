//
// Deta
//

import Foundation
#if canImport(FoundationNetworking)
import FoundationNetworking
#endif

//
// Deta
//

extension HTTPURLResponse {
    static var success: HTTPURLResponse? {
        HTTPURLResponse(url: URL(string: "https://github.com")!,
                        statusCode: 200,
                        httpVersion: nil,
                        headerFields: nil)
    }
    
    static var created: HTTPURLResponse? {
        HTTPURLResponse(url: URL(string: "https://github.com")!,
                        statusCode: 201,
                        httpVersion: nil,
                        headerFields: nil)
    }

    static var badRequest: HTTPURLResponse? {
        HTTPURLResponse(url: URL(string: "https://github.com")!,
                        statusCode: 400,
                        httpVersion: nil,
                        headerFields: nil)
    }
    
    static var notFound: HTTPURLResponse? {
        HTTPURLResponse(url: URL(string: "https://github.com")!,
                        statusCode: 404,
                        httpVersion: nil,
                        headerFields: nil)
    }

    static var conflict: HTTPURLResponse? {
        HTTPURLResponse(url: URL(string: "https://github.com")!,
                        statusCode: 409,
                        httpVersion: nil,
                        headerFields: nil)
    }
}