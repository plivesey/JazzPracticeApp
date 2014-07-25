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
  var melody: [MelodyMeasure]
  var rhythm: [ChordNoteMeasure]
  var bass:   [MelodyMeasure]
  var drums:  [ChordNoteMeasure]
}
