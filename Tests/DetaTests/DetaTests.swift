import XCTest
import Network
@testable import Deta

final class DetaTests: XCTestCase {
    
    private var deta: Deta!
    
    func testDeleteWithSuccess() {
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
    
    func testDeleteWithFailure() {
        let expectation = XCTestExpectation(description: "Delete")
        
        InjectedValue[\.httpResult] = HttpResult(request: Request(.get),
                                                 data: nil,
                                                 response: HTTPURLResponse.badRequest,
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
    
    func testGetWithSuccess() {
        let expectation = XCTestExpectation(description: "Delete")
        let expectedItem = MockItem(key: "SomeKey", title: "SomeTitle", subtitle: nil)
        
        InjectedValue[\.httpResult] = HttpResult(request: Request(.get),
                                                 data: expectedItem.convert(),
                                                 response: HTTPURLResponse.success,
                                                 error: nil)
        
        deta.get(key: "Somekey", for: MockItem.self) { result in
            switch result {
            case .failure(let error):
                XCTFail("Expected MockItem. Got error: \(error.localizedDescription)")
            case .success(let response):
                XCTAssertEqual(expectedItem, response)
            }
            
            expectation.fulfill()
        }
        
        wait(for: [expectation], timeout: 10)
    }
    
    func testGetWithKeyNotFound() {
        let expectation = XCTestExpectation(description: "Delete")
        let item = MockItem(key: "SomeKey", title: "SomeTitle", subtitle: nil)
        let expectedItem = PartialItem(key: "SomeKey")
        
        InjectedValue[\.httpResult] = HttpResult(request: Request(.get),
                                                 data: item.convert(),
                                                 response: HTTPURLResponse.notFound,
                                                 error: nil)
        
        deta.get(key: "hello", for: MockItem.self) { result in
            switch result {
            case .failure(let receivedItem):
                guard let receivedItem = receivedItem as? PartialItem else {
                    fallthrough
                }
                
                XCTAssertEqual(receivedItem.key, expectedItem.key)
            default:
                XCTFail("Expected DetaError.")
            }
            
            expectation.fulfill()
        }
        
        wait(for: [expectation], timeout: 10)
    }
    
    func testInsertWithSuccess() {
        let expectation = XCTestExpectation(description: "Insert")
        let item = MockItem(key: "SomeKey", title: "Some Title", subtitle: "Some subtitle")
        
        InjectedValue[\.httpResult] = HttpResult(request: Request(.get),
                                                 data: item.convert(),
                                                 response: HTTPURLResponse.success,
                                                 error: nil)

        deta.insert(item) { result in
            switch result {
            case .success(let receivedItem):
                XCTAssertEqual(item, receivedItem)
            case .failure:
                XCTFail("Expected success.")
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
