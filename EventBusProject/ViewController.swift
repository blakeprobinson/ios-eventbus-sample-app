//
//  ViewController.swift
//  EventBusProject
//
//  Created by Robinson, Blake on 8/19/20.
//  Copyright © 2020 Verizon Wireless. All rights reserved.
//

import UIKit
import EventBus

//Events
protocol StartProcess {
    func processDidStart()
}

protocol EventOne {
    func eventOneDidOccur()
}

protocol EndProcess {
    func processDidEnd()
}

class ViewController: UIViewController {
    
    private let eventBus = EventBus(options: [.allWarnings])
    
    @IBOutlet weak var eventTriggeredSegmentedControl: EventTriggeredSegmentedControl!
    @IBOutlet weak var startDelegateSwitch: StartDelegateSwitch!
    @IBOutlet weak var eventOneDelegateSwitch: EventOneDelegateSwitch!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        eventBus.register(forEvent: StartProcess.self)
        eventBus.register(forEvent: EventOne.self)
        eventBus.register(forEvent: EndProcess.self)
        eventBus.add(subscriber: eventTriggeredSegmentedControl, for: StartProcess.self)
        eventBus.add(subscriber: eventTriggeredSegmentedControl, for: EventOne.self)
        eventBus.add(subscriber: eventTriggeredSegmentedControl, for: EndProcess.self)
        eventBus.add(subscriber: startDelegateSwitch, for: StartProcess.self)
        eventBus.add(subscriber: eventOneDelegateSwitch, for: EventOne.self)
    }
    
    @IBAction func startProcessTapped(_ sender: UIButton) {
        eventBus.notify(StartProcess.self) { (subscriber) in
            subscriber.processDidStart()
        }
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
            self.eventBus.notify(EventOne.self) { subscriber in
                subscriber.eventOneDidOccur()
            }
        }
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
            self.eventBus.notify(EndProcess.self) { subscriber in
                subscriber.processDidEnd()
            }
        }
    }
    
    @IBAction func resetProcessTapped(_ sender: Any) {
        eventTriggeredSegmentedControl.selectedSegmentIndex = -1
        startDelegateSwitch.setOn(false, animated: true)
        eventOneDelegateSwitch.setOn(false, animated: true)
    }
}
