//
//  AppDelegate.swift
//  JazzPractice
//
//  Created by Peter Livesey on 7/25/14.
//  Copyright (c) 2014 Peter Livesey. All rights reserved.
//

import UIKit
// 3rd Party
import Armchair
import Crashlytics

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
                            
  var window: UIWindow?


  func application(application: UIApplication, didFinishLaunchingWithOptions launchOptions: NSDictionary) -> Bool {
    
    Crashlytics.startWithAPIKey("a2525f75879917ec4cffeeb16345f5aa9bbbeaeb")
    
    window = UIWindow(frame: UIScreen.mainScreen().bounds)
    let rootStoryBoard = UIStoryboard(name: "SectionsCollectionViewController", bundle: nil)
    let rootController = rootStoryBoard.instantiateInitialViewController() as UIViewController
    let navigationController = UINavigationController(rootViewController: rootController)
    window?.rootViewController = navigationController
    
    RootViewControllerProvider.sharedInstance.rootViewController = navigationController
    
    // Setup Armchair
    Armchair.appID("937982691")
    Armchair.significantEventsUntilPrompt(30)
    Armchair.daysUntilPrompt(21)
    Armchair.usesUntilPrompt(20)
    Armchair.daysBeforeReminding(5)
    Armchair.debugEnabled(false)
    
    window?.makeKeyAndVisible()
    
    return true
  }
}

