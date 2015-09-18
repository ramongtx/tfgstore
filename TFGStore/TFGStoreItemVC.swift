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
        self.iconImageView.layer.cornerRadius = 25.0;
        self.iconImageView.clipsToBounds = true;
        
        if let model = self.model {
            self.navigationItem.title = model.appName;
            self.nameLabel.text = model.appName;
            self.iconImageView.loadImageFromURLString(model.iconURL, placeholderImage: nil, completion: nil);
            self.descriptionTextView.text = model.description;
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
