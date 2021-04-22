//
//  ViewController.swift
//  iOS Example
//
//  Created by Mohammad Porooshani on 4/10/21.
//

import Kontrols
import SnapKit
import UIKit

class ViewController: UIViewController {
  
  lazy var searchBar: KSearchBar = {
    let searchbar = KSearchBar(frame: .zero)
    
    return searchbar
  }()
  
  lazy var sampleSearchBar: UISearchBar = {
    let srch = UISearchBar(frame: .zero)
    srch.searchBarStyle = .minimal
    return srch
  }()
  
  lazy var sampleSwitch: KSwitch = {
    let ksw = KSwitch(frame: .zero)
//    ksw.offAppearance.tintColor = .red
//    ksw.onAppearance.borderColor = .red
//    ksw.switchBorderWidth = 2
//    ksw.isOn = true
//    ksw.setOn(true, animated: true)
//    ksw.isEnabled = true
    ksw.addTarget(self, action: #selector(self.switchChanged(_:)), for: .valueChanged)
    return ksw
  }()
  
  override func viewDidLoad() {
    super.viewDidLoad()
    prepareSearchBar()
    prepareSampleSearchBar()
    prepareKswitchSample()
    DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 2) {
//      self.sampleSwitch.setOn(true, animated: false)
//      self.sampleSwitch.isOn = true
//      self.sampleSwitch.isEnabled = false
    }
  }
  
  private func prepareSearchBar() {
    self.view.addSubview(searchBar)
    searchBar.translatesAutoresizingMaskIntoConstraints = false
    searchBar.heightAnchor.constraint(equalToConstant: 56).isActive = true
    searchBar.widthAnchor.constraint(equalTo: self.view.widthAnchor, multiplier: 1.0).isActive = true
    searchBar.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor).isActive = true
  }
  
  private func prepareSampleSearchBar() {
    self.view.addSubview(sampleSearchBar)
    self.sampleSearchBar.snp.makeConstraints { make in
      make.top.equalTo(self.searchBar.snp.bottom)
      make.leading.equalToSuperview()
      make.trailing.equalToSuperview()
    }
    
  }
  
  private func prepareKswitchSample() {
    self.view.addSubview(self.sampleSwitch)
    self.sampleSwitch.snp.makeConstraints { make in
      make.center.equalToSuperview()
      make.width.equalTo(44)
      make.height.equalTo(24)
    }
  }
  
  @objc
  func switchChanged(_ sender: KSwitch) {
    print("Switch is \(sender.isOn ? "on" : "off")")
  }
}
