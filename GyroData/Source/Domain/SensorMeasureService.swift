//
//  SensorMeasureService.swift
//  GyroData
//
//  Created by Kyo, JPush on 2023/02/01.
//

import CoreMotion
import Foundation

protocol MeasureDelegate: AnyObject {
    typealias Values = (x: Double, y: Double, z: Double)
    
    func nonAccelerometerMeasurable()
    func nonGyroscopeMeasurable()
    
    func updateData(_ data: [Values])
    func endMeasuringData()
}

final class SensorMeasureService {
    typealias Values = (x: Double, y: Double, z: Double)
    
    private var data: [Values] = [] {
        didSet {
            delegate?.updateData(data)
        }
    }
    
    private weak var delegate: MeasureDelegate?
    private var timer: Timer = .init()
    private let motionManager: CMMotionManager
    
    init(delegate: MeasureDelegate) {
        self.delegate = delegate
        self.motionManager = .init()
    }
    
    func measureStart(_ sensorType: Sensor, interval: TimeInterval, duration: TimeInterval) {
        data = .init()
        
        switch sensorType {
        case .accelerometer:
            accelerometerMeasureStart(interval, duration)
        case .gyroscope:
            gyroscopeMeasureStart(interval, duration)
        }
    }
    
    func measureStop() {
        timer.invalidate()
        delegate?.endMeasuringData()
    }
}

private extension SensorMeasureService {
    func accelerometerMeasureStart(_ interval: TimeInterval, _ duration: TimeInterval) {
        guard motionManager.isAccelerometerAvailable else {
            delegate?.nonAccelerometerMeasurable()
            return
        }
        
        motionManager.accelerometerUpdateInterval = interval
        motionManager.startAccelerometerUpdates()
        
        timer = Timer(fire: Date(), interval: interval / duration, repeats: true) { timer in
            if let data = self.motionManager.accelerometerData {
                let accelerationData = (data.acceleration.x, data.acceleration.y, data.acceleration.z)
                
                self.data.append(accelerationData)
            }
            
            if self.isTimeOver(duration, from: timer.fireDate) {
                timer.invalidate()
            }
        }
        
        RunLoop.current.add(timer, forMode: .common)
    }
    
    func isTimeOver(_ duration: TimeInterval, from fireDate: Date) -> Bool {
        Date().timeIntervalSince(fireDate) > duration ? true : false
    }
    
    func gyroscopeMeasureStart(_ interval: TimeInterval, _ duration: TimeInterval) {
        guard motionManager.isGyroAvailable else {
            delegate?.nonGyroscopeMeasurable()
            return
        }
        
        motionManager.gyroUpdateInterval = interval
        motionManager.startGyroUpdates()
        
        timer = Timer(fire: Date(), interval: interval / duration, repeats: true) { timer in
            if let data = self.motionManager.gyroData {
                let gyroData = (data.rotationRate.x, data.rotationRate.y, data.rotationRate.z)
                
                self.data.append(gyroData)
            }
            
            if self.isTimeOver(duration, from: timer.fireDate) {
                timer.invalidate()
            }
        }
        
        RunLoop.current.add(timer, forMode: .common)
    }
}