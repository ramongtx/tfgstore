//
//  TFGStoreTableCell.swift
//  TFGStore
//
//  Created by Ramon Carvalho Maciel on 9/18/15.
//  Copyright (c) 2015 Ramon Carvalho Maciel. All rights reserved.
//

import UIKit

class TFGStoreTableCell: UITableViewCell {
    
    // Outlets
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var positionLabel: UILabel!
    @IBOutlet weak var iconImageView: UIImageView!
    
    var delegate : TFGStoreTableCellProtocol?;
    
    // When model changes, update view
    var model : TFGStoreItemModel? {
        didSet {
            loadModelInfo();
        }
    }
    
    // Updates view so it corresponds to model
    func loadModelInfo () {
        if let model = self.model {
            positionLabel.text = "\(model.position)";
            nameLabel.text = model.appName;
            iconImageView.loadImageFromURLString(model.iconURL, placeholderImage: nil, completion: nil);
        }
    }
    
    // Basic initializer
    override func awakeFromNib() {
        super.awakeFromNib()
        
        // Rounded corners
        self.iconImageView.layer.cornerRadius = self.iconImageView.frame.width/4;
        self.iconImageView.clipsToBounds = true
        
        // Image view answers to touch as button
        let tapGestureRecognizer = UITapGestureRecognizer(target:self, action:Selector("clickedGet:"))
        self.iconImageView.addGestureRecognizer(tapGestureRecognizer)

    }

    // Button or image touch sends signal to delegate to change view controller
    @IBAction func clickedGet(sender: AnyObject) {
        if let mod = self.model {
            delegate?.selectedModel(mod);
        }
    }

}

// Delegate protocol to answer to cell selection
protocol TFGStoreTableCellProtocol {
    func selectedModel(model: TFGStoreItemModel);
}