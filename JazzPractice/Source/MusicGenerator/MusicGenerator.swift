//
//  MusicGenerator.swift
//  JazzPractice
//
//  Created by Peter Livesey on 7/25/14.
//  Copyright (c) 2014 Peter Livesey. All rights reserved.
//

import Foundation

class MusicGenerator {
  
  class func generateSectionsWithKey(key: Int, numberOfMeasures: Int, numberOfSections: Int) -> [SongSection] {
    let startNote = 70 + RandomHelpers.randomNumberInclusive(0, 11)
    
    var sections = [SongSection]()
    for section in 0..<numberOfSections {
      let chords = JazzChordGenerator.generateRandomChords(numMeasures: numberOfMeasures, key: key)
      
      let melody: [ChordNoteMeasure] = {
        let solo = section != 0
        if solo {
          return SongComposer.generateSoloSection(chords, startNote: startNote, endNote: startNote)
        } else {
          return SongComposer.generateMelodyForChordMeasures(chords, startNote: startNote, endNote: startNote)
        }
      }()
      
      let bassline = BasslineGenerator.generateBasslineForChordMeasures(chords)
      let rhythm = RhythmSectionGenerator.rhythmSectionFromChords(chords)
      let drums = DrumGenerator.generateDrums(numberOfMeasures: chords.count)
      
      sections.append(SongSection(chords: chords, melody: melody, rhythm: rhythm, bass: bassline, drums: drums))
    }
    
    return sections
  }
}
