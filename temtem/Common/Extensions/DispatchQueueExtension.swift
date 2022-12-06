//
//  DispatchQueueExtension.swift
//  temtem
//
//  Created by Marlon Ansale on 11/15/22.
//

import Foundation

public var queueInteractive: DispatchQueue {
    DispatchQueue(label: "com.temtem.interactive",qos: .userInteractive, target: .main)
}

public var queueBackgroundInitiated: DispatchQueue {
    DispatchQueue(label: "com.temtem.initialize.background",qos: .userInitiated, target: .global())
}
public var queueInitiated: DispatchQueue {
    DispatchQueue(label: "com.temtem.initialize",qos: .userInitiated,target: .main)
}
