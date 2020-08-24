//
//  EventOneDelegateSwitch.swift
//  EventBusProject
//
//  Created by Robinson, Blake on 8/20/20.
//  Copyright © 2020 Verizon Wireless. All rights reserved.
//

import UIKit

class EventOneDelegateSwitch: UISwitch, EventOne {
    func eventOneDidOccur() {
        print("EventOne delegate called")
        DispatchQueue.main.sync {
            setOn(true, animated: true)
        }
    }
}
