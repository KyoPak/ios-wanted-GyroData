//
//  SensorData+CoreDataProperties.swift
//  GyroData
//
//  Created by 이정민 on 2023/01/31.
//
//

import Foundation
import CoreData


extension SensorData {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<SensorData> {
        return NSFetchRequest<SensorData>(entityName: "SensorData")
    }

    @NSManaged public var date: Date
    @NSManaged public var runTime: Double
    @NSManaged public var type: Int16
    @NSManaged public var xValue: [Double]
    @NSManaged public var yValue: [Double]
    @NSManaged public var zValue: [Double]

}

extension SensorData : Identifiable {

}
