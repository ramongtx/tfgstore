//
//  TFGStore.swift
//  TFGStore
//
//  Created by Ramon Carvalho Maciel on 9/20/15.
//  Copyright (c) 2015 Ramon Carvalho Maciel. All rights reserved.
//

import UIKit

class TFGStore {
    static func present(parent : UIViewController, jsonURL: String, parseKey: String = "ibawDAvKXgvp2vxj0cZqGS9HOS8U2JzMOPO0qy3a", restApiKey: String = "bFBfgU5XKQ62HNCdVhfwg3w7yWN5yi8yqtNOesdm", cloudFunction: String = "hello") {
        TFGStoreLogger.loadParse(parseKey, restApiKey: restApiKey, cloudFunction: cloudFunction);
        
        let vc = TFGStoreVC();
        vc.jsonURLString = jsonURL;
        
        let nav = UINavigationController(rootViewController: vc);
        
        parent.presentViewController(nav, animated: false, completion: nil);
    }
}