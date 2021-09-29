//
//  RoundedButtonView.swift
//  PickerUpper MessagesExtension
//
//  Created by William Vabrinskas on 9/28/21.
//

import Foundation
import UIKit

class RoundedButtonView: UIButton {
  private var viewModel: RoundedButtonViewModel
  
  init(viewModel: RoundedButtonViewModel) {
    self.viewModel = viewModel
    super.init(frame: .zero)
    self.translatesAutoresizingMaskIntoConstraints = false
    self.setupUI()
  }
  
  required init?(coder: NSCoder) {
    let model = RoundedButtonViewModel(cornerRadius: 20,
                                       backgroundColor: .systemGray,
                                       textColor: .white,
                                       height: 30,
                                       icon: "gear")
    self.viewModel = model
    super.init(frame: .zero)
    setupUI()
  }
  
  private func setupUI() {
    self.translatesAutoresizingMaskIntoConstraints = false
        
    self.titleLabel?.font = UIFont.boldSystemFont(ofSize: 26)
    self.titleLabel?.textColor = viewModel.textColor
    self.backgroundColor = viewModel.backgroundColor
    self.tintColor = .white

    self.clipsToBounds = true
    let image = UIImage(systemName: viewModel.icon)
    self.setImage(image, for: .normal)
    self.imageView?.contentMode = .scaleAspectFit

    self.contentVerticalAlignment = .fill
    self.contentHorizontalAlignment = .fill
    self.imageEdgeInsets = UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)

    self.layer.cornerCurve = .continuous
    self.layer.cornerRadius = viewModel.cornerRadius
  
    self.widthAnchor.constraint(equalToConstant: viewModel.height).isActive = true
  }
}
