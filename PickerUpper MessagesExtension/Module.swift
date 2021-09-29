//
//  Module.swift
//  PickerUpper MessagesExtension
//
//  Created by William Vabrinskas on 9/28/21.
//

import Foundation
import Combine

public protocol Module: ObservableObject {
  associatedtype ObjectType
  //Should be @Published in implementation, no way to do this yet in a protocol
  var object: ObjectType? { get set }
  var objectPublisher: Published<ObjectType?>.Publisher { get }
}
