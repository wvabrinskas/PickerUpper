//
//  PhraseSubscription.swift
//  PickerUpper MessagesExtension
//
//  Created by William Vabrinskas on 9/28/21.
//

import Foundation


struct PhraseSubscription: Subscription {
  typealias TModule = PhraseModule
  var module: PhraseModule = PhraseModule()
}
