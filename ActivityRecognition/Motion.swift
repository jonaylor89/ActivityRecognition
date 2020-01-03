//
//  Motion.swift
//  ActivityRecognition
//
//  Created by John Naylor on 1/3/20.
//  Copyright © 2020 John Naylor. All rights reserved.
//

import Foundation
import CoreMotion

extension CMMotionActivity {
    var name: String {
        if walking { return "Walking" }
        if running { return "Running" }
        if automotive { return "Driving" }
        if cycling { return "Cycling" }
        if stationary { return "Stationary" }
        return "Unknown"
    }
}

extension CMMotionActivityManager {
    enum Error: Swift.Error {
        case notAvailable, notAuthorized
        
        public var localizedDescription: String {
            switch self {
            case .notAvailable: return "Activity Tracking not available"
            case .notAuthorized: return "Activity Tracking not permitted"
            }
        }
    }
    
    func startTracking(handler: @escaping (CMMotionActivity?) -> Void) throws {
        if !CMMotionActivityManager.isActivityAvailable() {
            throw Error.notAvailable
        }
        
        if CMMotionActivityManager.authorizationStatus() != .authorized {
            throw Error.notAuthorized
        }
        
        self.startActivityUpdates(to: .main, withHandler: handler)
    }
    
    func stopTracking() {
        self.stopActivityUpdates()
    }
}



