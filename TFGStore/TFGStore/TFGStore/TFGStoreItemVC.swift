//
//  TFGStoreItemVC.swift
//  TFGStore
//
//  Created by Ramon Carvalho Maciel on 9/18/15.
//  Copyright (c) 2015 Ramon Carvalho Maciel. All rights reserved.
//

import UIKit

class TFGStoreItemVC: UIViewController {
    @IBOutlet weak var descriptionTextView: UITextView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var iconImageView: UIImageView!
    @IBOutlet weak var screenshotScrollView: UIScrollView!

    var model : TFGStoreItemModel?;

    init() {
        super.init(nibName: "TFGStoreItemVC", bundle: nil);
    }

    required init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder);
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.edgesForExtendedLayout = UIRectEdge.None;
        self.iconImageView.layer.cornerRadius = self.iconImageView.frame.width/4;
        self.iconImageView.clipsToBounds = true;
        
        if let model = self.model {
            self.navigationItem.title = model.appName;
            self.nameLabel.text = model.appName;
            self.iconImageView.loadImageFromURLString(model.iconURL, placeholderImage: nil, completion: nil);
            self.descriptionTextView.text = model.description;
            loadScreenshots(model.screenshotsURLs);
        }
    }
    
    func loadScreenshots(urls: Array<String>) {
        var contentOffset : CGFloat = 0.0;
        for url in urls {
            var rect = CGRectMake(contentOffset, 0 as CGFloat, 225, 400);
            var imgview = UIImageView(frame: rect);
            imgview.backgroundColor = UIColor.lightGrayColor();
            imgview.loadImageFromURLString(url, placeholderImage: nil) { finished, error in
                if finished {
                    imgview.backgroundColor = UIColor.clearColor();
                    if let img = imgview.image {
                        if img.size.width/img.size.height > 1.0 {
                            var newImg = UIImage(CGImage: img.CGImage, scale: 1.0, orientation: .Left)
                            imgview.image = newImg;
                        }
                    }
                }
            };
            imgview.contentMode = UIViewContentMode.ScaleAspectFit;
            self.screenshotScrollView.addSubview(imgview);
            
            contentOffset += imgview.frame.size.width;
            self.screenshotScrollView.contentSize = CGSizeMake(contentOffset, self.screenshotScrollView.frame.size.height);
            contentOffset += 10;

        }

    }
    
    @IBAction func downloadClicked(sender: AnyObject) {
        if let id = self.model?.storeId, url  = NSURL(string: "itms-apps://itunes.apple.com/app/\(id)") {
            if UIApplication.sharedApplication().canOpenURL(url) == true  {
                UIApplication.sharedApplication().openURL(url)
            }

        }
    }
    
    func loadModel(newModel: TFGStoreItemModel) {
        self.model = newModel;
    }
}
