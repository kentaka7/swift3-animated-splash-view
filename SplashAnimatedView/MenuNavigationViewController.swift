//
//  MenuNavigationViewController.swift
//  SplashAnimatedView
//
//  Created by vpetrenko on 02.03.17.
//  Copyright © 2017 vpetrenko. All rights reserved.
//

import UIKit

public func delay(_ delay:Double, closure:@escaping ()->()) {
    DispatchQueue.main.asyncAfter(
        deadline: DispatchTime.now() + Double(Int64(delay * Double(NSEC_PER_SEC))) / Double(NSEC_PER_SEC), execute: closure)
}

class MenuNavigationViewController: UIViewController {

    @IBOutlet weak var title1: UILabel!
    @IBOutlet weak var usernameInput: UITextField!
    @IBOutlet weak var passwordInput: UITextField!
    @IBOutlet weak var buttonInput: UIButton!


    @IBOutlet weak var usernameTop: NSLayoutConstraint!
    @IBOutlet weak var passwordTop: NSLayoutConstraint!
    @IBOutlet weak var buttonTop: NSLayoutConstraint!
    
    var splashView: SplashView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.backgroundColor = UIColor.orange
        
        self.splashView = Bundle.main.loadNibNamed("SplashView", owner: nil, options: nil)?[0] as? SplashView
        self.view.addSubview(splashView)

    }
    
    var offset : CGFloat = 0
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        self.offset = self.view.frame.height / 3
        
        self.usernameTop.constant += self.offset
        self.passwordTop.constant += self.offset
        self.buttonTop.constant += self.offset
        
        self.title1.alpha = 0
        self.usernameInput.alpha = 0
        self.passwordInput.alpha = 0
        self.buttonInput.alpha = 0


    }
    
    override func viewDidAppear(_ animated: Bool) {
        
        super.viewDidAppear(animated)
  
        self.splashView!.animateFirstAppear() { finished in

            delay(2.0) {
                
                let dispatchGroup = DispatchGroup()
                
                dispatchGroup.enter()
                self.splashView!.animateDissappearTitles() { finished in
                    dispatchGroup.leave()
                }
                
                dispatchGroup.enter()
                self.splashView!.animatePin() { finished in
                    dispatchGroup.leave()
                }
                
                dispatchGroup.notify(queue: .main) {

                    UIView.animate(withDuration: 0.5,
                                   delay: 0,
                                   options: .curveEaseOut,
                                   animations: {
                                    
                                    self.splashView.removeFromSuperview()
                    },
                                   completion: {finished in
                                    
                                    UIView.animate(withDuration: 0.5,
                                                   delay: 0,
                                                   options: .curveEaseOut,
                                                   animations: {
                                                    
                                                    self.usernameTop.constant -= self.offset
                                                    self.passwordTop.constant -= self.offset
                                                    self.buttonTop.constant -= self.offset
                                                    
                                                    self.title1.alpha = 1
                                                    self.usernameInput.alpha = 1
                                                    self.passwordInput.alpha = 1
                                                    self.buttonInput.alpha = 1
                                                    
                                                    self.view.layoutIfNeeded()
                                    },
                                                   completion: nil)
                                    
                    })
                    
                    
                }
                

            }
            

        }


    }
}



