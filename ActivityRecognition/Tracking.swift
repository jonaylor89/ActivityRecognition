//
//  Tracking.swift
//  ActivityRecognition
//
//  Created by John Naylor on 1/3/20.
//  Copyright © 2020 John Naylor. All rights reserved.
//

import Foundation
import SwiftUI
import Combine
import CoreMotion

final class ActivityTracker : ObservableObject {
    
    let willChange = PassthroughSubject<ActivityTracker, Never>()
    
    private let tracker = CMMotionActivityManager()
    private(set) var currentActivity: String = "None detectable" {
        willSet {
            activityDidChange = (newValue != currentActivity)
        }
        
        didSet {
            willChange.send(self)
        }
    }
    
    private(set) var activityDidChange = true
    
    init() {}
    
    func startTracking() {
        do {
            try tracker.startTracking { result in
                self.currentActivity = result?.name ?? "None detectable"
            }
        } catch {
            print("Error: \(error.localizedDescription)")
            stopTracking()
        }
    }
    
    func stopTracking() {
        currentActivity = "Not Tracking"
        tracker.stopTracking()
    }
}
