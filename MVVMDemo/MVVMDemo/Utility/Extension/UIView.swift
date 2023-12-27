//
//  UIView.swift
//  MVVMDemo
//
//  Created by Yash Barot on 27/12/23.
//

import Foundation
import UIKit

extension UIView {

    
    var cornerRadius: CGFloat {
        get {
            return layer.cornerRadius
        }
        set {
            layer.cornerRadius = newValue
        }
    }
    
    func addShadow(shadowColor : UIColor? = .gray,shadowOpacity : Float = 0.25 , shadowOffset : CGSize = CGSize(width: 0, height: 4),shadowRadius : CGFloat = 5){
        
        self.layer.shadowColor = (shadowColor ?? .gray).cgColor
        self.layer.shadowOpacity = shadowOpacity
        self.layer.shadowOffset = shadowOffset
        self.layer.shadowRadius = shadowRadius
        
    }
    
}
