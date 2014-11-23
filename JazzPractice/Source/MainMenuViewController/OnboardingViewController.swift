//
//  OnboardingViewController.swift
//  JazzPractice
//
//  Created by Peter Livesey on 11/20/14.
//  Copyright (c) 2014 Peter Livesey. All rights reserved.
//

import UIKit

class OnboardingViewController: UIViewController {

  override init() {
    super.init(nibName: "OnboardingViewController", bundle: nil)
    
    title = "How To Use"
  }
  
  required init(coder: NSCoder) {
    super.init(coder: coder)
  }
}
