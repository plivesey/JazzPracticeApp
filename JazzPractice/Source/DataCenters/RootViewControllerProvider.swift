//
//  RootViewControllerProvider.swift
//  JazzPractice
//
//  Created by Peter Livesey on 11/20/14.
//  Copyright (c) 2014 Peter Livesey. All rights reserved.
//

import UIKit

class RootViewControllerProvider: NSObject {
  
  var rootViewController: UIViewController?
  
  class var sharedInstance:RootViewControllerProvider {
    get {
      struct StaticRootViewControllerProvider {
        static let instance : RootViewControllerProvider = RootViewControllerProvider()
      }
      
      return StaticRootViewControllerProvider.instance
    }
  }
  
  func presentViewController(viewController: UINavigationController) {
    rootViewController?.presentViewController(viewController, animated: true, completion: nil)
  }
  
  func presentViewController(viewController: UIViewController) {
    let navigationController = UINavigationController(rootViewController: viewController)
    let cancelButton = UIBarButtonItem(title: "Cancel", style: UIBarButtonItemStyle.Done, target: self, action: "dismissViewController")
    viewController.navigationItem.leftBarButtonItem = cancelButton
    rootViewController?.presentViewController(navigationController, animated: true, completion: nil)
  }
  
  func dismissViewController() {
    rootViewController?.dismissViewControllerAnimated(true, completion: nil)
  }
}
