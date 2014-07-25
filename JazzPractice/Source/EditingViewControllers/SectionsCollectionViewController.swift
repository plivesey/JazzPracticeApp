//
//  SectionsCollectionViewController.swift
//  JazzPractice
//
//  Created by Peter Livesey on 7/25/14.
//  Copyright (c) 2014 Peter Livesey. All rights reserved.
//

import UIKit

class SectionsCollectionViewController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate {
  
  @IBOutlet var collectionView: UICollectionView;
  
  func collectionView(collectionView: UICollectionView!, numberOfItemsInSection section: Int) -> Int {
    return CurrentSongDataCenter.sharedInstance.currentSong.count
  }
  
  // The cell that is returned must be retrieved from a call to -dequeueReusableCellWithReuseIdentifier:forIndexPath:
  func collectionView(collectionView: UICollectionView!, cellForItemAtIndexPath indexPath: NSIndexPath!) -> UICollectionViewCell! {
    let cell = collectionView.dequeueReusableCellWithReuseIdentifier("cell", forIndexPath: indexPath) as UICollectionViewCell
    return cell
  }
  
  @IBAction func playTapped() {
    JukeBox.sharedInstance.playMusic(CurrentSongDataCenter.sharedInstance.currentSong, secondsPerBeat: 0.5)
  }
  
  @IBAction func stopTapped() {
    JukeBox.sharedInstance.stopMusic()
  }
}
