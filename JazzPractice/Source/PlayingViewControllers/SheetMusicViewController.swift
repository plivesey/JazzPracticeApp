//
//  SheetMusicViewController.swift
//  JazzPractice
//
//  Created by Peter Livesey on 7/25/14.
//  Copyright (c) 2014 Peter Livesey. All rights reserved.
//

import UIKit
import JazzMusicGenerator

protocol SheetMusicDelegate {
  func sheeMusicFinished(_: SheetMusicViewController)
}

class SheetMusicViewController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate {
  
  var chords: [ChordMeasure] = []
  var delegate: SheetMusicDelegate?
  var tempo: Float?
  var muted: [Bool]?
  
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
    
    play()
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
      play()
      playButton.title = "Stop"
    }
    playing = !playing
  }
  
  func play() {
    var unwrappedTemp: Float = 0.7
    if let tempo = tempo {
      unwrappedTemp = Float(60) / tempo
    }
    
    var unwrappedMuted = [false, false, false, false]
    if let muted = muted {
      unwrappedMuted = muted
    }
    
//    JukeBox.sharedInstance.playMusic(CurrentSongDataCenter.sharedInstance.currentSong, muted: unwrappedMuted, secondsPerBeat: unwrappedTemp)
  }
  
  func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
    return chords.count
  }
  
  func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
    let cell = collectionView.dequeueReusableCellWithReuseIdentifier("ChordCell", forIndexPath: indexPath) as ChordCell
    
    let chordMeasure = chords[indexPath.row]
    cell.textLabel.text = "\(chordMeasure)"
    
    return cell
  }
  
}
