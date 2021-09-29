//
//  StateCoordinator.swift
//  PickerUpper MessagesExtension
//
//  Created by William Vabrinskas on 9/28/21.
//

import Foundation
import Combine

class StateCoordinator {
  public static let shared = StateCoordinator()
  
  private let phrase = PhraseSubscription()

  enum SubscriptionType {
    case phrase
  }
  
  public func object<TType>(type: SubscriptionType) -> TType? {
    switch type {
    case .phrase:
      return self.phrase.obj()
    }
  }
  
  public func subscribe<TType>(type: SubscriptionType) -> Published<TType?>.Publisher {
    switch type {
    case .phrase:
      return self.phrase.publisher()
    }
  }
}

// MARK: Phrase
extension StateCoordinator {
  
  func getPhrase() {
    self.phrase.module.getPhrase()
  }
  
}
