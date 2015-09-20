//
//  TFGStoreLogger.swift
//  TFGStore
//
//  Created by Ramon Carvalho Maciel on 9/20/15.
//  Copyright (c) 2015 Ramon Carvalho Maciel. All rights reserved.
//

import Foundation


// Basic log row
internal class TFGStoreLogModel {
    var id = "";
    var timestamp = 0;
    var details = "";
}

class TFGStoreLogger {
    
    // Logbook
    static var logs = Array<TFGStoreLogModel>();
    
    // Add a simple log to logbook
    static func log(details: String) {
        var logModel = TFGStoreLogModel();
        logModel.details = details;
        logs.append(logModel);
    }
}