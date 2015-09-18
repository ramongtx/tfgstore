//
//  TFGStoreVC.swift
//  TFGStore
//
//  Created by Ramon Carvalho Maciel on 9/17/15.
//  Copyright (c) 2015 Ramon Carvalho Maciel. All rights reserved.
//

import UIKit

class TFGStoreVC: UIViewController {
    
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

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func goNext(sender: AnyObject) {
        let vc = TFGStoreItemVC();
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    func back(sender: AnyObject) {
        self.dismissViewControllerAnimated(false, completion: nil);
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
