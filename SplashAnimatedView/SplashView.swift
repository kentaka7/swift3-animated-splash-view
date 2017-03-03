//
//  SplashView.swift
//  SplashAnimatedView
//
//  Created by vpetrenko on 02.03.17.
//  Copyright © 2017 vpetrenko. All rights reserved.
//

import UIKit


import UIKit

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
 
    
    let offset: CGFloat = 60
    
    override init(frame: CGRect) {
        super.init(frame: frame)
 
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
       
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
    
    open func animateDissappearTitles(completionHandler: @escaping (_ result: Bool) -> ()) {

        UIView.animate(withDuration: 0.4, delay: 0.0, options: [.curveEaseOut],
                       animations: {

                        self.title1X.constant += self.offset
                        self.title2X.constant += self.offset

                        self.title1.alpha = 0
                        self.title2.alpha = 0

                        self.layoutIfNeeded()
        },
                       completion: { finished in
                        completionHandler(true)
        }
        )
    }
    
    open func animatePin(completionHandler: @escaping (_ result: Bool) -> ()) {

        UIView.animate(withDuration: 0.5,
                       delay: 0,
                       options: UIViewAnimationOptions.curveEaseOut,
                       animations: {
                        
                        self.imageHeight.constant = 500

                        self.layoutIfNeeded()
                        
        },
                       completion: { finished in
                        completionHandler(true)
        })
    }
    
    
}
