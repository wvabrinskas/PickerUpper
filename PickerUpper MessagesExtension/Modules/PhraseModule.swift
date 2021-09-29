//
//  PhraseModule.swift
//  PickerUpper MessagesExtension
//
//  Created by William Vabrinskas on 9/28/21.
//

import Foundation
import Combine

class PhraseModule: Module {
  typealias ObjectType = Phrase
  
  static let defaultMessage = "Sup honey wanna get a drink"
  
  @Published var object: Phrase?
  var objectPublisher: Published<Phrase?>.Publisher { $object }
  
  public func getPhrase() {
    //build a new phrase
    let randomI = Int.random(in: 0..<PhraseDB.phrases.count)
    let p = PhraseDB.phrases[randomI]
    
    self.object = Phrase(text: p)
  }
}
