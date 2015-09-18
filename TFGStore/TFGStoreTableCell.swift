//
//  TFGStoreTableCell.swift
//  TFGStore
//
//  Created by Ramon Carvalho Maciel on 9/18/15.
//  Copyright (c) 2015 Ramon Carvalho Maciel. All rights reserved.
//

import UIKit

class TFGStoreTableCell: UITableViewCell {
    
    var model : TFGStoreItemModel?;
    var delegate : TFGStoreTableCellProtocol?;

    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var positionLabel: UILabel!
    @IBOutlet weak var iconImageView: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.iconImageView.layer.cornerRadius = self.iconImageView.frame.width/4;
        self.iconImageView.clipsToBounds = true
        var tapGestureRecognizer = UITapGestureRecognizer(target:self, action:Selector("clickedGet:"))
        self.iconImageView.addGestureRecognizer(tapGestureRecognizer)

    }

    @IBAction func clickedGet(sender: AnyObject) {
        if let mod = self.model {
            delegate?.selectedModel(mod);
        }
    }
    
    func loadModel (newModel: TFGStoreItemModel) {
        self.model = newModel;
        positionLabel.text = "\(newModel.position)";
        nameLabel.text = newModel.appName;
        iconImageView.loadImageFromURLString(newModel.iconURL, placeholderImage: nil, completion: nil);
    }

}

protocol TFGStoreTableCellProtocol {
    func selectedModel(model: TFGStoreItemModel);
}