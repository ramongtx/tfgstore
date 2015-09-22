//
//  TFGStoreLogger.swift
//  TFGStore
//
//  Created by Ramon Carvalho Maciel on 9/20/15.
//  Copyright (c) 2015 Ramon Carvalho Maciel. All rights reserved.
//

import Foundation
import AdSupport

// Events we are watching for
enum TFGStoreLogEvent {
    case None
    case OpenedStore
    case StoreLoaded
    case ClosedStore
    case AppLandingPage(String, Int)        // (AppId, AppPos)
    case Downloaded(String, Int)            // (AppId, AppPos)
    case ClosedAppLandingPage(String,Int)   // (AppId, AppPos)
    case Other(String)                      // (details)
}

// Basic log row
private class TFGStoreLogModel {
    var event : TFGStoreLogEvent = .None;
    var timestamp : Int = 0;
}

class TFGStoreLogger {
    
    private static var kAppId : String?;
    private static var kRestAPIKey : String?;
    private static var kCloudFunction : String?;
    
    // Load log server info
    static func loadParse(appId : String, restApiKey : String, cloudFunction: String) {
        kAppId = appId;
        kRestAPIKey = restApiKey;
        kCloudFunction = cloudFunction;
    }
    
    // Logbook
    private static var logs = Array<TFGStoreLogModel>();
    
    // Add a simple log to logbook
    static func log(event: TFGStoreLogEvent) {
        let logModel = TFGStoreLogModel();
        logModel.timestamp = Int(NSDate().timeIntervalSince1970);
        logModel.event = event;
        logs.append(logModel);
        
        // When closing the store, send logs to server
        switch event {
        case .ClosedStore:
            uploadToServer();
            logs.removeAll(keepCapacity: false);
        default: ()
        }
    }
    
    // Get advertising identifier if advertising tracking is enabled in the device
    private static func advertisingIdentifier() -> NSUUID? {
        let manager = ASIdentifierManager.sharedManager() as ASIdentifierManager;
        if manager.advertisingTrackingEnabled {
            return manager.advertisingIdentifier;
        }
        return nil;
    }
    
    // Transforms current log on Parse-ready JSON dictionary
    private static func logsDictionary () -> [String: AnyObject] {
        var array = [NSDictionary]();
        var id = "";
        if let adId = advertisingIdentifier() {
            id = adId.UUIDString;
        }
        for log in logs {
            let logJson: NSMutableDictionary = ["time": log.timestamp];
            switch log.event {
            case .None:
                logJson["eventType"] = 0;
            case .OpenedStore:
                logJson["eventType"] = 1;
            case .StoreLoaded:
                logJson["eventType"] = 2;
            case .ClosedStore:
                logJson["eventType"] = 3;
            case .AppLandingPage(let appId, let appPos):
                logJson["eventType"] = 4;
                logJson["appId"] = appId;
                logJson["appPos"] = appPos;
            case .Downloaded(let appId, let appPos):
                logJson["eventType"] = 5;
                logJson["appId"] = appId;
                logJson["appPos"] = appPos;
            case .ClosedAppLandingPage(let appId, let appPos):
                logJson["eventType"] = 6;
                logJson["appId"] = appId;
                logJson["appPos"] = appPos;
            case .Other(let details):
                logJson["eventType"] = 7;
                logJson["details"] = details;
            }
            array.append(logJson);
        }
        let json : [String: AnyObject] = ["events" : array, "id": id];
        return json;
    }
    
    // Uploads logs to Parse server
    private static func uploadToServer() {
        if let cloudFunction = kCloudFunction, let appId = kAppId, let restApiKey = kRestAPIKey {
            let jsonString = try? NSJSONSerialization.dataWithJSONObject(logsDictionary(), options: []);
            
            let request = NSMutableURLRequest()
            request.HTTPMethod = "POST"
            request.addValue(appId, forHTTPHeaderField: "X-Parse-Application-Id")
            request.addValue(restApiKey, forHTTPHeaderField: "X-Parse-REST-API-Key")
            request.addValue("application/json", forHTTPHeaderField: "Content-Type")
            request.HTTPBody = jsonString;
            
            let urlString = "https://api.parse.com/1/functions/\(cloudFunction)"
            let requestURL = NSURL(string: urlString)
            
            request.URL = requestURL!
            
            let task = NSURLSession.sharedSession().dataTaskWithRequest(request, completionHandler: { (data, response, error) -> Void in
                if error != nil {
                    print("Error sending logs to server: \(error)");
                }
                if let resp = response as? NSHTTPURLResponse {
                    print("Response from sending logs to server: \(resp.statusCode) : \(NSHTTPURLResponse.localizedStringForStatusCode(resp.statusCode))");
                }
            });
            
            task.resume()
        }
    }
}