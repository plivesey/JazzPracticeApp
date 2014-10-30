//
//  SectionsCollectionViewController.swift
//  JazzPractice
//
//  Created by Peter Livesey on 7/25/14.
//  Copyright (c) 2014 Peter Livesey. All rights reserved.
//

import UIKit

class SectionsCollectionViewController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout, NewSongGeneratorDelegate, SongSettingsDelegate {
  
  var editingIndex = -1
  
  var tempo = 120
  var mutedTracks: [(name: String, muted: Bool)] =
  [
    ("Solo", false),
    ("Rhythm", false),
    ("Bass", false),
    ("Drums", false)
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
    cell.textLabel.text = "\(chordMeasure)"
    if indexPath.row == 0 {
      cell.sectionLabel.text = {
        switch indexPath.section {
        case 0:
          return "A"
        case 1:
          return "B"
        case 2:
          return "C"
        default:
          return "?"
        }
      }()
    } else {
      cell.sectionLabel.text = ""
    }
    
    return cell
  }
  
  func collectionView(collectionView: UICollectionView, didSelectItemAtIndexPath indexPath: NSIndexPath) {
    // If you tap anywhere, just stop
    stop()
  }
  
  func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAtIndexPath indexPath: NSIndexPath) -> CGSize {
    return CGSize(width: 160, height: 60)
  }
  
  /*
  Action Methods
  */
  
  @IBAction func play() {
    let secondsPerBeat = Float(60) / Float(tempo)
    let muted: [Bool] = mutedTracks.map { instrument in
      return instrument.muted
    }
    JukeBox.sharedInstance.playMusic(CurrentSongDataCenter.sharedInstance.currentSong, muted: muted, secondsPerBeat: secondsPerBeat)
    
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
    settingsViewController.mutedTracks = mutedTracks
    settingsViewController.delegate = self
    navigationController?.pushViewController(settingsViewController, animated: true)
  }
  
  // Generate delegate
  func songGeneratorGeneratedNewSong(songGenerator: NewSongGeneratorViewController) {
    navigationController?.popViewControllerAnimated(true)
    collectionView.reloadData()
  }
  
  // Song settings delegate
  func songSettingsViewController(viewController: SongSettingsViewController, finishedWithTempo tempo: Int, mutedTracks: [(name: String, muted: Bool)]) {
    self.tempo = tempo
    self.mutedTracks = mutedTracks
  }
}
