//
//  ContentView.swift
//  IF Timer WatchKit Extension
//
//  Created by Will C on 9/27/20.
//

import SwiftUI

struct ContentView: View {
    @State var countdownToDate: Date?
    @State var interval: TimeInterval?
    @State var hours: Int = 14
    
    let hourRange = 12...16
    
    let formatter = DateComponentsFormatter()
    init () {
        formatter.unitsStyle = .positional
        formatter.includesApproximationPhrase = false
        formatter.includesTimeRemainingPhrase = false
        formatter.allowedUnits = [.hour,.minute,.second]
    }
    
    var timer = Timer.publish(every: 1, on: .main, in: .common).autoconnect()
    
    var body: some View {
        if let unwrappedDate = countdownToDate {
            VStack {
                Text(formatter.string(from: interval ?? 0) ?? "starting")
                    .onReceive(timer) { input in
                        self.interval = unwrappedDate.timeIntervalSince(Date())
                    }
                Button(action: {
                    self.countdownToDate = nil
                    self.interval = nil
                }) {
                    Text("Stop")
                }
            }
        } else {
            VStack {
                // TODO: This text will be replaced by some sort of input element, maybe a picker?
                // The user will be able to pick a number of hours
                Text("Begin timer for \(self.hours) hours")
                // Clicking start will begin a countdown timer for a number of hours
                Button(action: {
                    let hoursFromNow: TimeInterval = 60.0*60.0*Double(self.hours)
                    self.countdownToDate = Date(timeInterval: hoursFromNow, since: Date())
                }) {
                    Text("Start")
                }
            }
        }
        
    }
    
    struct ContentView_Previews: PreviewProvider {
        static var previews: some View {
            ContentView()
        }
    }
}
