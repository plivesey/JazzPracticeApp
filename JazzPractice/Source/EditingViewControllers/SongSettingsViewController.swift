//
//  SongSettingsViewController.swift
//  JazzPractice
//
//  Created by Peter Livesey on 8/23/14.
//  Copyright (c) 2014 Peter Livesey. All rights reserved.
//

import UIKit

class SongSettingsViewController: UIViewController, UIPickerViewDelegate, UITableViewDelegate, UITableViewDataSource, UIPickerViewDataSource {
  
  var tempo: Int = 120 {
    didSet {
      tempo = tempo >= minTempo ? tempo : minTempo
      tempo = tempo <= maxTempo ? tempo : maxTempo
      if let pickerView = pickerView {
        pickerView.selectRow(tempo - minTempo, inComponent: 0, animated: false)
      }
    }
  }
  var mutedTracks: [(name: String, muted: Bool)] = []
  
  weak var delegate: SongSettingsDelegate?
  
  let minTempo = 40
  let maxTempo = 200
  
  // UI
  @IBOutlet var pickerView: UIPickerView!
  // Buttons
  @IBOutlet var soloMuteButton: UIButton!
  @IBOutlet var rhythmMuteButton: UIButton!
  @IBOutlet var bassMuteButton: UIButton!
  @IBOutlet var drumsMuteButton: UIButton!
  
  required init(coder aDecoder: NSCoder) {
    super.init(coder: aDecoder)
  }
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    title = "Settings"
    
    edgesForExtendedLayout = .None
    
    pickerView.selectRow(tempo - minTempo, inComponent: 0, animated: false)
    
    // Setup Mute Buttons
    if mutedTracks[0].muted {
      // Currently muted
      soloMuteButton.setImage(UIImage(named: "audioMute"), forState: .Normal)
    } else {
      soloMuteButton.setImage(UIImage(named: "audioUnmute"), forState: .Normal)
    }
    if mutedTracks[1].muted {
      // Currently muted
      rhythmMuteButton.setImage(UIImage(named: "audioMute"), forState: .Normal)
    } else {
      rhythmMuteButton.setImage(UIImage(named: "audioUnmute"), forState: .Normal)
    }
    if mutedTracks[2].muted {
      // Currently muted
      bassMuteButton.setImage(UIImage(named: "audioMute"), forState: .Normal)
    } else {
      bassMuteButton.setImage(UIImage(named: "audioUnmute"), forState: .Normal)
    }
    if mutedTracks[3].muted {
      // Currently muted
      drumsMuteButton.setImage(UIImage(named: "audioMute"), forState: .Normal)
    } else {
      drumsMuteButton.setImage(UIImage(named: "audioUnmute"), forState: .Normal)
    }
  }
  
  override func viewWillDisappear(animated: Bool) {
    let tempo = pickerView.selectedRowInComponent(0) + minTempo
    delegate?.songSettingsViewController(self, finishedWithTempo: tempo, mutedTracks: mutedTracks)
  }
  
  // Picker Delegate
  
  func numberOfComponentsInPickerView(pickerView: UIPickerView) -> Int {
    return 1
  }
  
  func pickerView(pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
    return maxTempo - minTempo + 1
  }
  
  func pickerView(pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String {
    return String(row + minTempo)
  }
  
  // Table view delegate
  
  func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return mutedTracks.count
  }
  
  func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
    let cell = tableView.dequeueReusableCellWithIdentifier("cell", forIndexPath: indexPath) as UITableViewCell
    cell.textLabel.text = mutedTracks[indexPath.row].name
    if mutedTracks[indexPath.row].muted {
      cell.accessoryType = .Checkmark
    } else {
      cell.accessoryType = .None
    }
    return cell
  }
  
  func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
    tableView.deselectRowAtIndexPath(indexPath, animated: true)
    let row = indexPath.row
    mutedTracks[row] = (mutedTracks[row].name, !mutedTracks[row].muted)
    
    let cell = tableView.cellForRowAtIndexPath(indexPath)
    if mutedTracks[row].muted {
      cell?.accessoryType = .Checkmark
    } else {
      cell?.accessoryType = .None
    }
  }
}

extension SongSettingsViewController {
  
  @IBAction func soloMuteButtonPressed(button: UIButton) {
    mutedTracks[0].muted = !mutedTracks[0].muted
    if mutedTracks[0].muted {
      // Currently muted
      soloMuteButton.setImage(UIImage(named: "audioMute"), forState: .Normal)
    } else {
      soloMuteButton.setImage(UIImage(named: "audioUnmute"), forState: .Normal)
    }
  }
  
  @IBAction func rhythmMuteButtonPressed(button: UIButton) {
    mutedTracks[1].muted = !mutedTracks[1].muted
    if mutedTracks[1].muted {
      // Currently muted
      rhythmMuteButton.setImage(UIImage(named: "audioMute"), forState: .Normal)
    } else {
      rhythmMuteButton.setImage(UIImage(named: "audioUnmute"), forState: .Normal)
    }
  }
  
  @IBAction func bassMuteButtonPressed(button: UIButton) {
    mutedTracks[2].muted = !mutedTracks[2].muted
    if mutedTracks[2].muted {
      // Currently muted
      bassMuteButton.setImage(UIImage(named: "audioMute"), forState: .Normal)
    } else {
      bassMuteButton.setImage(UIImage(named: "audioUnmute"), forState: .Normal)
    }
  }
  
  @IBAction func drumsMuteButtonPressed(button: UIButton) {
    mutedTracks[3].muted = !mutedTracks[3].muted
    if mutedTracks[3].muted {
      // Currently muted
      drumsMuteButton.setImage(UIImage(named: "audioMute"), forState: .Normal)
    } else {
      drumsMuteButton.setImage(UIImage(named: "audioUnmute"), forState: .Normal)
    }
  }
}

protocol SongSettingsDelegate: NSObjectProtocol {
  
  func songSettingsViewController(viewController: SongSettingsViewController, finishedWithTempo tempo: Int, mutedTracks: [(name: String, muted: Bool)])
}
