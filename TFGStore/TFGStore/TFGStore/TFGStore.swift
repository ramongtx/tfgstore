//
//  TFGStore.swift
//  TFGStore
//
//  Created by Ramon Carvalho Maciel on 9/20/15.
//  Copyright (c) 2015 Ramon Carvalho Maciel. All rights reserved.
//

import UIKit

class TFGStore {
    static func present(viewController parent: UIViewController, jsonURL: String, parseKey: String, restApiKey: String, cloudFunction: String) {
        TFGStoreLogger.loadParse(parseKey, restApiKey: restApiKey, cloudFunction: cloudFunction);
        
        let vc = TFGStoreVC();
        vc.jsonURLString = jsonURL;
        
        let nav = UINavigationController(rootViewController: vc);
        
        parent.presentViewController(nav, animated: false, completion: nil);
    }
}