//
//  Reveri_TestTests.swift
//  Reveri-TestTests
//
//  Created by Andy Pye on 06/02/2023.
//

import XCTest
@testable import ShoppingCart

final class Reveri_TestTests: XCTestCase {

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    // test view model
    func testViewModel() throws {
        let viewModel: Reveri_TestTests.MockProductViewModel = Reveri_TestTests.MockProductViewModel()
        let expectation = XCTestExpectation(description: "Get products")
        viewModel.getProducts { result in
            switch result {
            case .success(let products):
                XCTAssertNotNil(products)
                expectation.fulfill()
            case .failure(let error):
                XCTFail(error.localizedDescription)
            }
        }
        wait(for: [expectation], timeout: 5.0)
    }

    // mock view model
    func testMockViewModel() throws {
        let viewModel: Reveri_TestTests.MockProductViewModel = MockProductViewModel()
        let expectation = XCTestExpectation(description: "Get products")
        viewModel.getProducts { result in
            switch result {
            case .success(let products):
                XCTAssertNotNil(products)
                expectation.fulfill()
            case .failure(let error):
                XCTFail(error.localizedDescription)
            }
        }
        wait(for: [expectation], timeout: 5.0)
    }

    // MockProductViewModel mock view model
    class MockProductViewModel: ProductViewModel {
        override func getProducts(completion: @escaping (Result<[Product], Error>) -> Void) {
            let product = Product(id: 1, name: "Test", price: 1.0, description: "Test", image: "Test")
            completion(.success([product]))
        }
    }

    // Async test
    func testAsync() async throws {
        let viewModel = ProductViewModel()
        let products = try await viewModel.getProducts()
        XCTAssertNotNil(products)
    }

    // Async mock
    func testMockAsync() async throws {
        let viewModel: Reveri_TestTests.MockProductViewModel = MockProductViewModel()
        let products = try await viewModel.getProducts()
        XCTAssertNotNil(products)
    }
    

}
