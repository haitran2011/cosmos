//
//  Logger.swift
//  cosmos
//
//  Created by Tue Nguyen on 4/15/16.
//  Copyright © 2016 Savvycom. All rights reserved.
//

import Foundation
import XCGLogger


let LogFolderPath = NSTemporaryDirectory().stringByAppendingPathComponent("logs")

private let log = XCGLogger.default

public func LoggerSetup() {

#if PROD
    let logLevel = XCGLogger.Level.none;
#else
    let logLevel = XCGLogger.Level.debug;
#endif
    //Create log folder if need
    let dateFormatter = DateFormatter()
    dateFormatter.dateFormat = "yyyy-MM-dd HH.mm.sss"
    let logFileName = "app.logs"
    let rotateFileName = String("app-\(dateFormatter.string(from: Date())).logs")!
    
    
    try? FileManager.default.createDirectory(atPath: LogFolderPath, withIntermediateDirectories: true, attributes: nil)
    
    let logFile = LogFolderPath.stringByAppendingPathComponent(logFileName)
    let rotateLogFile = LogFolderPath.stringByAppendingPathComponent(rotateFileName)
    
    log.setup(level: logLevel, showLogIdentifier: true, showFunctionName: true, showThreadName: false, showLevel: true, showFileNames: true, showLineNumbers: true, showDate: true, writeToFile: logFile, fileLevel: logLevel)
    
    if let fileLogDestination = log.destination(withIdentifier: XCGLogger.Constants.fileDestinationIdentifier) as? FileDestination {
        fileLogDestination.rotateFile(to: rotateLogFile)
    }
}

public func LoggerAllLogFiles() -> [String] {
    let fileManager = FileManager()
    
    if let contents = try? fileManager.contentsOfDirectory(atPath: LogFolderPath) {
        var allFiles = [String]()
        
        for fileName in contents {
            let fullPath = LogFolderPath.stringByAppendingPathComponent(fileName)
            allFiles.append(fullPath)
        }
        return allFiles
    } else {
        return [String]()
    }
    
}

public func LogDebug(_ closure: @autoclosure @escaping () -> Any?, functionName: StaticString = #function, fileName: StaticString = #file, lineNumber: Int = #line, userInfo: [String: Any] = [:]) {
    log.logln(.debug, functionName: functionName, fileName: fileName, lineNumber: lineNumber, userInfo: userInfo, closure: closure)
}
public func LogVerbose(_ closure: @autoclosure @escaping () -> Any?, functionName: StaticString = #function, fileName: StaticString = #file, lineNumber: Int = #line, userInfo: [String: Any] = [:]) {
    log.logln(.verbose, functionName: functionName, fileName: fileName, lineNumber: lineNumber, userInfo: userInfo, closure: closure)
}
public func LogInfo(_ closure: @autoclosure @escaping () -> Any?, functionName: StaticString = #function, fileName: StaticString = #file, lineNumber: Int = #line, userInfo: [String: Any] = [:]) {
    log.logln(.info, functionName: functionName, fileName: fileName, lineNumber: lineNumber, userInfo: userInfo, closure: closure)
}
public func LogWarn(_ closure: @autoclosure @escaping () -> Any?, functionName: StaticString = #function, fileName: StaticString = #file, lineNumber: Int = #line, userInfo: [String: Any] = [:]) {
    log.logln(.warning, functionName: functionName, fileName: fileName, lineNumber: lineNumber, userInfo: userInfo, closure: closure)
}
public func LogError(_ closure: @autoclosure @escaping () -> Any?, functionName: StaticString = #function, fileName: StaticString = #file, lineNumber: Int = #line, userInfo: [String: Any] = [:]) {
    log.logln(.error, functionName: functionName, fileName: fileName, lineNumber: lineNumber, userInfo: userInfo, closure: closure)
}
