//
//  LKNSearchBar.swift
//  Swift Package
//
//  Created by Arnold Lee on 2019/10/24.
//  Copyright © 2019 Arnold Lee. All rights reserved.
//

import UIKit

fileprivate extension UIColor {
    convenience init(hexString: String) {
        let hex = hexString.trimmingCharacters(in: CharacterSet.alphanumerics.inverted)
        var int = UInt32()
        Scanner(string: hex).scanHexInt32(&int)
        let a, r, g, b: UInt32
        switch hex.count {
        case 3: // RGB (12-bit)
            (a, r, g, b) = (255, (int >> 8) * 17, (int >> 4 & 0xF) * 17, (int & 0xF) * 17)
        case 6: // RGB (24-bit)
            (a, r, g, b) = (255, int >> 16, int >> 8 & 0xFF, int & 0xFF)
        case 8: // ARGB (32-bit)
            (a, r, g, b) = (int >> 24, int >> 16 & 0xFF, int >> 8 & 0xFF, int & 0xFF)
        default:
            (a, r, g, b) = (255, 0, 0, 0)
        }
        self.init(red: CGFloat(r) / 255, green: CGFloat(g) / 255, blue: CGFloat(b) / 255, alpha: CGFloat(a) / 255)
    }
}

//  MARK: - LKNSearchBar
public class LKNSearchBar: UISearchBar {
    
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    public var font = UIFont.systemFont(ofSize: 20, weight: .regular) {
        didSet {
            draw(self.frame)
        }
    }
    public var lineColor = UIColor(hexString: "#01B7B7") {
        didSet {
            draw(self.frame)
        }
    }
    public var barBackgroundColor = UIColor(red: 240/255, green: 240/255, blue: 240/255, alpha: 1) {
        didSet {
            draw(self.frame)
        }
    }
    
    override public func draw(_ rect: CGRect) {
        
        var customTextField: UITextField
        
        if let textField = subviews[0].subviews[1] as? UITextField{
            customTextField = textField
        }
        else{
            customTextField = subviews[0].subviews[1].subviews[0] as! UITextField
        }
        
        customTextField.borderStyle = .none
        
        //textField.textColor = UIColor(displayP3Red: 1/255, green: 170/255, blue: 170/255, alpha: 1)
        
        customTextField.font = font
        
        subviews[0].subviews[1].frame = CGRect(origin: frame.origin, size: CGSize(width: frame.width, height: frame.height))
        
        subviews[0].subviews[1].backgroundColor = barBackgroundColor
        
        let line = UIView()
        
        line.frame = CGRect(x: 0, y: customTextField.frame.height - 4, width: customTextField.frame.width, height: 4)
        
        line.backgroundColor = lineColor
        
        customTextField.addSubview(line)
        
        showsCancelButton = false
        
        searchBarStyle = .prominent
        
        isTranslucent = false
        
        // Drawing code
    }
}


