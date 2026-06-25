import XCTest
@testable import Stockbar

final class AppSettingsTests: XCTestCase {

    func test_chinese_upIsRed() {
        var s = AppSettings()
        s.colorScheme = .chinese
        XCTAssertEqual(s.upColorName,   "upRed")
        XCTAssertEqual(s.downColorName, "downGreen")
    }

    func test_western_upIsGreen() {
        var s = AppSettings()
        s.colorScheme = .western
        XCTAssertEqual(s.upColorName,   "upGreen")
        XCTAssertEqual(s.downColorName, "downRed")
    }

    func test_validRefreshIntervals() {
        for interval in AppSettings.validRefreshIntervals {
            var s = AppSettings()
            s.refreshInterval = interval
            XCTAssertEqual(s.refreshInterval, interval)
        }
    }

    func test_statusBarIconMode_defaultIsAppIcon() {
        XCTAssertEqual(AppSettings().statusBarIconMode, .appIcon)
    }

    func test_statusBarIconMode_allCases() {
        XCTAssertEqual(StatusBarIconMode.allCases.count, 3)
        XCTAssertTrue(StatusBarIconMode.allCases.contains(.appIcon))
        XCTAssertTrue(StatusBarIconMode.allCases.contains(.stockInitial))
        XCTAssertTrue(StatusBarIconMode.allCases.contains(.hidden))
    }

    func test_decodeLegacySettings_defaultsStatusBarIconModeToAppIcon() throws {
        let data = #"{"statusBarStockId":"sh600000"}"#.data(using: .utf8)!
        let s = try JSONDecoder().decode(AppSettings.self, from: data)
        XCTAssertEqual(s.statusBarStockId, "sh600000")
        XCTAssertEqual(s.statusBarIconMode, .appIcon)
    }

    func test_doNotDisturb_defaultsDisabledWithAfternoonToNextMorningRange() {
        let s = AppSettings()
        XCTAssertFalse(s.doNotDisturbEnabled)
        XCTAssertEqual(s.doNotDisturbStartMinutes, 15 * 60)
        XCTAssertEqual(s.doNotDisturbEndMinutes, 9 * 60 + 30)
    }

    func test_decodeLegacySettings_defaultsDoNotDisturbDisabled() throws {
        let data = #"{"statusBarStockId":"sh600000"}"#.data(using: .utf8)!
        let s = try JSONDecoder().decode(AppSettings.self, from: data)
        XCTAssertFalse(s.doNotDisturbEnabled)
        XCTAssertEqual(s.doNotDisturbStartMinutes, 15 * 60)
        XCTAssertEqual(s.doNotDisturbEndMinutes, 9 * 60 + 30)
    }

    func test_colorTheme_allCases() {
        XCTAssertEqual(ColorTheme.allCases.count, 2)
        XCTAssertTrue(ColorTheme.allCases.contains(.chinese))
        XCTAssertTrue(ColorTheme.allCases.contains(.western))
    }
}
