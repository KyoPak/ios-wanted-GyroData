//
//  MeasureDataDummy.swift
//  GyroDataTests
//
//  Created by 이정민 on 2023/01/31.
//

import Foundation

struct MeasureDataDummy {
    static var dummys: [MeasureData] = [
        MeasureData(
            xValue: [15.2, 16.1, 23.4, 12.8],
            yValue: [25.4, 40.1, 70.3, 55.5],
            zValue: [45.1, 68.0, 73.3, 102.9],
            runTime: 60,
            date: Date(),
            type: .accelerometer
        )
    ]
}
