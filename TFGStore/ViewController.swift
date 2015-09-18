//
//  ViewController.swift
//  TFGStore
//
//  Created by Ramon Carvalho Maciel on 9/17/15.
//  Copyright (c) 2015 Ramon Carvalho Maciel. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func click(sender: AnyObject) {
        TFGStoreVC.present(self, url: "");
    }
}

