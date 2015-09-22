//
//  TFGStore.swift
//  TFGStore
//
//  Created by Ramon Carvalho Maciel on 9/20/15.
//  Copyright (c) 2015 Ramon Carvalho Maciel. All rights reserved.
//

import UIKit


// Single public class allowing to present the store view controller
@objc public class TFGStore :NSObject {
    
    // Presents TFGStore with custom parameters
    public static func present(viewController parent: UIViewController, jsonURL: String, parseKey: String, restApiKey: String, cloudFunction: String) {
        
        // Loads Parse parameters as log server
        TFGStoreLogger.loadParse(parseKey, restApiKey: restApiKey, cloudFunction: cloudFunction);
        
        let vc = TFGStoreVC();
        vc.jsonURLString = jsonURL;
        
        let nav = UINavigationController(rootViewController: vc);
        
        parent.presentViewController(nav, animated: false, completion: nil);
    }
    
    // Presents TFGStore with demonstration parameters
    public static func presentDemo(viewController parent: UIViewController) {
        TFGStore.present(viewController: parent, jsonURL: "https://storeparse.parseapp.com/storeapps.json",parseKey: "CZ4JUohdD3Z1xEXouwaKlx4sNxeAA9oJtnAv1WrX", restApiKey: "twmlIXOsmtXOnYFoWqKJuxcW3HVjtMQERa4SAdTW", cloudFunction: "addLogs");
    }
}