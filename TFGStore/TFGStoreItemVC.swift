//
//  TFGStoreItemVC.swift
//  TFGStore
//
//  Created by Ramon Carvalho Maciel on 9/18/15.
//  Copyright (c) 2015 Ramon Carvalho Maciel. All rights reserved.
//

import UIKit

class TFGStoreItemVC: UIViewController {

    var model : TFGStoreItemModel?;

    init() {
        super.init(nibName: "TFGStoreItemVC", bundle: nil);
    }

    required init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder);
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    func loadModel(newModel: TFGStoreItemModel) {
        self.model = newModel;
        self.navigationItem.title = newModel.appName;
    }
}
