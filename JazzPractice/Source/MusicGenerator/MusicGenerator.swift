//
//  MusicGenerator.swift
//  JazzPractice
//
//  Created by Peter Livesey on 7/25/14.
//  Copyright (c) 2014 Peter Livesey. All rights reserved.
//

import Foundation
import JazzMusicGenerator

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
      
//      // DEBUG. Print out the melody
//      for i in 0..<chords.count {
//        print(chords[i])
//        let melody: [String] = melody[i].notes.map { note in
//          return MusicUtil.noteToString(note.note)
//        }
//        println("   \(melody)")
//      }
      
      // DEBUG. Print out the bassline.
//      for i in 0..<chords.count {
//        print(chords[i])
//        let bass: [String] = bassline[i].notes.map { note in
//          return MusicUtil.noteToString(note.note)
//        }
//        println("   \(bass)")
//      }
      
      sections.append(SongSection(chords: chords, melody: melody, rhythm: rhythm, bass: bassline, drums: drums))
    }
    
    return sections
  }
}
