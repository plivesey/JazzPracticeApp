//
//  AppDelegate.swift
//  JazzPractice
//
//  Created by Peter Livesey on 7/25/14.
//  Copyright (c) 2014 Peter Livesey. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
                            
  var window: UIWindow?


  func application(application: UIApplication!, didFinishLaunchingWithOptions launchOptions: NSDictionary!) -> Bool {
    
    window = UIWindow(frame: UIScreen.mainScreen().bounds)
    let rootStoryBoard = UIStoryboard(name: "SectionsCollectionViewController", bundle: nil)
    let rootController = rootStoryBoard.instantiateInitialViewController() as UIViewController
    let navigationController = UINavigationController(rootViewController: rootController)
    window!.rootViewController = navigationController
    window?.makeKeyAndVisible()
    
    return true
  }
}

