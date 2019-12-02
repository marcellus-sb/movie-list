//
//  main.swift
//  movie-list
//
//  Created by Marcellus Selga Batista on 02/12/19.
//  Copyright © 2019 Marcellus Selga Batista. All rights reserved.
//

import UIKit

let kIsRunningTests = NSClassFromString("XCTestCase") != nil
let kAppDelegateClass = kIsRunningTests ? nil : NSStringFromClass(AppDelegate.self)

UIApplicationMain(CommandLine.argc, CommandLine.unsafeArgv, nil, kAppDelegateClass)
