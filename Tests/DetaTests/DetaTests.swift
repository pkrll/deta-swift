import XCTest
import Network
@testable import Deta

final class DetaTests: XCTestCase {
    
    private var deta: Deta!
    
    func testDeleteSuccess() {
        let expectation = XCTestExpectation(description: "Delete")
        
        InjectedValue[\.httpResult] = HttpResult(request: Request(.get),
                                                 data: nil,
                                                 response: HTTPURLResponse.success,
                                                 error: nil)
        
        deta.delete(key: "SomeKey") { result in
            switch result {
            case .failure(let error):
                XCTFail("Expected success. Got error: \(error.localizedDescription)")
            default:
                break
            }
            
            expectation.fulfill()
        }
        
        wait(for: [expectation], timeout: 10)
    }
    
    func testDeleteFailure() {
        let expectation = XCTestExpectation(description: "Delete")
        
        InjectedValue[\.httpResult] = HttpResult(request: Request(.get),
                                                 data: nil,
                                                 response: HTTPURLResponse.failure,
                                                 error: URLError(.userAuthenticationRequired))
        
        deta.delete(key: "SomeKey") { result in
            switch result {
            case .success:
                XCTFail("Expected error.")
            default:
                break
            }
            
            expectation.fulfill()
        }
        
        wait(for: [expectation], timeout: 10)
    }
    
    func testGetSuccess() {
        let expectation = XCTestExpectation(description: "Delete")
        let item = MockItem(key: "SomeKey", title: "SomeTitle", subtitle: nil)
        
        InjectedValue[\.httpResult] = HttpResult(request: Request(.get),
                                                 data: item.convert(),
                                                 response: HTTPURLResponse.success,
                                                 error: nil)
        
        deta.get(key: "hello", for: MockItem.self) { result in
            switch result {
            case .failure(let error):
                XCTFail("Expected MockItem. Got error: \(error.localizedDescription)")
            case .success(let response):
                XCTAssertEqual(item.key, response.key)
                XCTAssertEqual(item.title, response.title)
                XCTAssertEqual(item.subtitle, response.subtitle)
            }
            
            expectation.fulfill()
        }
        
        wait(for: [expectation], timeout: 10)
    }
    
    func testGetFailure() {
        let expectation = XCTestExpectation(description: "Delete")
        
        InjectedValue[\.httpResult] = HttpResult(request: Request(.get),
                                                 data: nil,
                                                 response: HTTPURLResponse.success,
                                                 error: nil)
        
        deta.get(key: "hello", for: MockItem.self) { result in
            switch result {
            case .failure(let error):
                guard let error = error as? DetaError else {
                    fallthrough
                }
                
                XCTAssertEqual(error.errors, DetaError.missingData.errors)
            default:
                XCTFail("Expected DetaError.")
            }
            
            expectation.fulfill()
        }
        
        wait(for: [expectation], timeout: 10)
    }
    
    override func setUp() {
        InjectedValue[\.operationBuilder] = MockOperationBuilder()
        deta = Deta(projectKey: "123_123", base: "test")
    }
}
