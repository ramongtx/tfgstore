//
//  TFGStoreItemVC.swift
//  TFGStore
//
//  Created by Ramon Carvalho Maciel on 9/18/15.
//  Copyright (c) 2015 Ramon Carvalho Maciel. All rights reserved.
//

import UIKit

class TFGStoreItemVC: UIViewController {
    
    // XIB Outlets
    @IBOutlet weak var descriptionTextView: UITextView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var iconImageView: UIImageView!
    @IBOutlet weak var screenshotScrollView: UIScrollView!

    // Model
    var model : TFGStoreItemModel?;

    init() {
        super.init(nibName: "TFGStoreItemVC", bundle: nil);
    }

    required init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder);
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Adapts the layout to navigation bar and/or tab bar
        self.edgesForExtendedLayout = UIRectEdge.None;
        
        // Rounded corners on the app icon
        self.iconImageView.layer.cornerRadius = self.iconImageView.frame.width/4;
        self.iconImageView.clipsToBounds = true;
        
        // Loads model information into the view
        if let model = self.model {
            self.navigationItem.title = model.appName;
            self.nameLabel.text = model.appName;
            self.iconImageView.loadImageFromURLString(model.iconURL, placeholderImage: nil, completion: nil);
            self.descriptionTextView.text = model.description;
            loadScreenshots(model.screenshotsURLs);
        }
    }
    
    func loadModel(newModel: TFGStoreItemModel) {
        self.model = newModel;
    }
    
    // Loads screenshot from their URLs to the scroll view
    func loadScreenshots(urls: Array<String>) {
        
        // contentOffset calculates the total width of the contents of the scroll view
        var contentOffset : CGFloat = 0.0;
        
        // For each screenshot...
        for url in urls {
            
            // Make it so as images are always 225x400 (portrait)
            var rect = CGRectMake(contentOffset, 0 as CGFloat, 225, 400);
            var imgview = UIImageView(frame: rect);
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
            if UIApplication.sharedApplication().canOpenURL(url) == true  {
                UIApplication.sharedApplication().openURL(url)
            }

        }
    }
}
