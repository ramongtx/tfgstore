//
//  TFGStoreVC.swift
//  TFGStore
//
//  Created by Ramon Carvalho Maciel on 9/17/15.
//  Copyright (c) 2015 Ramon Carvalho Maciel. All rights reserved.
//

import UIKit

class TFGStoreVC: UIViewController, UITableViewDataSource, UITableViewDelegate, TFGStoreTableCellProtocol {
    
    @IBOutlet weak var tableView: UITableView!
    
    init() {
        super.init(nibName: "TFGStoreVC", bundle: nil);
    }
    
    required init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder);
    }
    
    static func present(parent : UIViewController, url: NSString) {
        let vc = TFGStoreVC();
        
        let nav = UINavigationController(rootViewController: vc);
        
        parent.presentViewController(nav, animated: false, completion: nil);
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationItem.title = "App Store";
        
        let backButton = UIBarButtonItem(title: "Close", style: UIBarButtonItemStyle.Plain, target: self, action:"back:");
        self.navigationItem.leftBarButtonItem = backButton;
        
        tableView.delegate = self;
        tableView.dataSource = self;
        
        // Registering NIB
        var tableCellNib = UINib(nibName: "TFGStoreTableCell",bundle: nil);
        tableView.registerNib(tableCellNib, forCellReuseIdentifier: "tfgstorecell");
        
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 5;
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        var cell : TFGStoreTableCell = self.tableView.dequeueReusableCellWithIdentifier("tfgstorecell") as! TFGStoreTableCell;
        
        var mod = TFGStoreItemModel();
        mod.position = indexPath.row;
        mod.appName = "App \(indexPath.row)";
        cell.loadModel(mod);
        
        cell.delegate = self;

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
    
    func back(sender: AnyObject) {
        self.dismissViewControllerAnimated(false, completion: nil);
    }

}
