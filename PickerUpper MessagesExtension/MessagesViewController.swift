//
//  MessagesViewController.swift
//  PickerUpper MessagesExtension
//
//  Created by William Vabrinskas on 9/28/21.
//

import UIKit
import Messages
import Combine

protocol PhraseHandler: AnyObject {
  var phraseCancellables: Set<AnyCancellable> { get set }
  var state: StateCoordinator { get }
  func subscribeToPhrase()
  func getPhrase()
  func gotPhrase(_ phrase: Phrase?)
}

extension PhraseHandler {
  
  var state: StateCoordinator { .shared }
  
  func subscribeToPhrase() {
    self.state.subscribe(type: .phrase)
      .sink { [weak self] newPhrase in
        self?.gotPhrase(newPhrase)
      }
      .store(in: &self.phraseCancellables)
  }
  
  func getPhrase() {
    self.state.getPhrase()
  }
}

class MessagesViewController: MSMessagesAppViewController, PhraseHandler {
  var phraseCancellables: Set<AnyCancellable> = []
  private var phraseLabel: UILabel?
  private let buttonHeight: CGFloat = 65
  private let buttonCornerRadius: CGFloat = 16
  
  // MARK: - Phrase Handler
  func gotPhrase(_ phrase: Phrase?) {
    //update text
    self.phraseLabel?.text = phrase?.text
  }
  
  override func viewDidLoad() {
    super.viewDidLoad()
    // Do any additional setup after loading the view
    self.subscribeToPhrase()
    self.setupUI()
  }
  
  // MARK: - Text
  
  @objc func insert() {
    guard let conversation = activeConversation,
          let label = self.phraseLabel else {
      return
    }
    
    let text = label.text ?? PhraseModule.defaultMessage
    
    conversation.insertText(text) { error in
      error?.print()
    }
  }
  
  // MARK: - Actions
  @objc private func phraseButtonTapped() {
    if self.phraseLabel?.textColor == .systemGray {
      self.phraseLabel?.textColor = .white
    }
    self.getPhrase()
  }
  
  // MARK: - UI
  private func setupUI() {
    self.setLabel()
    
    guard let phraseLabel = phraseLabel else {
      return
    }
    
    let phraseButton = self.getPhraseButton()
    let goButton = self.insertTextButton()
    
    let stackView = UIStackView(frame: .zero)
    
    self.view.addSubview(stackView)

    stackView.addArrangedSubview(phraseButton)
    stackView.addArrangedSubview(goButton)
    stackView.distribution = .equalSpacing
    stackView.axis = .horizontal
    stackView.spacing = 30

    stackView.translatesAutoresizingMaskIntoConstraints = false
    stackView.topAnchor.constraint(equalTo: phraseLabel.bottomAnchor, constant: 16).isActive = true
    stackView.widthAnchor.constraint(equalToConstant: (buttonHeight * 2) + stackView.spacing).isActive = true
    stackView.heightAnchor.constraint(equalToConstant: buttonHeight).isActive = true
    stackView.centerXAnchor.constraint(equalTo: self.view.centerXAnchor).isActive = true

  }
  
  private func setLabel() {
    let label = UILabel(frame: .zero)
    label.translatesAutoresizingMaskIntoConstraints = false
    
    self.view.addSubview(label)
    
    label.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 16).isActive = true
    label.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: -16).isActive = true
    label.topAnchor.constraint(equalTo: self.view.topAnchor, constant: 16).isActive = true
    label.heightAnchor.constraint(equalToConstant: 80).isActive = true
    
    label.font = UIFont.boldSystemFont(ofSize: 22)
    label.backgroundColor = .clear
    label.numberOfLines = 3
    label.textAlignment = .center
    label.text = "Got game? Don't need to. Press the bed to get your phrase."
    label.textColor = .systemGray
    
    self.phraseLabel = label
  }
  
  private func insertTextButton() -> RoundedButtonView {
    
    let model = RoundedButtonViewModel(cornerRadius: self.buttonCornerRadius,
                                       backgroundColor: .systemGreen,
                                       textColor: .white,
                                       height: buttonHeight,
                                       icon: "paperplane.fill")
    
    let button = RoundedButtonView(viewModel: model)
    button.addTarget(self, action: #selector(self.insert), for: .touchUpInside)
    return button
  }

  private func getPhraseButton() -> RoundedButtonView {
    let model = RoundedButtonViewModel(cornerRadius: self.buttonCornerRadius,
                                       backgroundColor: .systemPurple,
                                       textColor: .white,
                                       height: buttonHeight,
                                       icon: "bed.double.fill")
    
    let button = RoundedButtonView(viewModel: model)
    button.addTarget(self, action: #selector(self.phraseButtonTapped), for: .touchUpInside)
    return button
  }
}

