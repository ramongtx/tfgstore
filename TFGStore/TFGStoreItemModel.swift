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
    var storeLink = "";
    var screenshotsURLs = Array<String>();
    
    static func arrayFromJson (json : NSDictionary) -> Array<TFGStoreItemModel> {
        var array = Array<TFGStoreItemModel>();
        if let appsArray = json["apps"] as? NSArray {
            for app in appsArray {
                if let obj = app as? NSDictionary {
                    var model = TFGStoreItemModel(json: obj);
                    array.append(model);
                }
            }
            
        }
        return array;
    }
    
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
                        self.storeLink = string;
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
    
    static func arrayFromURL (urlString : String) -> Array<TFGStoreItemModel> {
        if let url = NSURL(string: urlString) {
            if let data = NSData(contentsOfURL: url) {
                var error: NSError?
                if let jsonDictionary: NSDictionary = NSJSONSerialization.JSONObjectWithData(data, options: NSJSONReadingOptions.MutableContainers, error: &error) as? NSDictionary{
                    return arrayFromJson(jsonDictionary);
                }
            }
        }
        return Array<TFGStoreItemModel>();
    }
    
    static func arrayFromURLAsync (urlString : String, completionHandler : (array: Array<TFGStoreItemModel>) -> Void) {
        let priority = DISPATCH_QUEUE_PRIORITY_DEFAULT
        dispatch_async(dispatch_get_global_queue(priority, 0)) {
            var array = self.arrayFromURL(urlString);
            dispatch_async(dispatch_get_main_queue()) {
                completionHandler(array: array);
            }
        }
    }
}