import XCTest
import Network
@testable import Deta

final class DetaTests: XCTestCase {
    
    private var deta: Deta!
    
    func testDeleteWithSuccess() {
        let expectation = XCTestExpectation(description: "Delete")
        
        setResponse(.success, data: nil, error: nil)
        
        deta.delete(key: "SomeKey") { result in
            switch result {
            case .failure(let error):
                XCTFail("Expected success. Got error: \(error.code)")
            default:
                break
            }
            
            expectation.fulfill()
        }
        
        wait(for: [expectation], timeout: 10)
    }
    
    func testDeleteWithFailure() {
        let expectation = XCTestExpectation(description: "Delete")
        
        setResponse(.badRequest, data: nil, error: URLError(.unknown))
        
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
    
    func testFetchWithFailure() {
        let expectation = XCTestExpectation(description: "Fetch")
        
        setResponse(.badRequest, data: nil, error: nil)
        
        deta.fetch(model: MockItem.self) { result in
            switch result {
            case .failure(let error):
                XCTAssertEqual(error.code, .badRequest)
            case .success:
                XCTFail("Expected error.")
            }
            
            expectation.fulfill()
        }
        
        wait(for: [expectation], timeout: 10)
    }
    
    func testFetchWithSuccess() {
        let expectation = XCTestExpectation(description: "Fetch")
        let expectedResponse = Fetch.Response<MockItem>(
            paging: .init(size: 10, last: nil),
            items: MockItem.items(from: (0..<10).map(String.init))
        )
        
        setResponse(.success, data: expectedResponse.convert(), error: nil)
        
        deta.fetch(model: MockItem.self) { result in
            switch result {
            case .failure:
                XCTFail("Expected response.")
            case .success(let response):
                XCTAssertEqual(response, expectedResponse)
            }
            
            expectation.fulfill()
        }
        
        wait(for: [expectation], timeout: 10)
    }
    
    func testGetWithSuccess() {
        let expectation = XCTestExpectation(description: "Delete")
        let expectedItem = MockItem(key: "SomeKey", title: "SomeTitle", subtitle: nil)
        
        setResponse(.success, data: expectedItem.convert(), error: nil)
        
        deta.get(key: "Somekey", for: MockItem.self) { result in
            switch result {
            case .failure(let error):
                XCTFail("Expected MockItem. Got error: \(error.code)")
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
        
        setResponse(.notFound, data: item.convert(), error: nil)
        
        deta.get(key: "hello", for: MockItem.self) { result in
            switch result {
            case .failure(let error):
                XCTAssertEqual(error.code, .keyNotFound)
            default:
                XCTFail("Expected Error.")
            }
            
            expectation.fulfill()
        }
        
        wait(for: [expectation], timeout: 10)
    }
    
    func testInsertWithSuccess() {
        let expectation = XCTestExpectation(description: "Insert")
        let item = MockItem(key: "SomeKey", title: "Some Title", subtitle: "Some subtitle")
        
        setResponse(.created, data: item.convert(), error: nil)

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
    
    func testPutWithFailure() {
        let expectation = XCTestExpectation(description: "Put")
        let item = MockItem(key: "SomeKey", title: "Some Title", subtitle: "Some subtitle")
        
        setResponse(.badRequest, data: item.convert(), error: nil)

        deta.put(items: [item]) { result in
            switch result {
            case .failure(let error):
                XCTAssertEqual(error.code, .badRequest)
            case .success:
                XCTFail("Expected failure.")
            }
            
            expectation.fulfill()
        }
        
        wait(for: [expectation], timeout: 10)
    }

    override func setUp() {
        InjectedValue[\.operationBuilder] = MockOperationBuilder()
        deta = Deta(projectKey: "123_123", base: "test")
    }
    
    private func setResponse(_ response: HTTPURLResponse?, data: Data? = nil, error: Swift.Error? = nil) {
        InjectedValue[\.httpResult] = HttpResult(request: Request(.get), data: data, response: response, error: error)
    }
}
