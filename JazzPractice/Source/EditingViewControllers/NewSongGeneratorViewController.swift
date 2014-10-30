//
//  NewSongGeneratorViewController.swift
//  JazzPractice
//
//  Created by Peter Livesey on 8/21/14.
//  Copyright (c) 2014 Peter Livesey. All rights reserved.
//

import UIKit

class NewSongGeneratorViewController: UIViewController, UIPickerViewDataSource, UIPickerViewDelegate {
  
  @IBOutlet var keyPickerView: UIPickerView!
  @IBOutlet var formPickerView: UIPickerView!
  
  weak var delegate: NewSongGeneratorDelegate?
  
  // TODO: Should be a class const
  let maxRepeats = 4
  
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
    let key = keyPickerView.selectedRowInComponent(0)
    let numberOfMeasures = numMeasures[keyPickerView.selectedRowInComponent(1)]
    let songForm = SongForm.allForms()[formPickerView.selectedRowInComponent(0)]
    let numberOfSections = songForm.numberOfSections()
    let numberOfRepeats = formPickerView.selectedRowInComponent(1) + 1
    
    let sections = MusicGenerator.generateSectionsWithKey(key, numberOfMeasures: numberOfMeasures, numberOfSections: numberOfSections)
    CurrentSongDataCenter.sharedInstance.currentSong = SongData(sections: sections, form: songForm, repeat: numberOfRepeats)
    
    delegate?.songGeneratorGeneratedNewSong(self)
  }
  
  // Picker View Delegate and Data Source
  
  func numberOfComponentsInPickerView(pickerView: UIPickerView) -> Int {
    return 2
  }
  
  func pickerView(pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
    if pickerView === keyPickerView {
      switch component {
      case 0:
        return 12
      case 1:
        return numMeasures.count
      default:
        return 0
      }
    } else {
      switch component {
      case 0:
        return SongForm.allForms().count
      case 1:
        return maxRepeats
      default:
        return 0
      }
    }
  }
  
  func pickerView(pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String {
    if pickerView === keyPickerView {
      switch component {
      case 0:
        let notes = ["C", "C#", "D", "Eb", "E", "F", "F#", "G", "Ab", "A", "Bb", "B"]
        return notes[row]
      case 1:
        return String(numMeasures[row])
      default:
        return ""
      }
    } else {
      switch component {
      case 0:
        let forms = SongForm.allForms()
        return forms[row].rawValue
      case 1:
        return String(row + 1)
      default:
        return ""
      }
    }
  }
}

protocol NewSongGeneratorDelegate: class {
  func songGeneratorGeneratedNewSong(songGenerator: NewSongGeneratorViewController)
}
