//
//  ChordsViewController.swift
//  JazzPractice
//
//  Created by Peter Livesey on 7/25/14.
//  Copyright (c) 2014 Peter Livesey. All rights reserved.
//

import UIKit

//protocol ChordsViewControllerDelegate {
//  func chordsViewController(_: ChordsViewController, updatedSongSection: SongSection)
//}
//
//class ChordsViewController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate, SingleChordViewControllerDelegate {
//  
//  var songSection: SongSection?
//  var delegate: ChordsViewControllerDelegate?
//  var editingIndex = -1
//  
//  @IBOutlet var collectionView: UICollectionView!;
//  
//  override func viewDidLoad() {
//    super.viewDidLoad()
//    
//    collectionView.registerNib(UINib(nibName: "ChordCell", bundle: nil), forCellWithReuseIdentifier: "ChordCell")
//  }
//  
//  override func viewWillAppear(animated: Bool)  {
//    super.viewWillAppear(animated)
//    
//    collectionView.reloadData()
//  }
//  
//  func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
//    if let song = songSection {
//      return song.chords.count
//    } else {
//      return 0
//    }
//  }
//  
//  // The cell that is returned must be retrieved from a call to -dequeueReusableCellWithReuseIdentifier:forIndexPath:
//  func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
//    let cell = collectionView.dequeueReusableCellWithReuseIdentifier("ChordCell", forIndexPath: indexPath) as ChordCell
//    
//    let chordMeasure = songSection?.chords[indexPath.row]
//    cell.textLabel.text = "\(chordMeasure)"
//    
//    return cell
//  }
//  
//  func collectionView(collectionView: UICollectionView!, didSelectItemAtIndexPath indexPath: NSIndexPath!) {
//    let chordsViewController = UIStoryboard(name: "SingleChordViewController", bundle: nil).instantiateInitialViewController() as SingleChordViewController
//    chordsViewController.delegate = self
//    editingIndex = indexPath.row
//    navigationController?.pushViewController(chordsViewController, animated: true)
//  }
//  
//  func chordsViewController(_: SingleChordViewController, updatedToNewChords measure: ChordMeasure) {
//    songSection?.chords[editingIndex] = measure
//    delegate?.chordsViewController(self, updatedSongSection: songSection!)
//  }
//}
