//
//  SectionsCollectionViewController.swift
//  JazzPractice
//
//  Created by Peter Livesey on 7/25/14.
//  Copyright (c) 2014 Peter Livesey. All rights reserved.
//

import UIKit

class SectionsCollectionViewController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate, SheetMusicDelegate, ChordsViewControllerDelegate, NewSongGeneratorDelegate, SongSettingsDelegate {
  
  var editingIndex = -1
  
  var tempo = 120
  var mutedTracks: [(name: String, muted: Bool)] =
  [
    ("Solo", false),
    ("Rhythm", false),
    ("Bass", false),
    ("Drums", false)
  ]
  
  @IBOutlet var collectionView: UICollectionView!
  
  required init(coder aDecoder: NSCoder) {
    super.init(coder: aDecoder)
  }
  
  override func viewDidLoad()  {
    super.viewDidLoad()
    
    edgesForExtendedLayout = UIRectEdge.None
    
    let generateButton = UIBarButtonItem(title: "Generate", style: .Plain, target: self, action: "generateTapped")
    navigationItem.leftBarButtonItem = generateButton
    
    let settingsButton = UIBarButtonItem(title: "Settings", style: .Plain, target: self, action: "settingsTapped")
    navigationItem.rightBarButtonItem = settingsButton
  }
  
  override func viewWillAppear(animated: Bool)  {
    super.viewWillAppear(animated)
    
    collectionView.reloadData()
  }
  
  func generateTapped() {
    let generateController = UIStoryboard(name: "NewSongGenerator", bundle: nil).instantiateInitialViewController() as SheetMusicViewController
    generateController.delegate = self
    let navigationController = UINavigationController(rootViewController: generateController)
    presentViewController(navigationController, animated: true, completion: nil)
  }
  
  func settingsTapped() {
    let settingsViewController = UIUtils.viewControllerNamed("SongSettings") as SongSettingsViewController
    settingsViewController.tempo = tempo
    settingsViewController.mutedTracks = mutedTracks
    settingsViewController.delegate = self
    presentViewController(UINavigationController(rootViewController: settingsViewController), animated: true, completion: nil)
  }
  
  func collectionView(collectionView: UICollectionView!, numberOfItemsInSection section: Int) -> Int {
    return CurrentSongDataCenter.sharedInstance.currentSong.count
  }
  
  func collectionView(collectionView: UICollectionView!, cellForItemAtIndexPath indexPath: NSIndexPath!) -> UICollectionViewCell! {
    let cell = collectionView.dequeueReusableCellWithReuseIdentifier("cell", forIndexPath: indexPath) as UICollectionViewCell
    return cell
  }
  
  func collectionView(collectionView: UICollectionView!, didSelectItemAtIndexPath indexPath: NSIndexPath!) {
    let chordsViewController = UIStoryboard(name: "ChordsViewController", bundle: nil).instantiateInitialViewController() as ChordsViewController
    chordsViewController.songSection = CurrentSongDataCenter.sharedInstance.currentSong[indexPath.row]
    chordsViewController.delegate = self
    editingIndex = indexPath.row
    navigationController.pushViewController(chordsViewController, animated: true)
  }
  
  @IBAction func playTapped() {
    let sheetMusic = UIStoryboard(name: "SheetMusicViewController", bundle: nil).instantiateInitialViewController() as SheetMusicViewController
    sheetMusic.chords = CurrentSongDataCenter.sharedInstance.currentSong[0].chords
    sheetMusic.delegate = self
    sheetMusic.tempo = Float(tempo)
    sheetMusic.muted = mutedTracks.map { instrument in
      return instrument.muted
    }
    let navigationController = UINavigationController(rootViewController: sheetMusic)
    presentViewController(navigationController, animated: true, completion: nil)
  }
  
  @IBAction func stopTapped() {
    
  }
  
  // Sheet music delegate
  func sheeMusicFinished(_: SheetMusicViewController) {
    dismissViewControllerAnimated(true, completion: nil)
  }
  
  // Chords delegate
  func chordsViewController(_: ChordsViewController, updatedSongSection: SongSection) {
    CurrentSongDataCenter.sharedInstance.currentSong[editingIndex] = updatedSongSection
  }
  
  // Generate delegate
  func songGeneratorGeneratedNewSong(songGenerator: NewSongGeneratorViewController) {
    dismissViewControllerAnimated(true, completion: nil)
    collectionView.reloadData()
  }
  
  // Song settings delegate
  func songSettingsViewController(viewController: SongSettingsViewController, finishedWithTempo tempo: Int, mutedTracks: [(name: String, muted: Bool)]) {
    self.tempo = tempo
    self.mutedTracks = mutedTracks
    self .dismissViewControllerAnimated(true, completion: nil)
  }
}
