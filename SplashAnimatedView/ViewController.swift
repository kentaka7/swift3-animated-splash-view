//
//  ViewController.swift
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


class ViewController: UIViewController {

    
    fileprivate var rootViewController: UIViewController? = nil
    
    @IBOutlet weak var logoImage: UIImageView!
    @IBOutlet weak var title1: UILabel!
    @IBOutlet weak var title2: UILabel!
    
    @IBOutlet weak var imageHeight: NSLayoutConstraint!
    
    var childController: UIContentContainer!
    
    @IBOutlet weak var title1Y: NSLayoutConstraint!
    @IBOutlet weak var title2Y: NSLayoutConstraint!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.backgroundColor = UIColor.orange
        
   }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
        self.view.backgroundColor = UIColor.orange
    }

    override func viewDidAppear(_ animated: Bool) {
        
        
        UIView.animate(withDuration: 0.5,
                       delay: 0,
                       options: UIViewAnimationOptions.curveEaseOut,
                       animations: {
                      
                        self.imageHeight.constant = 500
                        
                        self.title1Y.constant = 70
                        self.title2Y.constant = 70
                        
                        self.title1.alpha = 0
                        self.title2.alpha = 0
                        self.view.layoutIfNeeded()
                        
        },
        completion: {
          finished in
           self.showMenuNavigationViewController()
            
        })
    }
    
    /// Displays the MapViewController
    func showMenuNavigationViewController() {
        guard !(rootViewController is MenuNavigationViewController) else { return }
        
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let nav =  storyboard.instantiateViewController(withIdentifier: "MenuNavigationController") as! UINavigationController
        nav.willMove(toParentViewController: self)
        addChildViewController(nav)
        
        if let rootViewController = self.rootViewController {
            self.rootViewController = nav
            rootViewController.willMove(toParentViewController: nil)
            
            transition(from: rootViewController, to: nav, duration: 1.55, options: [.transitionCrossDissolve, .curveEaseOut], animations: { () -> Void in
                
            }, completion: { _ in
                nav.didMove(toParentViewController: self)
                rootViewController.removeFromParentViewController()
                rootViewController.didMove(toParentViewController: nil)
            })
        } else {
            rootViewController = nav
            view.addSubview(nav.view)
            nav.didMove(toParentViewController: self)
        }
    }
    
    
    
}

