//
// Deta
//

import XCTest
@testable import Deta

final class DetaTests: XCTestCase {

    private var transport: TransportMock!
    private var deta: Deta!

    func testDeleteWithSuccess() async throws {
        transport.data = Data()
        transport.response = .success
        try await deta.delete(key: "12345")
    }

    func testDeleteWithFailure() async throws {
        transport.data = Data()
        transport.response = .badRequest
        
        do {
            try await deta.delete(key: "12345")
        } catch Error.badRequest {
            XCTAssert(true)
        } catch {
            XCTFail("Unexpected error: \(error)")
        }
    }

    func testGetWithSuccess() async throws {
        let key = "SomeKey"
        let expectedItem = MockItem(key: key, title: "SomeTitle", subtitle: nil)
        transport.data = expectedItem.convert()
        transport.response = .success

        let item = try await deta.get(model: MockItem.self, key: key)
        XCTAssertEqual(item, expectedItem)
    }

    func testGetWithErrorNotFound() async throws {
        let key = "SomeKey"
        let expectedItem = MockItem(key: key, title: "SomeTitle", subtitle: nil)
        transport.data = expectedItem.convert()
        transport.response = .notFound

        do {
            let _ = try await deta.get(model: MockItem.self, key: key)
        } catch Error.httpStatus(let code) where code == 404 {
            XCTAssert(true)
        } catch {
            XCTFail("Unexpected error: \(error)")
        }
    }

    func testInsertWithSuccess() async throws {
        let expectedItem = MockItem(key: "SomeKey", title: "SomeTitle", subtitle: nil)
        transport.data = expectedItem.convert()
        transport.response = .success

        let item = try await deta.insert(item: expectedItem)
        XCTAssertEqual(item, expectedItem)
    }

    func testInsertWithErrorConflict() async throws {
        let expectedItem = MockItem(key: "SomeKey", title: "SomeTitle", subtitle: nil)
        transport.data = expectedItem.convert()
        transport.response = .conflict

        do {
            let _ = try await deta.insert(item: expectedItem)
        } catch Error.httpStatus(let code) where code == 409 {
            XCTAssert(true)
        } catch {
            XCTFail("Unexpected error: \(error)")
        }
    }

    func testPutWithSuccess() async throws {
        let items = MockItem.items(from: ["1234", "5678", "91011"])
        let response = Put.Response<MockItem>(items: items)
        transport.data = response.convert()
        transport.response = .success

        let _ = try await deta.put(items: items)
    }

    func testPutWithFailure() async throws {
        let items = MockItem.items(from: ["1234", "5678", "91011"])
        transport.data = Data()
        transport.response = .badRequest

        do {
            let _ = try await deta.put(items: items)
        } catch Error.badRequest {
            XCTAssert(true)
        } catch {
            XCTFail("Unexpected error: \(error)")
        }
    }

    override func setUp() {
        let configuration = Configuration(projectKey: "Deta_Test", baseName: "DetaBase")
        transport = TransportMock()
        deta = Deta(configuration: configuration, transport: transport)
    }
}