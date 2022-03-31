//
// Deta
//

import Foundation

public enum HttpStatus: Int {
    
    //
    // MARK: - Informational - 1xx
    //
    
    /// Indicates that everything so far is OK and that the client should continue the request, or ignore the response
    /// if the request is already finished.
    case `continue` = 100
    /// Sent in response to an `Upgrade` request header from the client, and indicates the protocol the server is
    /// switching to.
    case switchingProtocols = 101
    /// Indicates that the server has received and is processing the request, but no response is available yet.
    case processing = 102
    /// Primarily intended to be used with the `Link` header, letting the user agent start preloading resources while
    /// the server prepares a response.
    case earlyHints = 103
    
    //
    // MARK: - Success - 2xx
    //
    
    /// Indicates that the The request has succeeded.
    ///
    /// - Note: The meaning of the success depends on the ``http`` method:
    ///     - ``GET``: The resource has been fetched and is transmitted in the message body.
    ///     - ``HEAD``: The representation headers are included in the response without any message body.
    ///     - ``PUT`` or ``POST``: The resource describing the result of the action is transmitted in the message body.
    ///     - ``TRACE``: The message body contains the request message as received by the server.
    case ok = 200
    /// The request has succeeded and a new resource has been created as a result. This is typically the response sent
    /// after POST requests, or some PUT requests.
    case created = 201
    /// The request has been received but not yet acted upon.
    case accepted = 202
    /// The server is a transforming proxy (e.g. a Web accelerator) that received a 200 OK from its origin, but is
    /// returning a modified version of the origin's response.
    case nonAuthoritativeInformation = 203
    /// The server successfully processed the request and is not returning any content.
    case noContent = 204
    /// The server successfully processed the request, and indicates that the user-agent should reset the document
    /// which sent this request.
    case resetContent = 205
    /// This response code is used when the ``Range`` header is sent from the client to request only part of a resource.
    case partialContent = 206
    /// Conveys information about multiple resources, for situations where multiple status codes might be appropriate.
    /// - Note: This is a WebDAV extension status code.
    case multiStatus = 207
    /// The members of a DAV binding have already been enumerated in a previous reply to this request, and are not being
    /// included again.
    /// - Note: This is a WebDAV extension status code.
    case alreadyReported = 208
    /// The server has fulfilled a GET request for the resource, and the response is a representation of the result of
    /// one or more instance-manipulations applied to the current instance.
    /// - Note: This is a WebDAV extension status code.
    case IMUsed = 226
    
    //
    // MARK: - Redirection - 3xx
    //
    
    /// Indicates multiple options for the resource from which the client may choose.
    case multipleChoices = 300
    /// The URL of the requested resource has been changed permanently. The new URL is given in the response.
    case movedPermanently = 301
    /// The URI of requested resource has been changed temporarily. Further changes in the URI might be made in the
    /// future. Therefore, this same URI should be used by the client in future requests.
    case found = 302
    /// The response to the request can be found under another URI using a GET method.
    case seeOther = 303
    /// Indicates that the resource has not been modified since the version specified by the request headers
    /// If-Modified-Since or If-None-Match.
    case notModified = 304
    /// The requested resource is available only through a proxy, the address for which is provided in the response.
    case useProxy = 305
    /// No longer used. Originally meant "Subsequent requests should use the specified proxy.
    case switchProxy = 306
    /// The request should be repeated with another URI.
    case temporaryRedirect = 307
    /// The request and all future requests should be repeated using another URI.
    case permenantRedirect = 308
    
    //
    // MARK: - Client Error - 4xx
    //
    
    /// The server cannot or will not process the request due to an apparent client error.
    case badRequest = 400
    /// Similar to 403 Forbidden, but specifically for use when authentication is required and has failed or has not
    /// yet been provided.
    case unauthorized = 401
    /// The content available on the server requires payment.
    ///
    /// - Note: This response code is reserved for future use. The initial aim for creating this code was using it
    ///         for digital payment systems, however this status code is used very rarely and no standard convention
    ///         exists.
    case paymentRequired = 402
    /// The request was a valid request, but the server is refusing to respond to it. Unlike 401, the client's identity
    /// is known to the server.
    case forbidden = 403
    /// The requested resource could not be found but may be available in the future.
    ///
    /// - Note: In an API, this can also mean that the endpoint is valid but the resource itself does not exist. Servers
    ///         may also send this response instead of 403 to hide the existence of a resource from an unauthorized client.
    case notFound = 404
    /// A request method is not supported for the requested resource. e.g. a GET request on a form which requires data to
    /// be presented via POST
    case methodNotAllowed = 405
    /// The requested resource is capable of generating only content not acceptable according to the Accept headers sent
    /// in the request.
    case notAcceptable = 406
    /// The client must first authenticate itself with the proxy.
    case proxyAuthenticationRequired = 407
    /// The server timed out waiting for the request.
    case requestTimeout = 408
    /// Indicates that the request could not be processed because of conflict in the request, such as an edit conflict
    /// between multiple simultaneous updates.
    case conflict = 409
    /// Indicates that the resource requested is no longer available and will not be available again.
    case gone = 410
    /// The request did not specify the length of its content, which is required by the requested resource.
    case lengthRequired = 411
    /// The server does not meet one of the preconditions that the requester put on the request.
    case preconditionFailed = 412
    /// The request is larger than the server is willing or able to process.
    case payloadTooLarge = 413
    /// The URI provided was too long for the server to process.
    case URITooLong = 414
    /// The request entity has a media type which the server or resource does not support.
    case unsupportedMediaType = 415
    /// The client has asked for a portion of the file (byte serving), but the server cannot supply that portion.
    case rangeNotSatisfiable = 416
    /// The server cannot meet the requirements of the Expect request-header field.
    case expectationFailed = 417
    /// This HTTP status is used as an Easter egg in some websites.
    case teapot = 418
    /// The request was directed at a server that is not able to produce a response.
    case misdirectedRequest = 421
    /// The request was well-formed but was unable to be followed due to semantic errors.
    case unprocessableEntity = 422
    /// The resource that is being accessed is locked.
    case locked = 423
    /// The request failed due to failure of a previous request (e.g., a PROPPATCH).
    case failedDependency = 424
    /// The client should switch to a different protocol such as TLS/1.0, given in the Upgrade header field.
    case upgradeRequired = 426
    /// The origin server requires the request to be conditional.
    case preconditionRequired = 428
    /// The user has sent too many requests in a given amount of time.
    case tooManyRequests = 429
    /// The server is unwilling to process the request because either an individual header field, or all the header
    /// fields collectively, are too large.
    case requestHeaderFieldsTooLarge = 431
    /// Used to indicate that the server has returned no information to the client and closed the connection.
    case noResponse = 444
    /// A server operator has received a legal demand to deny access to a resource or to a set of resources that
    /// includes the requested resource.
    case unavailableForLegalReasons = 451
    /// An expansion of the 400 Bad Request response code, used when the client has provided an invalid client certificate.
    case SSLCertificateError = 495
    /// An expansion of the 400 Bad Request response code, used when a client certificate is required but not provided.
    case SSLCertificateRequired = 496
    /// -An expansion of the 400 Bad Request response code, used when the client has made a HTTP request to a port
    /// listening for HTTPS requests.
    case HTTPRequestSentToHTTPSPort = 497
    /// Used when the client has closed the request before the server could send a response.
    case clientClosedRequest = 499
    
    //
    // MARK: - Server Error - 5xx
    //
    
    /// A generic error message, given when an unexpected condition was encountered and no more specific message is suitable.
    case internalServerError = 500
    /// The server either does not recognize the request method, or it lacks the ability to fulfill the request.
    case notImplemented = 501
    /// The server was acting as a gateway or proxy and received an invalid response from the upstream server.
    case badGateway = 502
    /// The server is currently unavailable (because it is overloaded or down for maintenance). Generally, this is a
    /// temporary state.
    case serviceUnavailable = 503
    /// The server was acting as a gateway or proxy and did not receive a timely response from the upstream server.
    case gatewayTimeout = 504
    /// The server does not support the HTTP protocol version used in the request.
    case HTTPVersionNotSupported = 505
    /// Transparent content negotiation for the request results in a circular reference.
    case variantAlsoNegotiates = 506
    /// The server is unable to store the representation needed to complete the request.
    case insufficientStorage = 507
    /// The server detected an infinite loop while processing the request.
    case loopDetected = 508
    /// Further extensions to the request are required for the server to fulfill it.
    case notExtended = 510
    /// The client needs to authenticate to gain network access.
    case networkAuthenticationRequired = 511
    
    case unknown = 0
    
    var isSuccess: Bool { (200...299) ~= self.rawValue }
    
    init(_ rawValue: Int) {
        if let status = Self(rawValue: rawValue) {
            self = status
        } else {
            self = .unknown
        }
    }
}
