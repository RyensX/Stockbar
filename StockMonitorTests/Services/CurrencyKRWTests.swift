import XCTest
@testable import Stockbar

final class CurrencyKRWTests: XCTestCase {

    private func rates() -> ExchangeRates {
        var r = ExchangeRates()
        r.usdToCny = 7.28
        r.usdToHkd = 7.78
        r.usdToKrw = 1380.0
        return r
    }

    func test_default_usdToKrw_isFallback() {
        let r = ExchangeRates()
        XCTAssertEqual(r.usdToKrw, 1380.0, accuracy: 0.0001)
    }

    func test_convert_krw_to_cny() {
        let r = rates()
        let cny = r.convert(1_000_000, from: .krStock, to: .cny)
        XCTAssertEqual(cny, 1_000_000.0 / 1380.0 * 7.28, accuracy: 0.01)
    }

    func test_convert_krw_to_usd() {
        let r = rates()
        let usd = r.convert(1_380_000, from: .krStock, to: .usd)
        XCTAssertEqual(usd, 1000.0, accuracy: 0.001)
    }

    func test_convert_krw_to_hkd() {
        let r = rates()
        let hkd = r.convert(1_380_000, from: .krStock, to: .hkd)
        XCTAssertEqual(hkd, 1000.0 * 7.78, accuracy: 0.01)
    }

    func test_convert_krw_to_krw_identity() {
        let r = rates()
        XCTAssertEqual(r.convert(123_456, from: .krStock, to: .krw), 123_456.0, accuracy: 0.001)
    }

    func test_convert_cny_to_krw() {
        let r = rates()
        let krw = r.convert(728.0, from: .aStock, to: .krw)
        XCTAssertEqual(krw, 138_000.0, accuracy: 0.1)
    }

    func test_convert_usd_to_krw() {
        let r = rates()
        let krw = r.convert(100.0, from: .usStock, to: .krw)
        XCTAssertEqual(krw, 138_000.0, accuracy: 0.1)
    }

    func test_convert_hkd_to_krw() {
        let r = rates()
        let krw = r.convert(778.0, from: .hkStock, to: .krw)
        XCTAssertEqual(krw, 138_000.0, accuracy: 0.5)
    }
}
