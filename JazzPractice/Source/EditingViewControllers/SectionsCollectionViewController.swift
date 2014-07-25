//
//  SectionsCollectionViewController.swift
//  JazzPractice
//
//  Created by Peter Livesey on 7/25/14.
//  Copyright (c) 2014 Peter Livesey. All rights reserved.
//

import UIKit

class SectionsCollectionViewController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate, SheetMusicDelegate {
  
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
    let sheetMusic = UIStoryboard(name: "SheetMusicViewController", bundle: nil).instantiateInitialViewController() as SheetMusicViewController
    sheetMusic.chords = CurrentSongDataCenter.sharedInstance.currentSong[0].chords
    sheetMusic.delegate = self
    let navigationController = UINavigationController(rootViewController: sheetMusic)
    presentViewController(navigationController, animated: true, completion: nil)
  }
  
  @IBAction func stopTapped() {
    
  }
  
  // Sheet music delegate
  func sheeMusicFinished(_: SheetMusicViewController) {
    dismissViewControllerAnimated(true, completion: nil)
  }
}
