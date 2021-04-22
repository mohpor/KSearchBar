//
//  File.swift
//  
//
//  Created by Mohammad Porooshani on 4/22/21.
//

import UIKit

public extension UIColor {
  
  enum Kontrols {
        
    public static let brownGrey = UIColor(hex: "b4b4b4")
    public static let ceruleanBlue = UIColor(hex: "0066e0")
    public static let veryLightBlue = UIColor(hex: "deebfa")
    public static let veryLightPurple = UIColor(hex: "e8e7e8")
    
  }

  
  convenience init(hex: String) {
    let red, green, blue, alpha: CGFloat
    
    let startOffset = hex.hasPrefix("#") ? 1 : 0
    let start = hex.index(hex.startIndex, offsetBy: startOffset)
    let hexColor = String(hex[start...])
    
    guard hexColor.count == 6 || hexColor.count == 8 else {
      fatalError("Invalid hex color format.")
    }
    
    let scanner = Scanner(string: hexColor)
    var hexNumber: UInt64 = 0
    
    guard scanner.scanHexInt64(&hexNumber) else {
      fatalError("could not scan hex color!")
    }
    
    if hexColor.count == 8 {
      red = CGFloat((hexNumber & 0xff000000) >> 24) / 255
      green = CGFloat((hexNumber & 0x00ff0000) >> 16) / 255
      blue = CGFloat((hexNumber & 0x0000ff00) >> 8) / 255
      alpha = CGFloat(hexNumber & 0x000000ff) / 255
    } else {
      red = CGFloat((hexNumber & 0xff0000) >> 16) / 255
      green = CGFloat((hexNumber & 0x00ff00) >> 8) / 255
      blue = CGFloat((hexNumber & 0x0000ff)) / 255
      alpha = 1.0
    }
    
    self.init(red: red, green: green, blue: blue, alpha: alpha)
    
  }
}

