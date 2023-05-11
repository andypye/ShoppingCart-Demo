import XCTest
@testable import ShoppingCart

final class ShoppingCart_Tests: XCTestCase {

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    // test view model
    func testViewModel() throws {
        let viewModel: ShoppingCart_Tests.MockProductListingViewModel = ShoppingCart_Tests.MockProductListingViewModel()
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
        let viewModel: ShoppingCart_Tests.MockProductListingViewModel = MockProductListingViewModel()
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

    // MockProductListingViewModel mock view model
    class MockProductListingViewModel: ProductListingViewModel {
         func getProducts(completion: @escaping (Result<[Product], Error>) -> Void) {
             let product = ProductListingViewModel.previewFilledViewModel.products[0]
            completion(.success([product]))
        }
    }
    
}
