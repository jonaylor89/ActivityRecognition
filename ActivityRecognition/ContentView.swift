//
//  ContentView.swift
//  ActivityRecognition
//
//  Created by John Naylor on 1/3/20.
//  Copyright © 2020 John Naylor. All rights reserved.
//

import SwiftUI
import AVFoundation

struct ContentView: View {
    
    @EnvironmentObject var tracker: ActivityTracker
    private let speechSynthesiser = AVSpeechSynthesizer()
    
    var body: some View {
        let newActivity = tracker.currentActivity
        
        if tracker.activityDidChange {
            print(newActivity)
            // speechSynthesiser.say(newActivity)
        }
        
        return Text(newActivity).font(.largeTitle)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

extension AVSpeechSynthesizer {
    func say(_ text: String) {
        self.speak(AVSpeechUtterance(string: text))
    }
}
