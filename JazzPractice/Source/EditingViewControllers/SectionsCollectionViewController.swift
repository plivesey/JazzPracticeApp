//
//  SectionsCollectionViewController.swift
//  JazzPractice
//
//  Created by Peter Livesey on 7/25/14.
//  Copyright (c) 2014 Peter Livesey. All rights reserved.
//

import UIKit
import JazzMusicGenerator

class SectionsCollectionViewController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout, NewSongGeneratorDelegate, SongSettingsDelegate {
  
  var editingIndex = -1
  
  var tempo = 120
  var tracks: [(name: String, muted: Bool, instrument: PLMusicPlayer.InstrumentType)] =
  [
    ("Solo", false, .Piano),
    ("Rhythm", false, .Piano),
    ("Bass", false, .Bass),
    ("Drums", false, .Drums)
  ]
  
  var chords: [[ChordMeasure]] {
    return CurrentSongDataCenter.sharedInstance.currentSong.sections.map { section in
      return section.chords
    }
  }
  
  @IBOutlet weak var collectionView: UICollectionView!
  // Should be zero if the view is open and -height if the view is closed
  @IBOutlet weak var bottomBarYConstraint: NSLayoutConstraint!
  @IBOutlet weak var bottomBarView: UIView!
  
  required init(coder aDecoder: NSCoder) {
    super.init(coder: aDecoder)
  }
  
  override func viewDidLoad()  {
    super.viewDidLoad()
    
    edgesForExtendedLayout = UIRectEdge.None
    
    collectionView.registerNib(UINib(nibName: "ChordCell", bundle: nil), forCellWithReuseIdentifier: "ChordCell")
    collectionView.registerNib(UINib(nibName: "ChordSectionHeader", bundle: nil), forSupplementaryViewOfKind:UICollectionElementKindSectionHeader, withReuseIdentifier:"HeaderView")
    
    let generateButton = UIBarButtonItem(title: "New Song", style: .Plain, target: self, action: "generateTapped")
    navigationItem.leftBarButtonItem = generateButton
  }
  
  override func viewWillAppear(animated: Bool)  {
    super.viewWillAppear(animated)
    
    collectionView.reloadData()
  }
  
  func generateTapped() {
    let generateController = UIStoryboard(name: "NewSongGenerator", bundle: nil).instantiateInitialViewController() as NewSongGeneratorViewController
    generateController.delegate = self
    navigationController?.pushViewController(generateController, animated: true)
  }
  
  func numberOfSectionsInCollectionView(collectionView: UICollectionView) -> Int {
    return chords.count
  }
  
  func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
    return chords[section].count
  }
  
  func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
    let cell = collectionView.dequeueReusableCellWithReuseIdentifier("ChordCell", forIndexPath: indexPath) as ChordCell
    
    let chordMeasure = chords[indexPath.section][indexPath.row]
    cell.textLabel.text = JazzChordFontTextProvider.textFromChordMeasure(chordMeasure)
    
    return cell
  }
  
  func collectionView(collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, atIndexPath indexPath: NSIndexPath) -> UICollectionReusableView {
    let header = collectionView.dequeueReusableSupplementaryViewOfKind(kind, withReuseIdentifier: "HeaderView", forIndexPath: indexPath) as ChordSectionHeader
    if indexPath.section == 0 {
      header.mainTextLabel.text = "A"
    } else if indexPath.section == 1 {
      header.mainTextLabel.text = "B"
    }
    return header
  }
  
  func collectionView(collectionView: UICollectionView, didSelectItemAtIndexPath indexPath: NSIndexPath) {
    // If you tap anywhere, just stop
    stop()
  }
  
  func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAtIndexPath indexPath: NSIndexPath) -> CGSize {
    return CGSize(width: cellWidth(), height: 60)
  }
  
  func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
    return CGSize(width: view.frame.size.width, height: 44)
  }
  
  // MARK: - Helpers
  
  func cellWidth() -> CGFloat {
    var width = collectionView.frame.size.width
    var divider: CGFloat = 1
    while true {
      divider++
      let newWidth = collectionView.frame.size.width / divider
      if newWidth < 160 {
        return width
      }
      width = newWidth
    }
  }
  
  
  /*
  MAKR: - Action Methods
  */
  
  @IBAction func play() {
    let secondsPerBeat = Float(60) / Float(tempo)
    let muted: [Bool] = tracks.map { instrument in
      return instrument.muted
    }
    let instruments: [PLMusicPlayer.InstrumentType] = tracks.map { instrument in
      return instrument.instrument
    }
    JukeBox.sharedInstance.playMusic(CurrentSongDataCenter.sharedInstance.currentSong, muted: muted, instrumentTypes: instruments, secondsPerBeat: secondsPerBeat)
    
    UIView.animateWithDuration(0.3) {
      self.bottomBarYConstraint.constant = -self.bottomBarView.frame.size.height
    }
    navigationController?.setNavigationBarHidden(true, animated: true)
    UIApplication.sharedApplication().setStatusBarHidden(true, withAnimation: .Fade)
  }
  
  func stop() {
    UIView.animateWithDuration(0.3) {
      self.bottomBarYConstraint.constant = 0
    }
    navigationController?.setNavigationBarHidden(false, animated: true)
    UIApplication.sharedApplication().setStatusBarHidden(false, withAnimation: .Fade)
    JukeBox.sharedInstance.stopMusic()
  }
  
  @IBAction func settingsTapped() {
    let settingsViewController = UIUtils.viewControllerNamed("SongSettings") as SongSettingsViewController
    settingsViewController.tempo = tempo
    settingsViewController.tracks = tracks
    settingsViewController.delegate = self
    navigationController?.pushViewController(settingsViewController, animated: true)
  }
  
  // Generate delegate
  func songGeneratorGeneratedNewSong(songGenerator: NewSongGeneratorViewController) {
    navigationController?.popViewControllerAnimated(true)
    collectionView.reloadData()
  }
  
  // Song settings delegate
  func songSettingsViewController(viewController: SongSettingsViewController, finishedWithTempo tempo: Int, tracks: [(name: String, muted: Bool, instrument: PLMusicPlayer.InstrumentType)]) {
    self.tempo = tempo
    self.tracks = tracks
  }
}
