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
    var model : TFGStoreItemModel? {
        didSet {
            loadModelInfo();
        }
    }
    
    func loadModelInfo () {
        if let model = self.model {
            positionLabel.text = "\(model.position)";
            nameLabel.text = model.appName;
            iconImageView.loadImageFromURLString(model.iconURL, placeholderImage: nil, completion: nil);
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.iconImageView.layer.cornerRadius = self.iconImageView.frame.width/4;
        self.iconImageView.clipsToBounds = true
        let tapGestureRecognizer = UITapGestureRecognizer(target:self, action:Selector("clickedGet:"))
        self.iconImageView.addGestureRecognizer(tapGestureRecognizer)

    }

    @IBAction func clickedGet(sender: AnyObject) {
        if let mod = self.model {
            delegate?.selectedModel(mod);
        }
    }

}

protocol TFGStoreTableCellProtocol {
    func selectedModel(model: TFGStoreItemModel);
}