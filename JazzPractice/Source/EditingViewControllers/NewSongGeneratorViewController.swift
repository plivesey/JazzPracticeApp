//
//  NewSongGeneratorViewController.swift
//  JazzPractice
//
//  Created by Peter Livesey on 8/21/14.
//  Copyright (c) 2014 Peter Livesey. All rights reserved.
//

import UIKit

class NewSongGeneratorViewController: UIViewController, UIPickerViewDataSource, UIPickerViewDelegate {
  
  @IBOutlet var pickerView: UIPickerView!
  
  // TODO: Should be weak
  var delegate: NewSongGeneratorDelegate?
  
  let numMeasures: [Int] = {
    var measures: [Int] = []
    for i in 0..<8 {
      measures.append(i*4 + 8)
    }
    return measures
  }()
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    edgesForExtendedLayout = .None
  }
  
  @IBAction func generateTapped() {
    let key = pickerView.selectedRowInComponent(0)
    let numberOfMeasures = numMeasures[pickerView.selectedRowInComponent(1)]
    CurrentSongDataCenter.sharedInstance.currentSong = MusicGenerator.generateSections(key: key, numberOfMeasures: numberOfMeasures)
    
    delegate?.songGeneratorGeneratedNewSong(self)
  }
  
  // Picker View Delegate and Data Source
  
  func numberOfComponentsInPickerView(pickerView: UIPickerView!) -> Int {
    return 2
  }
  
  func pickerView(pickerView: UIPickerView!, numberOfRowsInComponent component: Int) -> Int {
    switch component {
    case 0:
      return 12
    case 1:
      return numMeasures.count
    default:
      return 0
    }
  }
  
  func pickerView(pickerView: UIPickerView!, titleForRow row: Int, forComponent component: Int) -> String! {
    switch component {
    case 0:
      let notes = ["C", "C#", "D", "Eb", "E", "F", "F#", "G", "Ab", "A", "Bb", "B"]
      return notes[row]
    case 1:
      return String(numMeasures[row])
    default:
      return ""
    }
  }
}

protocol NewSongGeneratorDelegate {
  func songGeneratorGeneratedNewSong(songGenerator: NewSongGeneratorViewController)
}
