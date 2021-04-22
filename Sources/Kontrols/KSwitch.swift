//
//  File.swift
//  
//
//  Created by Mohammad Porooshani on 4/22/21.
//

import SnapKit
import UIKit

public class KSwitch: UISwitch {
  
  public struct SwitchAppearance {
    public var borderColor: UIColor
    public var tintColor: UIColor
    public var thumbColor: UIColor
    
    public static let defaultOffSettings = SwitchAppearance(borderColor: UIColor.clear, tintColor: UIColor.Kontrols.veryLightBlue, thumbColor: UIColor.Kontrols.ceruleanBlue)
    public static let defaultOnSettings = SwitchAppearance(borderColor: .clear, tintColor: UIColor.Kontrols.ceruleanBlue, thumbColor: .white)
    public static let defaultDisabledSettings = SwitchAppearance(borderColor: .clear, tintColor: UIColor.Kontrols.veryLightPurple, thumbColor: UIColor.Kontrols.brownGrey)
    
  }
  
  enum State {
    case on
    case off
    case disabled
  }
  
  // MARK: Off State Visual Configs
  public var offAppearance = SwitchAppearance.defaultOffSettings {
    didSet {
      self.applyAppearances(animated: false)
    }
  }
  
  // MARK: On State Visual Configs
  public var onAppearance = SwitchAppearance.defaultOnSettings {
    didSet {
      self.applyAppearances(animated: false)
    }
  }
    
  // MARK: Disabled State Visual Configs
  public var disabledAppearance = SwitchAppearance.defaultDisabledSettings {
    didSet {
      self.applyAppearances(animated: false)
    }
  }
  
  // MARK: Shared VisualConfigs
  public var switchBorderWidth: CGFloat = 4 {
    didSet {
      updateThumbPosition(animated: false)
    }
  }
  
  public var insets: UIEdgeInsets = .zero
  public var switchAnimationDuration: TimeInterval = 0.25
  
  // MARK: Private accessor helpers
  
  private var currentState: State {
    self.isEnabled ? (isOn ? .on : .off ) : .disabled
  }
      
  private func appearance(for state: State? = nil) -> SwitchAppearance {
    let state = state ?? currentState
    
    switch state {
      case .on:
        return self.onAppearance
      case .off:
        return self.offAppearance
      case .disabled:
        return self.disabledAppearance
    }
  }
    
  // MARK: Initializers
  public override init(frame: CGRect) {
    super.init(frame: frame)
    prepareLayout()
  }
  
  @available(*, unavailable)
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  // MARK: Private stuff
  private func prepareLayout() {
    self.subviews.forEach { $0.isHidden = true }
    self.prepareElemets()
  }
  
  lazy var button: UIButton = {
    let btn = UIButton()
    btn.tag = 1234
    btn.addTarget(self, action: #selector(self.touched), for: .touchUpInside)
    return btn
  }()
  
  lazy var backdrop: UIView = {
    let view = UIView()
    view.clipsToBounds = true
    view.isUserInteractionEnabled = false
    return view
  }()
  
  lazy var thumb: UIView = {
    let view = UIView()
    view.clipsToBounds = true
    view.isUserInteractionEnabled = false
    return view
  }()
  
  private func prepareElemets() {
    self.addButton()
    self.addButtonBackdrop()
    self.addThumb()
    self.button.sendSubviewToBack(self.backdrop)
  }
  // MARK: Button
  private func addButton() {
    self.addSubview(self.button)
    self.button.snp.makeConstraints { make in
      make.edges.equalToSuperview().inset(self.insets)
    }
  }
  
  // MARK: Backdrop
  
  private var switchWidth: CGFloat {
    button.bounds.width - (insets.left + insets.right)
  }
  
  private var switchHeight: CGFloat {
    bounds.height - (insets.top + insets.bottom)
  }
  
  private func addButtonBackdrop() {
    self.button.addSubview(self.backdrop)
    self.backdrop.snp.makeConstraints { make in
      make.edges.equalToSuperview()
    }
    self.backdropApply(animated: false)
  }
  
  private func backdropApply(appearance: SwitchAppearance? = nil, animated: Bool = true) {
    let appearance = appearance ?? self.appearance()
    
    func apply() {
      backdrop.backgroundColor = appearance.tintColor
    }
    
    let layer = backdrop.layer
    
    layer.borderWidth = self.switchBorderWidth
    
    if animated {
      UIView.animate(withDuration: self.switchAnimationDuration) {
        apply()
      }
      let borderAnimation = CABasicAnimation(keyPath: "borderColor")
      borderAnimation.fromValue = layer.borderColor ?? UIColor.clear.cgColor
      borderAnimation.toValue = appearance.borderColor.cgColor
      borderAnimation.duration = self.switchAnimationDuration
      layer.borderColor = appearance.borderColor.cgColor
      layer.add(borderAnimation, forKey: "brdColor")
            
    } else {
      apply()
      layer.borderColor = appearance.borderColor.cgColor
    }
    
  }
  
  // MARK: Thumb
  private var thumbXPosition: CGFloat {
    isOn ? (switchWidth - ((switchBorderWidth) + (thumbSize))) : switchBorderWidth
  }
  
  private var thumbSize: CGFloat {
    switchHeight - (2 * switchBorderWidth)
  }
  
  private func addThumb() {
    self.button.addSubview(self.thumb)
    self.layoutThumb()
    self.thumbApply(animated: false)
    self.updateThumbPosition(animated: false)
  }
  
  lazy var thumbLeftAnchor = self.thumb.leftAnchor.constraint(equalTo: self.backdrop.leftAnchor, constant: thumbXPosition)
  
  private func layoutThumb() {
    self.thumb.snp.removeConstraints()
    thumbLeftAnchor.constant = thumbXPosition
    thumbLeftAnchor.isActive = true
    self.thumb.snp.makeConstraints { make in
      make.centerY.equalTo(self.backdrop)
      make.width.equalTo(thumbSize)
      make.height.equalTo(thumbSize)
    }
  }
  
  private func thumbApply(appearance: SwitchAppearance? = nil, animated: Bool = true) {
    func apply() {
      let appearance = appearance ?? self.appearance()
      thumb.backgroundColor = appearance.thumbColor
    }
    
    if animated {
      UIView.animate(withDuration: self.switchAnimationDuration) {
        apply()
      }
    } else {
      apply()
    }
  }
  
  private func updateThumbPosition(animated: Bool) {
    func apply() {
      self.thumbLeftAnchor.constant = thumbXPosition
    }
    
    if animated {
      UIView.animate(withDuration: self.switchAnimationDuration) {
        apply()
        self.layoutIfNeeded()
      }
    } else {
      apply()
    }
    
  }
  
  private func applyAppearances(animated: Bool) {
    self.backdropApply(animated: animated)
    self.thumbApply(animated: animated)
  }
  
  // MARK: Overrides
  
  public override func layoutSubviews() {
    super.layoutSubviews()
    self.thumb.layer.cornerRadius = thumbSize / 2.0
    self.backdrop.layer.cornerRadius = switchHeight / 2.0
    self.layoutThumb()
  }
  
  @objc
  private func touched() {
    setOn(!isOn, animated: true)
    self.sendActions(for: .valueChanged)
  }
  
  // MARK: UISwitch Overrides
  public override var isOn: Bool {
    didSet {
      guard self.superview != nil else {
        return
      }
      applyAppearances(animated: false)
      updateThumbPosition(animated: false)
    }
  }
  
  public override func setOn(_ on: Bool, animated: Bool) {
    super.setOn(on, animated: animated)
    guard self.superview != nil else {
      return
    }
    self.applyAppearances(animated: animated)
    self.updateThumbPosition(animated: animated)
  }
  
  public override var isEnabled: Bool {
    didSet {
      self.button.isEnabled = self.isEnabled
      applyAppearances(animated: true)
    }
  }
  
  public override func didMoveToSuperview() {
    super.didMoveToSuperview()
    layoutThumb()
    applyAppearances(animated: false)
    updateThumbPosition(animated: false)
  }
  
}
