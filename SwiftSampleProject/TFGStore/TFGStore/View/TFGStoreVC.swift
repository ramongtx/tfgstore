//
//  TFGStoreVC.swift
//  TFGStore
//
//  Created by Ramon Carvalho Maciel on 9/17/15.
//  Copyright (c) 2015 Ramon Carvalho Maciel. All rights reserved.
//

import UIKit

class TFGStoreVC: UIViewController, UITableViewDataSource, UITableViewDelegate, TFGStoreTableCellProtocol {
    
    // Outlets
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    @IBOutlet weak var tableView: UITableView!;
    
    // URL String for JSON model
    var jsonURLString = "";
    
    // Array of all items to be shown
    var modelArray = Array<TFGStoreItemModel>();

    // Basic NIB initializer
    init() {
        super.init(nibName: "TFGStoreVC", bundle: nil);
    }
    
    // Required initializer
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder);
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Navigation bar configuration
        self.navigationItem.title = "TFG Games Store";
        let backButton = UIBarButtonItem(title: "Close", style: UIBarButtonItemStyle.Plain, target: self, action:"close:");
        self.navigationItem.leftBarButtonItem = backButton;
        
        // Show loading indicator during JSON dowload
        self.tableView.hidden = true;
        self.activityIndicator.startAnimating();
        
        // TableView configuration
        tableView.delegate = self;
        tableView.dataSource = self;
        tableView.tableFooterView = UIView(frame: CGRectZero); // No empty cells to fill space
        
        // Registering NIB responsible for table cells
        let tableCellNib = UINib(nibName: "TFGStoreTableCell",bundle: nil);
        tableView.registerNib(tableCellNib, forCellReuseIdentifier: "tfgstorecell");
        
        // Load JSON from URL asynchronously
        TFGStoreItemModel.arrayFromURLAsync(self.jsonURLString) { array in
            self.modelArray = array;
            self.tableView.reloadData();
            self.activityIndicator.stopAnimating();
            self.tableView.hidden = false;
            
            TFGStoreLogger.log(.StoreLoaded)
        };
        
        TFGStoreLogger.log(.OpenedStore)
    }
    
    // Close the store and return to previous activities
    func close(sender: AnyObject) {
        self.dismissViewControllerAnimated(false, completion: nil);
        TFGStoreLogger.log(.ClosedStore);
    }
    
    // MARK: TFGStoreTableCell delegate
    
    func selectedModel(model: TFGStoreItemModel) {
        let vc = TFGStoreItemVC();
        vc.model = model;
        self.navigationController?.pushViewController(vc, animated: true);
    }
    
    // MARK: Table View delegate and data source
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.modelArray.count;
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell : TFGStoreTableCell = self.tableView.dequeueReusableCellWithIdentifier("tfgstorecell") as! TFGStoreTableCell;
        
        cell.delegate = self;
        cell.model = self.modelArray[indexPath.row];

        return cell;
    }

    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return 84;
    }
    

}
