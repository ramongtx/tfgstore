//
//  TFGStoreItemVC.swift
//  TFGStore
//
//  Created by Ramon Carvalho Maciel on 9/18/15.
//  Copyright (c) 2015 Ramon Carvalho Maciel. All rights reserved.
//

import UIKit

class TFGStoreItemVC: UIViewController {
    
    private static let screenshotWidth : CGFloat = 225.0;
    private static let screenshotHeight : CGFloat = 400.0;
    
    // XIB Outlets
    @IBOutlet weak var descriptionTextView: UITextView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var iconImageView: UIImageView!
    @IBOutlet weak var screenshotScrollView: UIScrollView!

    // Model
    var model : TFGStoreItemModel? {
        didSet {
            if self.isViewLoaded() {
                loadModelInfo();
            }
        }
    }
    
    // Loads model information into the view
    private func loadModelInfo () {
        if let model = self.model {
            self.navigationItem.title = model.appName;
            self.nameLabel.text = model.appName;
            self.iconImageView.loadImageFromURLString(model.iconURL, placeholderImage: nil, completion: nil);
            self.descriptionTextView.text = model.description;
            loadScreenshots(model.screenshotsURLs);
            
            // Log event
            TFGStoreLogger.log(.AppLandingPage(model.storeId,model.position))
        }
    }

    // Default initializer
    init() {
        super.init(nibName: "TFGStoreItemVC", bundle: nil);
    }

    // Required initializer
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder);
    }
    
    // Called when first loading page
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Adapts the layout to navigation bar and/or tab bar
        self.edgesForExtendedLayout = UIRectEdge.None;
        
        // Rounded corners on the app icon
        self.iconImageView.layer.cornerRadius = self.iconImageView.frame.width/4;
        self.iconImageView.clipsToBounds = true;
        
        // Loads model information into the view
        loadModelInfo();
    }
    
    // Called when user is leaving this view
    override func viewWillDisappear(animated: Bool) {
        if let nav = self.navigationController {
            if nav.viewControllers.indexOf(self) != nil {
                
            } else if let model = self.model {
                TFGStoreLogger.log(.ClosedAppLandingPage(model.storeId,model.position));
            }
        }
        super.viewWillDisappear(animated);
        
    }
    
    // Loads screenshot from their URLs to the scroll view
    func loadScreenshots(urls: Array<String>) {
        
        // contentOffset calculates the total width of the contents of the scroll view
        var contentOffset : CGFloat = 0.0;
        
        // For each screenshot...
        for url in urls {
            
            // Make it so as images are always 225x400 (portrait)
            let rect = CGRectMake(contentOffset, 0 as CGFloat, TFGStoreItemVC.screenshotWidth, TFGStoreItemVC.screenshotHeight);
            let imgview = UIImageView(frame: rect);
            imgview.backgroundColor = UIColor.lightGrayColor();
            imgview.contentMode = UIViewContentMode.ScaleAspectFit;

            // Load image from URL
            imgview.loadImageFromURLString(url, placeholderImage: nil) { finished, error in
                if finished {
                    imgview.backgroundColor = UIColor.clearColor();
                    
                    // If necessary, rotate image to best fit portrait orientation
                    imgview.rotateForBestFit();
                }
            };
            
            // Calculate new content offset
            contentOffset += imgview.frame.size.width;
            
            // Add image view to scroll view and update content size
            self.screenshotScrollView.addSubview(imgview);
            self.screenshotScrollView.contentSize = CGSizeMake(contentOffset, self.screenshotScrollView.frame.size.height);
            
            // Add an extra spacing between image views
            contentOffset += 10;

        }

    }
    
    // Open App Store (if possible) upon user clicking download
    @IBAction func downloadClicked(sender: AnyObject) {
        if let id = self.model?.storeId, url  = NSURL(string: "itms-apps://itunes.apple.com/app/\(id)") {
            // Log event
            TFGStoreLogger.log(.Downloaded(id,self.model!.position));

            if UIApplication.sharedApplication().canOpenURL(url) == true  {
                UIApplication.sharedApplication().openURL(url)
            }

        }
    }
}
