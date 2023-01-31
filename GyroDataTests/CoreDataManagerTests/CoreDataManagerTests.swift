//
//  CoreDataManagerTests.swift
//  GyroDataTests
//
//  Created by Kyo, JPush on 2023/01/31.
//

import XCTest

final class CoreDataManagerTests: XCTestCase {
    var coreDataManager: CoreDataManagerMock?
    
    override func setUpWithError() throws {
        coreDataManager = CoreDataManagerMock()
    }

    func test_save_success() {
        // given
        let measureData = MeasureDataDummy.dummys[0]
        
        // then
        XCTAssertNoThrow(try coreDataManager?.save(measureData))
    }
    
    func test_fetch_success() {
        // then
        XCTAssertNoThrow(try coreDataManager?.fetch(offset: 0, limit: 1))
    }
    
    func test_delete_failure_by_nowDate() {
        // then
        XCTAssertThrowsError(try coreDataManager?.delete(Date()))
    }
}
