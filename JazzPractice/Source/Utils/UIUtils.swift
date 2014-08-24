//
//  UIUtils.swift
//  JazzPractice
//
//  Created by Peter Livesey on 8/23/14.
//  Copyright (c) 2014 Peter Livesey. All rights reserved.
//

import UIKit

class UIUtils {
  
  class func viewControllerNamed(name: String) -> UIViewController {
    let controller = UIStoryboard(name: name, bundle: nil).instantiateInitialViewController() as UIViewController
    return controller
  }
  
  class func modalViewControllerNamed(name: String) -> UINavigationController {
    return UINavigationController(rootViewController: viewControllerNamed(name))
  }
}
