//
//  TFGStore.swift
//  TFGStore
//
//  Created by Ramon Carvalho Maciel on 9/20/15.
//  Copyright (c) 2015 Ramon Carvalho Maciel. All rights reserved.
//

import UIKit

class TFGStore {
    static func present(parent : UIViewController, url: String) {
        let vc = TFGStoreVC();
        vc.jsonURLString = url;
        
        let nav = UINavigationController(rootViewController: vc);
        
        parent.presentViewController(nav, animated: false, completion: nil);
    }
}