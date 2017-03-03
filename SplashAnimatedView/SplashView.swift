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

struct SplashAnimationConfig {
    static let OFFSET_FIRST_SCREEN: CGFloat = 30
    static let OFFSET_SECOND_SCREEN: CGFloat = 60
    
    static let DURATION_APPEAR = 0.4
    static let DELAY_FIRST_SCREEN_ELEMENT_1 = 0.5
    static let DELAY_FIRST_SCREEN_ELEMENT_2 = SplashAnimationConfig.DELAY_FIRST_SCREEN_ELEMENT_1 + 0.1
    static let DELAY_FIRST_SCREEN_ELEMENT_3 = SplashAnimationConfig.DELAY_FIRST_SCREEN_ELEMENT_2 + 0.1
    
    static let DURATION_DISAPPEAR_TITLES = 0.2
    static let DELAY_DISAPPEAR_TITLES = 0.0
    
    static let DURATION_ANIMATE_PIN = SplashAnimationConfig.DURATION_DISAPPEAR_TITLES * 2
    static let DELAY_ANIMATE_PIN = SplashAnimationConfig.DELAY_DISAPPEAR_TITLES // start disappear titles and zoom pin
    static let ANIMATE_TO_PIN_HEIGHT: CGFloat = 500.0
    
    static let DELAY_ANIMATE_CHILD = SplashAnimationConfig.DURATION_ANIMATE_PIN - 0.1 // start earlier than pin finish
    static let DURATION_ANIMATE_CHILD = SplashAnimationConfig.DURATION_ANIMATE_PIN // the same as pin duration
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

    static func getView () -> SplashView {
        return Bundle.main.loadNibNamed("SplashView", owner: nil, options: nil)?[0] as! SplashView
    }
    
    override func draw(_ rect: CGRect) {
        self.title1X.constant += SplashAnimationConfig.OFFSET_FIRST_SCREEN
        self.title2X.constant += SplashAnimationConfig.OFFSET_FIRST_SCREEN
        self.logoX.constant += SplashAnimationConfig.OFFSET_FIRST_SCREEN
        
        self.title1.alpha = 0
        self.title2.alpha = 0
        self.logoImage.alpha = 0
        
        self.layoutIfNeeded()
    }
    
    open func animateFirstAppear(completion: @escaping (_ result: Bool) -> ()) {
        let dispatchGroup = DispatchGroup()
        
        dispatchGroup.enter()
        UIView.animate(withDuration: SplashAnimationConfig.DURATION_APPEAR,
                       delay: SplashAnimationConfig.DELAY_FIRST_SCREEN_ELEMENT_1,
                       options: [.curveEaseOut], animations: {
            self.title1X.constant -= SplashAnimationConfig.OFFSET_FIRST_SCREEN
            self.title1.alpha = 1
            self.layoutIfNeeded()
        },
            completion: {finished in
                dispatchGroup.leave()
        })
        
        dispatchGroup.enter()
        UIView.animate(withDuration: SplashAnimationConfig.DURATION_APPEAR,
                       delay: SplashAnimationConfig.DELAY_FIRST_SCREEN_ELEMENT_2,
                       options: [.curveEaseOut], animations: {
            self.logoX.constant -= SplashAnimationConfig.OFFSET_FIRST_SCREEN
            self.logoImage.alpha = 1
            self.layoutIfNeeded()
        },
            completion: {finished in
                dispatchGroup.leave()
        })
        
        dispatchGroup.enter()
        UIView.animate(withDuration: SplashAnimationConfig.DURATION_APPEAR,
                       delay: SplashAnimationConfig.DELAY_FIRST_SCREEN_ELEMENT_3,
                       options: [.curveEaseOut], animations: {
            self.title2X.constant -= SplashAnimationConfig.OFFSET_FIRST_SCREEN
            self.title2.alpha = 1
            self.layoutIfNeeded()
        }, completion: {finished in
            dispatchGroup.leave()
        })
        
        dispatchGroup.notify(queue: .main) {
            completion(true)
        }
    }
    
    open func animateDisappearTitles() {

        UIView.animate(withDuration: SplashAnimationConfig.DURATION_DISAPPEAR_TITLES,
                       delay: SplashAnimationConfig.DELAY_DISAPPEAR_TITLES,
                       options: [.curveEaseOut], animations: {
             self.title1X.constant += SplashAnimationConfig.OFFSET_FIRST_SCREEN
             self.title2X.constant += SplashAnimationConfig.OFFSET_FIRST_SCREEN

             self.title1.alpha = 0
             self.title2.alpha = 0

             self.layoutIfNeeded()
        }, completion: nil)
    }
    
    open func animatePin() {
        
        UIView.animate(withDuration: SplashAnimationConfig.DURATION_ANIMATE_PIN,
                       delay: SplashAnimationConfig.DELAY_ANIMATE_PIN,
                       options: UIViewAnimationOptions.curveEaseOut, animations: {
              self.imageHeight.constant = SplashAnimationConfig.ANIMATE_TO_PIN_HEIGHT
              self.layoutIfNeeded()
        }, completion: nil)
    }
}

// Work with child elements

extension SplashView {
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
            childConstraints[i].constant += SplashAnimationConfig.OFFSET_SECOND_SCREEN
        }
        
    }
    
    open func animateChild() {
        UIView.animate(withDuration: SplashAnimationConfig.DURATION_ANIMATE_CHILD,
                       delay: SplashAnimationConfig.DELAY_ANIMATE_CHILD,
                       options: .curveEaseOut, animations: {
             for i in 0...self.childElements.count-1 {
                self.childConstraints[i].constant -= SplashAnimationConfig.OFFSET_SECOND_SCREEN
                self.childElements[i].alpha = 1
             }
            
            self.layoutIfNeeded()
        }, completion: nil)
    }
}
