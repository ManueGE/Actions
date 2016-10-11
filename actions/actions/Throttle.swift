//
//  Throttle.swift
//  actions
//
//  Created by Manuel García-Estañ on 11/10/16.
//  Copyright © 2016 manuege. All rights reserved.
//

import Foundation

internal protocol ThrottleType {
    func schedueleWith(value: Any)
    func cancel()
    func fireWith(value: Any)
}

public final class Throttle<T>: NSObject {
    
    public typealias Handler = (T) -> Void
    
    private let interval: TimeInterval
    private let handler: Handler
    
    private var timer: Timer?
    
    public init(interval: TimeInterval, handler: @escaping Handler) {
        self.interval = interval
        self.handler = handler
    }
    
    public func scheduele(with value: T) {
        cancel()
        timer = Timer.scheduledTimer(timeInterval: interval,
                                     target: self,
                                     selector: #selector(Throttle.onTimer),
                                     userInfo: value,
                                     repeats: false)
    }
    
    public func cancel() {
        timer?.invalidate()
        timer = nil
    }
    
    public func fire(with value: T) {
        handler(value)
    }
    
    @objc private func onTimer(_ timer: Timer) {
        fire(with: timer.userInfo as! T)
    }
}

extension Throttle: ThrottleType {
    func schedueleWith(value: Any) {
        guard let value = value as? T else {
            return
        }
        
        scheduele(with: value)
    }
    
    func fireWith(value: Any) {
        guard let value = value as? T else {
            return
        }
        
        fire(with: value)
    }
}
