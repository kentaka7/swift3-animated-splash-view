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
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.backgroundColor = UIColor.orange
    }
    
    var offset : CGFloat = 0
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        self.offset = self.view.bounds.height / 3
        
        self.titleTop.constant  += self.offset
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
        UIView.animate(withDuration: 0.4, delay: 0.5, options: [.curveEaseOut],
                       animations: {
                        self.titleTop.constant  -= self.offset
                        self.usernameTop.constant -= self.offset
                        self.passwordTop.constant -= self.offset
                        self.buttonTop.constant -= self.offset
                        
                        self.title1.alpha = 1
                        self.usernameInput.alpha = 1
                        self.passwordInput.alpha = 1
                        self.buttonInput.alpha = 1
                        
                        self.view.layoutIfNeeded()
        },
                       completion: nil
        )
    }
}



