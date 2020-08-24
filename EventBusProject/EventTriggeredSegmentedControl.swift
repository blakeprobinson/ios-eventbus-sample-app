//
//  EventTriggeredIndicator.swift
//  EventBusProject
//
//  Created by Robinson, Blake on 8/20/20.
//  Copyright © 2020 Verizon Wireless. All rights reserved.
//
import UIKit


class EventTriggeredSegmentedControl: UISegmentedControl, StartProcess, EventOne, EndProcess {
    
    func processDidStart() {
        print("processDidStart called")
        DispatchQueue.main.sync {
            selectedSegmentIndex = 0
        }
    }
    
    func eventOneDidOccur() {
        print("eventOneDidOccur called")
        DispatchQueue.main.sync {
            selectedSegmentIndex = 1
        }
    }
    
    func processDidEnd() {
        print("processDidEnd called")
        DispatchQueue.main.sync {
            selectedSegmentIndex = 2
        }
    }
}
