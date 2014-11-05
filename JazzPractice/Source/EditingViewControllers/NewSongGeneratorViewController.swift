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
    for i in 0..<5 {
      measures.append(i*4 + 8)
    }
    return measures
  }()
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    edgesForExtendedLayout = .None
    
    keyPickerView.selectRow(1, inComponent: 0, animated: false)
    keyPickerView.selectRow(1, inComponent: 1, animated: false)
    formPickerView.selectRow(1, inComponent: 0, animated: false)
    formPickerView.selectRow(1, inComponent: 1, animated: false)
  }
  
  @IBAction func generateTapped() {
    let key = keyPickerView.selectedRowInComponent(0) - 1
    let numberOfMeasures = numMeasures[keyPickerView.selectedRowInComponent(1) - 1]
    let songForm = SongForm.allForms()[formPickerView.selectedRowInComponent(0) - 1]
    let numberOfSections = songForm.numberOfSections()
    let numberOfRepeats = formPickerView.selectedRowInComponent(1)
    
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
        return 13
      case 1:
        return numMeasures.count + 1
      default:
        return 0
      }
    } else {
      switch component {
      case 0:
        return SongForm.allForms().count + 1
      case 1:
        return maxRepeats + 1
      default:
        return 0
      }
    }
  }
  
  func pickerView(pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String {
    if row == 0 {
      // It's a title row
      if pickerView == keyPickerView {
        if component == 0 {
          return "Key"
        } else {
          return "# Measures"
        }
      } else {
        if component == 0 {
          return "Song Form"
        } else {
          return "# Repeats"
        }
      }
    }
    if pickerView === keyPickerView {
      switch component {
      case 0:
        let notes = ["C", "C#", "D", "Eb", "E", "F", "F#", "G", "Ab", "A", "Bb", "B"]
        return notes[row - 1]
      case 1:
        return String(numMeasures[row - 1])
      default:
        return ""
      }
    } else {
      switch component {
      case 0:
        let forms = SongForm.allForms()
        return forms[row - 1].rawValue
      case 1:
        return String(row)
      default:
        return ""
      }
    }
  }
}

protocol NewSongGeneratorDelegate: class {
  func songGeneratorGeneratedNewSong(songGenerator: NewSongGeneratorViewController)
}
