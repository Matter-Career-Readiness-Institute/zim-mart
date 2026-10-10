import XCTest
@testable import ZimCart

@MainActor
final class ShopStoreTests: XCTestCase {
    func testCartSubtotalUsesUnitPriceTimesQuantity() {
        let store = ShopStore()
        let rice = SeedData.products.first { $0.id == "rice" }!
        store.add(rice, quantity: 2)
        XCTAssertEqual(store.itemSubtotal, 9.00, accuracy: 0.001)
    }

    func testDeliveryFeeIsThreeDollars() {
        XCTAssertEqual(ShopStore().deliveryFee, 3.00, accuracy: 0.001)
    }

    func testAddingExistingProductUpdatesItsLine() {
        let store = ShopStore()
        let rice = SeedData.products.first { $0.id == "rice" }!
        store.add(rice)
        store.add(rice)
        XCTAssertEqual(store.cart.count, 1)
        XCTAssertEqual(store.cart.first?.quantity, 2)
    }

    func testSearchTrimsWhitespaceAndCategoryIncludesMatches() {
        let spacedSearch = CatalogFilter.products(searchText: "  rice  ", category: nil)
        XCTAssertTrue(spacedSearch.contains { $0.id == "rice" })
        let food = CatalogFilter.products(searchText: "", category: .food)
        XCTAssertFalse(food.isEmpty)
        XCTAssertTrue(food.allSatisfy { $0.category == .food })
    }

    func testCartQuantityCannotExceedStock() {
        let store = ShopStore()
        let seed = SeedData.products.first { $0.id == "tea" }!
        let oneInStock = Product(id: "limited", name: seed.name, description: seed.description, category: seed.category, price: seed.price, stock: 1, symbol: seed.symbol, rating: seed.rating)
        store.add(oneInStock)
        store.increase(store.cart[0])
        XCTAssertEqual(store.cart[0].quantity, 1)
    }

    func testOrderTotalIncludesDeliveryFee() {
        let store = ShopStore()
        let rice = SeedData.products.first { $0.id == "rice" }!
        store.add(rice)
        let customer = Customer(fullName: "Test Customer", phone: "0771234567", address: "1 Main Street", city: "Harare")
        XCTAssertTrue(store.placeOrder(customer: customer, delivery: .delivery, payment: .ecoCash))
        XCTAssertEqual(store.orders[0].total, store.orders[0].itemSubtotal + 3.00, accuracy: 0.001)
    }

    func testFailedOrderPreservesCartForRetry() {
        let store = ShopStore()
        let rice = SeedData.products.first { $0.id == "rice" }!
        store.add(rice)
        let customer = Customer(fullName: "Test Customer", phone: "0771234569", address: "1 Main Street", city: "Harare")
        XCTAssertFalse(store.placeOrder(customer: customer, delivery: .delivery, payment: .ecoCash))
        XCTAssertEqual(store.cart.count, 1)
    }
}
