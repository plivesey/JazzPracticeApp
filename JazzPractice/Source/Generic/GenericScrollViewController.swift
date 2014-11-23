//
//  GenericScrollViewController.swift
//  JazzPractice
//
//  Created by Peter Livesey on 11/20/14.
//  Copyright (c) 2014 Peter Livesey. All rights reserved.
//

import UIKit

class GenericScrollViewController: UIViewController {

  @IBOutlet weak var scrollView: UIScrollView!
  
  init(contentView: UIView) {
    scrollView.contentSize = contentView.frame.size
    scrollView.addSubview(contentView)
    
    super.init(nibName: "GenericScrollViewController", bundle: nil)
  }
  
  required init(coder: NSCoder) {
    super.init(coder: coder)
  }
}
