//
//  Error+ext.swift
//  PickerUpper MessagesExtension
//
//  Created by William Vabrinskas on 9/29/21.
//

import Foundation

extension Error {
  func print() {
    Swift.print(self.localizedDescription)
  }
}
