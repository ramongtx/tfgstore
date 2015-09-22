//
//  GTXUIImageViewExtensions.swift
//  TFGStore
//
//  Created by Ramon Carvalho Maciel on 9/20/15.
//  Copyright (c) 2015 Ramon Carvalho Maciel. All rights reserved.
//

import UIKit

public extension UIImageView {
    
    // Check if image view and image have the same orientation (portrait or landscape) and rotate image to match image view
    public func rotateForBestFit (direction : UIImageOrientation = .Left) {
        if let img = self.image, let cgImg = img.CGImage {
            let imgViewIsPortrait = self.frame.size.height/self.frame.size.width > 1.0;
            let imgIsPortrait = img.size.height/img.size.width > 1.0;
            
            if imgIsPortrait != imgViewIsPortrait {
                let newImg = UIImage(CGImage: cgImg, scale: 1.0, orientation: direction)
                self.image = newImg;
            }
        }
    }
    
}