//
//  SheetMusicViewController.swift
//  JazzPractice
//
//  Created by Peter Livesey on 7/25/14.
//  Copyright (c) 2014 Peter Livesey. All rights reserved.
//

import UIKit

protocol SheetMusicDelegate {
  func sheeMusicFinished(_: SheetMusicViewController)
}

class SheetMusicViewController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate {
  
  var chords: [ChordMeasure] = []
  var delegate: SheetMusicDelegate?
  
  // UI
  var playButton: UIBarButtonItem!
  var playing = false
  
  @IBOutlet var collectionView: UICollectionView!;
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    collectionView.registerNib(UINib(nibName: "ChordCell", bundle: nil), forCellWithReuseIdentifier: "ChordCell")
    
    let cancelButton = UIBarButtonItem(title: "Close", style: UIBarButtonItemStyle.Done, target: self, action: "doneTapped")
    navigationItem.rightBarButtonItem = cancelButton
    playButton = UIBarButtonItem(title: "Stop", style: UIBarButtonItemStyle.Done, target: self, action: "playTapped")
    navigationItem.leftBarButtonItem = playButton
  }
  
  override func viewDidAppear(animated: Bool) {
    super.viewDidAppear(animated)
    
    JukeBox.sharedInstance.playMusic(CurrentSongDataCenter.sharedInstance.currentSong, secondsPerBeat: 0.7)
    playing = true
  }
  
  func doneTapped() {
    JukeBox.sharedInstance.stopMusic()
    delegate?.sheeMusicFinished(self)
  }
  
  func playTapped() {
    if playing {
      JukeBox.sharedInstance.stopMusic()
      playButton.title = "Play"
    } else {
      JukeBox.sharedInstance.playMusic(CurrentSongDataCenter.sharedInstance.currentSong, secondsPerBeat: 0.7)
      playButton.title = "Stop"
    }
    playing = !playing
  }
  
  func collectionView(collectionView: UICollectionView!, numberOfItemsInSection section: Int) -> Int {
    return chords.count
  }
  
  func collectionView(collectionView: UICollectionView!, cellForItemAtIndexPath indexPath: NSIndexPath!) -> UICollectionViewCell! {
    let cell = collectionView.dequeueReusableCellWithReuseIdentifier("ChordCell", forIndexPath: indexPath) as ChordCell
    
    let chordMeasure = chords[indexPath.row]
    cell.textLabel.text = "\(chordMeasure)"
    
    return cell
  }
  
}
