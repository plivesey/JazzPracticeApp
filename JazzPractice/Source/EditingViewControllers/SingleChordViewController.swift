//
//  SingleChordViewController.swift
//  JazzPractice
//
//  Created by Peter Livesey on 7/25/14.
//  Copyright (c) 2014 Peter Livesey. All rights reserved.
//

import UIKit

protocol SingleChordViewControllerDelegate {
  func chordsViewController(_: SingleChordViewController, updatedToNewChords: ChordMeasure)
}

class SingleChordViewController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate, UIPickerViewDataSource, UIPickerViewDelegate {
  
  var delegate: SingleChordViewControllerDelegate?
  
  @IBOutlet var collectionView: UICollectionView!
  
  // Pickers
  @IBOutlet var rootPickerView: UIPickerView!
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    edgesForExtendedLayout = UIRectEdge.None
    
    let saveButton = UIBarButtonItem(title: "Save", style: UIBarButtonItemStyle.Done, target: self, action: "saveTapped")
    navigationItem.rightBarButtonItem = saveButton
  }
  
  func saveTapped() {
    let keyInt = rootPickerView.selectedRowInComponent(0)
    let scale = rootPickerView.selectedRowInComponent(1)
    let key = ChordFactory.CBasedNote.fromRaw(keyInt)!
    let newChord = ChordFactory.genericChord(key: key, scaleDegree: scale)
    delegate?.chordsViewController(self, updatedToNewChords: ChordMeasure(chords: [(newChord, 4)]))
  }
  
  func collectionView(collectionView: UICollectionView!, numberOfItemsInSection section: Int) -> Int {
    return CurrentSongDataCenter.sharedInstance.currentSong.count
  }
  
  // The cell that is returned must be retrieved from a call to -dequeueReusableCellWithReuseIdentifier:forIndexPath:
  func collectionView(collectionView: UICollectionView!, cellForItemAtIndexPath indexPath: NSIndexPath!) -> UICollectionViewCell! {
    let cell = collectionView.dequeueReusableCellWithReuseIdentifier("cell", forIndexPath: indexPath) as UICollectionViewCell
    return cell
  }
  
  func pickerView(pickerView: UIPickerView!, numberOfRowsInComponent component: Int) -> Int {
    switch component {
    case 0:
      return 12
    case 1:
      return 7
    default:
      return 0
    }
  }

  // Picker Views
  func numberOfComponentsInPickerView(pickerView: UIPickerView!) -> Int {
    return 2
  }
  
  func pickerView(pickerView: UIPickerView!, titleForRow row: Int, forComponent component: Int) -> String! {
    switch component {
    case 0:
      let notes = ["C", "C#", "D", "Eb", "E", "F", "F#", "G", "Ab", "A", "Bb", "B"]
      return notes[row]
    case 1:
      return "\(row+1)"
    default:
      return ""
    }
  }
}
