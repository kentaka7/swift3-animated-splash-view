//
//  MenuNavigationViewController.swift
//  SplashAnimatedView
//
//  Created by vpetrenko on 02.03.17.
//  Copyright © 2017 vpetrenko. All rights reserved.
//

import UIKit

class MenuNavigationViewController: UIViewController {

    @IBOutlet weak var title1: UILabel!
    @IBOutlet weak var usernameInput: UITextField!
    @IBOutlet weak var passwordInput: UITextField!
    @IBOutlet weak var buttonInput: UIButton!


    @IBOutlet weak var titleTop: NSLayoutConstraint!
    @IBOutlet weak var usernameTop: NSLayoutConstraint!
    @IBOutlet weak var passwordTop: NSLayoutConstraint!
    @IBOutlet weak var buttonTop: NSLayoutConstraint!
    
    var splashView: SplashView = SplashView.getView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.backgroundColor = UIColor.orange
        self.view.addSubview(splashView)
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)

        self.splashView.addChildElements(
            elements: [self.title1, self.passwordInput, self.usernameInput, self.buttonInput],
            constraints: [self.titleTop, self.usernameTop, self.passwordTop, self.buttonTop])
        
        self.splashView.setupChildElements()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
  
        self.splashView.animateFirstAppear() { finished in
            delay(2.0) {
                self.splashView.animateDissappearTitles()
                self.splashView.animatePin()
                self.splashView.animateChild()
           }
        }
    }
}



