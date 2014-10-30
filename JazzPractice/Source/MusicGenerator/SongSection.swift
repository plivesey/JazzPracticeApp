//
//  SongSection.swift
//  JazzPractice
//
//  Created by Peter Livesey on 7/25/14.
//  Copyright (c) 2014 Peter Livesey. All rights reserved.
//

import Foundation

struct SongSection {
  var chords: [ChordMeasure]
  var melody: [ChordNoteMeasure]
  var rhythm: [ChordNoteMeasure]
  var bass:   [ChordNoteMeasure]
  var drums:  [ChordNoteMeasure]
}

struct SongData {
  let sections: [SongSection]
  let form: SongForm
  let repeat: Int
}
