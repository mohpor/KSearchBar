//
//  Created by Mohammad Porooshani on Apr 10, 2021.
//  Copyright © 2021 Kubes. All rights reserved.
//

import Foundation
import SnapKit
import UIKit

private enum Constants {
  enum Sizes {
    static let defaultHeight: CGFloat = 56
  }
}

public class KSearchBar: UIView {
  
  public override init(frame: CGRect) {
    super.init(frame: frame)
    self.backgroundColor = barBackgroundColor
    if #available(iOS 13.0, *) {
      self.textColor = UIColor.label
    }
    prepareLayout()
  }
  
  @available(*, unavailable)
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  // MARK: Bar
  public var barBackgroundColor = UIColor.white {
    didSet {
      self.backgroundColor = barBackgroundColor
    }
  }
  
  // MARK: Field
  lazy var fieldBackgroundView: UIView = {
    let view = UIView()
    view.backgroundColor = fieldBackgroundColor
    view.layer.cornerRadius = fieldCornerRadius
    return view
  }()
  
  public var fieldBackgroundColor = UIColor(named: "fieldBack", in: Bundle.module, compatibleWith: nil) {
    didSet {
      self.fieldBackgroundView.backgroundColor = fieldBackgroundColor
    }
  }
  
  public var fieldCornerRadius: CGFloat = 9 {
    didSet {
      guard fieldCornerRadius != oldValue else {
        return
      }
      self.fieldBackgroundView.layer.cornerRadius = fieldCornerRadius
      self.layoutTextField()
    }
  }
  
  // MARK: TextField
  lazy var textField: UITextField = {
    let textField = UITextField(frame: .zero)
    
    textField.textColor = textColor
    if #available(iOS 13.0, *) {
      textField.clearButtonMode = .never
      textField.rightViewMode = .always
      let btn = UIButton(frame: .zero)
      btn.setImage(UIImage(systemName: "xmark.circle.fill"), for: [])
      btn.sizeToFit()
      btn.addTarget(self, action: #selector(self.clearSearch), for: .touchUpInside)
      textField.rightView = btn
    } else {
      textField.clearButtonMode = .always
    }
    return textField
  }()
  
  @objc
  private func clearSearch() {
    self.textField.text = ""
  }
  
  public var textColor: UIColor = UIColor.black {
    didSet {
      self.textField.textColor = self.textColor
      
    }
  }
  
  // MARK: Layouting
  func prepareLayout() {
    layoutFieldBack()
    layoutTextField()
  }
  
  func layoutFieldBack() {
    self.insertSubview(self.fieldBackgroundView, at: 0)
    self.fieldBackgroundView.snp.makeConstraints { make in
      make.leading.equalToSuperview().offset(8)
      make.trailing.equalToSuperview().offset(-8)
      make.height.equalTo(36)
      make.centerY.equalToSuperview()
    }
  }
    
  func layoutTextField() {
    self.textField.removeFromSuperview()
    self.fieldBackgroundView.addSubview(self.textField)
    self.textField.snp.makeConstraints { make in
      make.centerY.equalToSuperview()
      make.leading.equalToSuperview().offset(self.fieldCornerRadius/2 + 2)
      make.trailing.equalToSuperview().offset(-(self.fieldCornerRadius/2 + 2))
    }
  }
  
}
