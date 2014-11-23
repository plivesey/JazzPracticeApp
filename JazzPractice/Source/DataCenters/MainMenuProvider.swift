//
//  MainMenuProvider.swift
//  JazzPractice
//
//  Created by Peter Livesey on 11/20/14.
//  Copyright (c) 2014 Peter Livesey. All rights reserved.
//

import UIKit
import MessageUI
import Armchair

class MainMenuProvider: NSObject, UIActionSheetDelegate {
  
  class var sharedInstance:MainMenuProvider {
    get {
      struct StaticMainMenuProvider {
        static let instance : MainMenuProvider = MainMenuProvider()
      }
      
      return StaticMainMenuProvider.instance
    }
  }
  
  enum MenuOption: Int {
    // Cancel is 0
    case Feedback = 1
    case HowToUser = 2
    case AlgorithmDetails = 3
    case RateTheApp = 4
    
    static func titles() -> [String] {
      return ["Feedback", "How to Use the App", "Algorithm Details", "Rate the App" ]
    }
  }
  
  func menuActionSheet() -> UIActionSheet {
    let actionSheet = UIActionSheet(title: "Menu", delegate: self, cancelButtonTitle: "Cancel", destructiveButtonTitle: nil)
    for title in MenuOption.titles() {
      actionSheet.addButtonWithTitle(title)
    }
    return actionSheet
  }
  
  func sendFeedbackEmail() {
    if MFMailComposeViewController.canSendMail() {
      let composeViewController = MFMailComposeViewController()
      composeViewController.mailComposeDelegate = self
      composeViewController.setToRecipients([ NSString(string: "comboapp@gmail.com") ])
      composeViewController.setSubject("Combo App Feedback")
      RootViewControllerProvider.sharedInstance.presentViewController(composeViewController)
    } else {
      UIAlertView(title: "Unable to send email", message: "For some reason, your device can't send email. Perhaps you haven't set it up yet?", delegate: nil, cancelButtonTitle: "OK").show()
    }
  }

  func actionSheet(actionSheet: UIActionSheet, clickedButtonAtIndex buttonIndex: Int) {
    let menuOption = MenuOption(rawValue: buttonIndex)
    if let menuOption = menuOption {
      switch menuOption {
      case .Feedback:
        sendFeedbackEmail()
      case .HowToUser:
        let onboardingViewController = OnboardingViewController()
        RootViewControllerProvider.sharedInstance.presentViewController(onboardingViewController)
      case .AlgorithmDetails:
        let algorithmViewController = AlgorithmViewController()
        RootViewControllerProvider.sharedInstance.presentViewController(algorithmViewController)
      case .RateTheApp:
        Armchair.rateApp()
      }
    }
  }
}

extension MainMenuProvider: MFMailComposeViewControllerDelegate {
  func mailComposeController(controller: MFMailComposeViewController!, didFinishWithResult result: MFMailComposeResult, error: NSError!) {
    if result.value == MFMailComposeResultFailed.value {
      UIAlertView(title: "Operation Failed", message: "Email failed to send or save. Please check your internet connection and try again.", delegate: nil, cancelButtonTitle: "OK").show()
    } else {
      RootViewControllerProvider.sharedInstance.dismissViewController()
    }
  }
}
