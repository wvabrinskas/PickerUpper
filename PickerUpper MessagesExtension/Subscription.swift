//
//  Subscription.swift
//  PickerUpper MessagesExtension
//
//  Created by William Vabrinskas on 9/28/21.
//

import Foundation
import Combine

public protocol Subscription {
  associatedtype TModule: Module
  var module: TModule { get }
  
  func obj<TType>() -> TType?
  func publisher<TType>() -> Published<TType?>.Publisher
}

public extension Subscription {
  func obj<TType>() -> TType? {
    return self.module.object as? TType
  }
  
  func publisher<TType>() -> Published<TType?>.Publisher {
    let randomObj: TType? = nil
    var pub = Published.init(initialValue: randomObj)
    let obj = self.module
    return obj.objectPublisher as? Published<TType?>.Publisher ?? pub.projectedValue
  }
}


