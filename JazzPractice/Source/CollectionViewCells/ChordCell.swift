//
//  ChordCell.swift
//  JazzPractice
//
//  Created by Peter Livesey on 7/25/14.
//  Copyright (c) 2014 Peter Livesey. All rights reserved.
//

import UIKit

class ChordCell: UICollectionViewCell {

  @IBOutlet var textLabel: UILabel!
  
  override func awakeFromNib() {
    super.awakeFromNib()
    
    textLabel.font = JazzChordFontTextProvider.jazzFontOfSize(textLabel.font.pointSize)
  }
  
}
