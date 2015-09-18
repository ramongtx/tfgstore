//
//  TFGStoreVC.swift
//  TFGStore
//
//  Created by Ramon Carvalho Maciel on 9/17/15.
//  Copyright (c) 2015 Ramon Carvalho Maciel. All rights reserved.
//

import UIKit

class TFGStoreVC: UIViewController, UITableViewDataSource, UITableViewDelegate, TFGStoreTableCellProtocol {
    
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    @IBOutlet weak var tableView: UITableView!;
    
    var jsonURLString : String = "";
    var modelArray : Array<TFGStoreItemModel> = Array<TFGStoreItemModel>();
    
    static func present(parent : UIViewController, url: String) {
        let vc = TFGStoreVC();
        vc.jsonURLString = url;
        
        let nav = UINavigationController(rootViewController: vc);
        
        parent.presentViewController(nav, animated: false, completion: nil);
    }
    
    init() {
        super.init(nibName: "TFGStoreVC", bundle: nil);
    }
    
    required init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder);
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.tableView.hidden = true;
        self.activityIndicator.startAnimating();
        
        self.navigationItem.title = "TFG Games Store";
        
        let backButton = UIBarButtonItem(title: "Close", style: UIBarButtonItemStyle.Plain, target: self, action:"close:");
        self.navigationItem.leftBarButtonItem = backButton;
        
        tableView.delegate = self;
        tableView.dataSource = self;
        tableView.tableFooterView = UIView(frame: CGRectZero);
        
        // Registering NIB
        var tableCellNib = UINib(nibName: "TFGStoreTableCell",bundle: nil);
        tableView.registerNib(tableCellNib, forCellReuseIdentifier: "tfgstorecell");
        
        TFGStoreItemModel.arrayFromURLAsync(self.jsonURLString) { array in
            self.modelArray = array;
            self.tableView.reloadData();
            self.activityIndicator.stopAnimating();
            self.tableView.hidden = false;

        };
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section != 0 {
            return 0;
        }
        return self.modelArray.count;
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        var cell : TFGStoreTableCell = self.tableView.dequeueReusableCellWithIdentifier("tfgstorecell") as! TFGStoreTableCell;
        
        cell.delegate = self;
        cell.loadModel(self.modelArray[indexPath.row]);

        return cell;
    }
    
    func selectedModel(model: TFGStoreItemModel) {
        var vc = TFGStoreItemVC();
        vc.loadModel(model);
        self.navigationController?.pushViewController(vc, animated: true);
    }

    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return 84;
    }
    
    func close(sender: AnyObject) {
        self.dismissViewControllerAnimated(false, completion: nil);
    }

}
