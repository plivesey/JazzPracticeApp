//
//  SectionsCollectionViewController.swift
//  JazzPractice
//
//  Created by Peter Livesey on 7/25/14.
//  Copyright (c) 2014 Peter Livesey. All rights reserved.
//

import UIKit

class SectionsCollectionViewController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate, SheetMusicDelegate, ChordsViewControllerDelegate {

  required init(coder aDecoder: NSCoder) {
      super.init(coder: aDecoder)
  }
  
  var editingIndex = -1
  @IBOutlet var collectionView: UICollectionView!;
  
  override func viewDidLoad()  {
    super.viewDidLoad()
    
    edgesForExtendedLayout = UIRectEdge.None
  }
  
  override func viewWillAppear(animated: Bool)  {
    super.viewWillAppear(animated)
    
    collectionView.reloadData()
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
}
