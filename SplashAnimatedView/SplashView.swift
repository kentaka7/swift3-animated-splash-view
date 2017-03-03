//
//  SplashView.swift
//  SplashAnimatedView
//
//  Created by vpetrenko on 02.03.17.
//  Copyright © 2017 vpetrenko. All rights reserved.
//

import UIKit

import UIKit

public func delay(_ delay:Double, closure:@escaping ()->()) {
    DispatchQueue.main.asyncAfter(
        deadline: DispatchTime.now() + Double(Int64(delay * Double(NSEC_PER_SEC))) / Double(NSEC_PER_SEC), execute: closure)
}

class SplashView: UIView
{

    @IBOutlet weak var title1: UILabel!
    @IBOutlet weak var title2: UILabel!
    @IBOutlet weak var logoImage: UIImageView!
    @IBOutlet weak var imageHeight: NSLayoutConstraint!
    
    @IBOutlet weak var title1X: NSLayoutConstraint!
    @IBOutlet weak var title1Y: NSLayoutConstraint!
    
    @IBOutlet weak var logoX: NSLayoutConstraint!
    @IBOutlet weak var logoY: NSLayoutConstraint!
    
    @IBOutlet weak var title2X: NSLayoutConstraint!
    @IBOutlet weak var title2Y: NSLayoutConstraint!
 
    var childElements: [UIView] = []
    var childConstraints: [NSLayoutConstraint] = []
    
    let offset: CGFloat = 60
    let offsetChildren: CGFloat = 30

    static func getView () -> SplashView {
        return Bundle.main.loadNibNamed("SplashView", owner: nil, options: nil)?[0] as! SplashView
    }
    
    override func draw(_ rect: CGRect) {
        self.title1X.constant += self.offset
        self.title2X.constant += self.offset
        self.logoX.constant += self.offset
        
        self.title1.alpha = 0
        self.title2.alpha = 0
        self.logoImage.alpha = 0
        
        self.layoutIfNeeded()
    }
    
    open func animateFirstAppear(completion: @escaping (_ result: Bool) -> ()) {
        let dispatchGroup = DispatchGroup()
        
        dispatchGroup.enter()
        UIView.animate(withDuration: 0.4, delay: 0.5, options: [.curveEaseOut],
                       animations: {
                        
                        self.title1X.constant -= self.offset
                        self.title1.alpha = 1
                        self.layoutIfNeeded()
        },
                       completion: {finished in
                        dispatchGroup.leave()
                        
        }
        )
        
        dispatchGroup.enter()
        UIView.animate(withDuration: 0.4, delay: 0.6, options: [.curveEaseOut],
                       animations: {
                        
                        self.logoX.constant -= self.offset
                        self.logoImage.alpha = 1
                        self.layoutIfNeeded()
        },
                       completion: {finished in
                        dispatchGroup.leave()
                        
        }
        )
        
        dispatchGroup.enter()
        UIView.animate(withDuration: 0.4, delay: 0.7, options: [.curveEaseOut],
                       animations: {
                        
                        self.title2X.constant -= self.offset
                        self.title2.alpha = 1
                        self.layoutIfNeeded()
        },
                       completion: {finished in
                        dispatchGroup.leave()
                        
        }
        )
        
        dispatchGroup.notify(queue: .main) {
            completion(true)
        }
    }
    
    open func animateDissappearTitles() {

        UIView.animate(withDuration: 0.2, delay: 0.0, options: [.curveEaseOut],
                       animations: {

                        self.title1X.constant += self.offset
                        self.title2X.constant += self.offset

                        self.title1.alpha = 0
                        self.title2.alpha = 0

                        self.layoutIfNeeded()
        },
                       completion: nil)
    }
    
    open func animatePin() {

        UIView.animate(withDuration: 0.4,
                       delay: 0,
                       options: UIViewAnimationOptions.curveEaseOut,
                       animations: {
                        
                        self.imageHeight.constant = 500

                        self.layoutIfNeeded()
                        
        },
                       completion: nil)
    }
    
    open func addChildElements(elements: [UIView], constraints: [NSLayoutConstraint]) {
        for i in 0...elements.count-1 {
            self.addSubview(elements[i])
        }
        self.childElements = elements
        self.childConstraints = constraints
    }
    
    open func setupChildElements() {
        guard childElements.count > 0 && childConstraints.count > 0 else {
            return
        }
        
        for i in 0...childElements.count-1 {
            childElements[i].alpha = 0
        }
        for i in 0...childConstraints.count-1 {
            childConstraints[i].constant += self.offsetChildren
        }

    }
    
    open func animateChild() {
        UIView.animate(withDuration: 0.4,
                       delay: 0.3,
                       options: .curveEaseOut,
                       animations: {
                        
                        for i in 0...self.childElements.count-1 {
                            self.childConstraints[i].constant -= self.offsetChildren
                            self.childElements[i].alpha = 1
                        }

                        self.layoutIfNeeded()
        },
                       completion: nil)

    }
}
