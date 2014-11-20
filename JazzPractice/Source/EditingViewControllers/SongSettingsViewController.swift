//
//  SongSettingsViewController.swift
//  JazzPractice
//
//  Created by Peter Livesey on 8/23/14.
//  Copyright (c) 2014 Peter Livesey. All rights reserved.
//

import UIKit
import JazzMusicGenerator

class SongSettingsViewController: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource {
  
  var tempo: Int = 120 {
    didSet {
      tempo = tempo >= minTempo ? tempo : minTempo
      tempo = tempo <= maxTempo ? tempo : maxTempo
      if let pickerView = pickerView {
        pickerView.selectRow(tempo - minTempo, inComponent: 0, animated: false)
      }
    }
  }
  var tracks: [(name: String, muted: Bool, instrument: PLMusicPlayer.InstrumentType)] = []
  
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
  @IBOutlet var soloInstrumentButton: UIButton!
  @IBOutlet var rhythmInstrumentButton: UIButton!
  
  required init(coder aDecoder: NSCoder) {
    super.init(coder: aDecoder)
  }
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    title = "Settings"
    
    edgesForExtendedLayout = .None
    
    pickerView.selectRow(tempo - minTempo, inComponent: 0, animated: false)
    
    // Setup Mute Buttons
    if tracks[0].muted {
      // Currently muted
      soloMuteButton.setImage(UIImage(named: "audioMute"), forState: .Normal)
    } else {
      soloMuteButton.setImage(UIImage(named: "audioUnmute"), forState: .Normal)
    }
    if tracks[1].muted {
      // Currently muted
      rhythmMuteButton.setImage(UIImage(named: "audioMute"), forState: .Normal)
    } else {
      rhythmMuteButton.setImage(UIImage(named: "audioUnmute"), forState: .Normal)
    }
    if tracks[2].muted {
      // Currently muted
      bassMuteButton.setImage(UIImage(named: "audioMute"), forState: .Normal)
    } else {
      bassMuteButton.setImage(UIImage(named: "audioUnmute"), forState: .Normal)
    }
    if tracks[3].muted {
      // Currently muted
      drumsMuteButton.setImage(UIImage(named: "audioMute"), forState: .Normal)
    } else {
      drumsMuteButton.setImage(UIImage(named: "audioUnmute"), forState: .Normal)
    }
    
    soloInstrumentButton.setTitle(tracks[0].instrument.description, forState: .Normal)
    rhythmInstrumentButton.setTitle(tracks[1].instrument.description, forState: .Normal)
  }
  
  override func viewWillDisappear(animated: Bool) {
    super.viewWillDisappear(animated)
    let tempo = pickerView.selectedRowInComponent(0) + minTempo
    delegate?.songSettingsViewController(self, finishedWithTempo: tempo, tracks: tracks)
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
}

extension SongSettingsViewController {
  
  @IBAction func soloMuteButtonPressed(button: UIButton) {
    tracks[0].muted = !tracks[0].muted
    if tracks[0].muted {
      // Currently muted
      soloMuteButton.setImage(UIImage(named: "audioMute"), forState: .Normal)
    } else {
      soloMuteButton.setImage(UIImage(named: "audioUnmute"), forState: .Normal)
    }
  }
  
  @IBAction func rhythmMuteButtonPressed(button: UIButton) {
    tracks[1].muted = !tracks[1].muted
    if tracks[1].muted {
      // Currently muted
      rhythmMuteButton.setImage(UIImage(named: "audioMute"), forState: .Normal)
    } else {
      rhythmMuteButton.setImage(UIImage(named: "audioUnmute"), forState: .Normal)
    }
  }
  
  @IBAction func bassMuteButtonPressed(button: UIButton) {
    tracks[2].muted = !tracks[2].muted
    if tracks[2].muted {
      // Currently muted
      bassMuteButton.setImage(UIImage(named: "audioMute"), forState: .Normal)
    } else {
      bassMuteButton.setImage(UIImage(named: "audioUnmute"), forState: .Normal)
    }
  }
  
  @IBAction func drumsMuteButtonPressed(button: UIButton) {
    tracks[3].muted = !tracks[3].muted
    if tracks[3].muted {
      // Currently muted
      drumsMuteButton.setImage(UIImage(named: "audioMute"), forState: .Normal)
    } else {
      drumsMuteButton.setImage(UIImage(named: "audioUnmute"), forState: .Normal)
    }
  }
}

extension SongSettingsViewController {
  func nextSoloInstrument() -> PLMusicPlayer.InstrumentType {
    switch tracks[0].instrument {
    case .Piano:
      return .Sax
    case .Sax:
      return .Guitar
    case .Guitar:
      return .Trombone
    case .Trombone:
      return .Piano
    case .Bass:
      assert(false)
      return .Piano
    case .Drums:
      assert(false)
      return .Piano
    }
  }
  
  func nextRhythmInstrument() -> PLMusicPlayer.InstrumentType {
    switch tracks[1].instrument {
    case .Piano:
      return .Guitar
    case .Guitar:
      return .Piano
    case .Trombone:
      assert(false)
      return .Piano
    case .Sax:
      assert(false)
      return .Piano
    case .Bass:
      assert(false)
      return .Piano
    case .Drums:
      assert(false)
      return .Piano
    }
  }
  
  @IBAction func changeSoloInstrumentTapped() {
    let newInstrument = nextSoloInstrument()
    tracks[0].instrument = newInstrument
    soloInstrumentButton.setTitle(newInstrument.description, forState: .Normal)
  }
  
  @IBAction func changeRhythmInstrumentTapped() {
    let newInstrument = nextRhythmInstrument()
    tracks[1].instrument = newInstrument
    rhythmInstrumentButton.setTitle(newInstrument.description, forState: .Normal)
  }
}

protocol SongSettingsDelegate: NSObjectProtocol {
  
  func songSettingsViewController(viewController: SongSettingsViewController, finishedWithTempo tempo: Int, tracks: [(name: String, muted: Bool, instrument: PLMusicPlayer.InstrumentType)])
}
