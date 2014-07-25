//
//  MusicGenerator.swift
//  JazzPractice
//
//  Created by Peter Livesey on 7/25/14.
//  Copyright (c) 2014 Peter Livesey. All rights reserved.
//

import Foundation

class MusicGenerator {
  
  class func generateSections() -> [SongSection] {
    let startNote = 70 + RandomHelpers.randomNumberInclusive(0, 11)
  
    let chords = JazzChordGenerator.generateRandomChords(numMeasures: 12)
    let melody = SongComposer.generateMelodyForChordMeasures(chords, startNote: startNote, endNote: startNote)
    let bassline = BasslineGenerator.generateBasslineForChordMeasures(chords)
    let rhythm = RhythmSectionGenerator.rhythmSectionFromChords(chords)
    let drums = DrumGenerator.generateDrums(numberOfMeasures: chords.count)
    
    let songSection = SongSection(chords: chords, melody: melody, rhythm: rhythm, bass: bassline, drums: drums)
    return [songSection, songSection]
  }
}
