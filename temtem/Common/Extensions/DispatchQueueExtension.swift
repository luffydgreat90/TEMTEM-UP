//
//  DispatchQueueExtension.swift
//  temtem
//
//  Created by Marlon Ansale on 11/15/22.
//

import Foundation


var queueInteractive: DispatchQueue {
    DispatchQueue(label: "com.temtem.data",qos: .userInteractive, target: .main)
}

var queueInitiated: DispatchQueue {
    DispatchQueue(label: "com.temtem.initialize",qos: .userInitiated,target: .main)
}
