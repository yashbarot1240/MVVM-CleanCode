//
//  UIViewController+Extension.swift
//  MVVMDemo
//
//  Created by Yash Barot on 27/12/23.
//

import Foundation
import UIKit
import NVActivityIndicatorView

enum AppStoryboard : String {
    
    case Main
    
    var instance : UIStoryboard {
        
        return UIStoryboard(name: self.rawValue, bundle: Bundle.main)
    }
    
    func viewController<T : UIViewController>(viewControllerClass : T.Type, function : String = #function, line : Int = #line, file : String = #file) -> T {
        
        let storyboardID = (viewControllerClass as UIViewController.Type).storyboardID
        
        guard let scene = instance.instantiateViewController(withIdentifier: storyboardID) as? T else {
            
            fatalError("ViewController with identifier \(storyboardID), not found in \(self.rawValue) Storyboard.\nFile : \(file) \nLine Number : \(line) \nFunction : \(function)")
        }
        
        return scene
    }
    
    func initialViewController() -> UIViewController? {
        
        return instance.instantiateInitialViewController()
    }
}


extension UIViewController {
    
    // Not using static as it wont be possible to override to provide custom storyboardID then
    class var storyboardID : String {
        
        return "\(self)"
    }
    
    static func instantiate(fromAppStoryboard appStoryboard: AppStoryboard) -> Self {
        
        return appStoryboard.viewController(viewControllerClass: self)
    }
    
    
    func showAlert( _ message: String ) {
        let alert = UIAlertController(title: Strings.alertTitle, message: message, preferredStyle: .alert)
        alert.addAction( UIAlertAction(title: Strings.buttonTitleOkay, style: .cancel, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }
    
}

extension UIViewController : NVActivityIndicatorViewable {

    func hideLoader(){
        print("*#*#*#*#*# hideLoader",String(describing: self))
        stopAnimating()

    }

    func startLoader(message : String? = nil){
        print("*#*#*#*#*# startLoader",String(describing: self))
        startAnimating(CGSize(width: 50, height: 50), message: message, type: .ballPulseSync, color: .white, padding: 0)
       }

}
