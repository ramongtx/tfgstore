//
//  TFGStoreItemModel.swift
//  TFGStore
//
//  Created by Ramon Carvalho Maciel on 9/18/15.
//  Copyright (c) 2015 Ramon Carvalho Maciel. All rights reserved.
//

import Foundation

class TFGStoreItemModel {
    var position = 0;
    var appName = "";
    var description = "";
    var iconURL = "";
    var storeId = "";
    var screenshotsURLs = Array<String>();
    
    // Initializer using a JSON dictionary
    init (json : NSDictionary) {
        for (key, value) in json {
            if let keyString = key as? String {
                switch keyString {
                case "name":
                    if let string = value as? String {
                        self.appName = string;
                    }
                case "icon":
                    if let string = value as? String {
                        self.iconURL = string;
                    }
                case "description":
                    if let string = value as? String {
                        self.description = string;
                    }
                case "link":
                    if let string = value as? String {
                        self.storeId = string;
                    }
                case "screenshots":
                    if let screenshotArray = value as? Array<String> {
                        for screenLink in screenshotArray {
                            self.screenshotsURLs.append(screenLink)
                        }
                    }
                default: ()
                }
            }
        }
    }
    
    // Loads an array of TFGStoreItemModel from an URL asynchronously, calling arrayFromURL in the background
    static func arrayFromURLAsync (urlString : String, completionHandler : (array: Array<TFGStoreItemModel>) -> Void) {
        let priority = DISPATCH_QUEUE_PRIORITY_DEFAULT
        dispatch_async(dispatch_get_global_queue(priority, 0)) {
            let array = self.arrayFromURL(urlString);
            dispatch_async(dispatch_get_main_queue()) {
                completionHandler(array: array);
            }
        }
    }
    
    // Loads an array of TFGStoreItemModel from an URL synchronously, calling arrayFromJson to build the array
    // If there is any error during the downloading of the file, an empty array will be returned
    static func arrayFromURL (urlString : String) -> Array<TFGStoreItemModel> {
        if let url = NSURL(string: urlString) {
            if let data = NSData(contentsOfURL: url) {
                do {
                    if let jsonDictionary: NSDictionary = try NSJSONSerialization.JSONObjectWithData(data, options: NSJSONReadingOptions.MutableContainers) as? NSDictionary{
                        return arrayFromJson(jsonDictionary);
                    }
                } catch {
                    
                }
            }
        }
        return Array<TFGStoreItemModel>();
    }
    
    // Loads an array of TFGStoreItemModel from a JSON dictionary describing such array.
    // If there is any error during the evaluation of the array, an incomplete or empty array will be returned
    static func arrayFromJson (json : NSDictionary) -> Array<TFGStoreItemModel> {
        var array = Array<TFGStoreItemModel>();
        var pos = 1;
        if let appsArray = json["apps"] as? NSArray {
            for app in appsArray {
                if let obj = app as? NSDictionary {
                    let model = TFGStoreItemModel(json: obj);
                    model.position = pos;
                    pos++;
                    array.append(model);
                }
            }
            
        }
        return array;
    }
}