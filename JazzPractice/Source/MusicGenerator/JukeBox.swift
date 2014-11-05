//
//  JukeBox.swift
//  JazzPractice
//
//  Created by Peter Livesey on 7/25/14.
//  Copyright (c) 2014 Peter Livesey. All rights reserved.
//

import Foundation
import JazzMusicGenerator

class JukeBox {
  
  var player: PLMusicPlayer = PLMusicPlayer()
  
  func playMusic(song: SongData, muted: [Bool], secondsPerBeat: Float) {
    stopMusic()
    
    let initialScore: [PLMusicPlayerNote] = []
    var currentStart: Float = 0
    
    let oneRepeatSections: [SongSection] = {
      switch song.form {
      case .A:
        return song.sections
      case .AB:
        return song.sections
      case .AAB:
        return [song.sections[0], song.sections[0], song.sections[1]]
      case .ABA:
        return [song.sections[0], song.sections[1], song.sections[0]]
      case .AABB:
        return [song.sections[0], song.sections[0], song.sections[1], song.sections[1]]
      }
      }()
    
    var sections = [SongSection]()
    for _ in 0..<song.repeat {
      sections.extend(oneRepeatSections)
    }
    
    let endingSection: SongSection = {
      let endingChord = song.sections[0].chords[0]
      let lastNote = song.sections[0].melody[0].notes[0].note
      let melody = JazzMelodyGenerator.generateFinalRestingMeasure(closeToEndNote: lastNote, chord: endingChord.chords[0].chord)
      let rhythm = RhythmSectionGenerator.endingRhythmSectionForChord(endingChord)
      let bass = BasslineGenerator.generateEndingBassMeasure(endingChord)
      let drums = DrumGenerator.generateDrumsEndingMeasure()
      
      return SongSection(chords: [endingChord], melody: [melody], rhythm: [rhythm], bass: [bass], drums: [drums])
    }()
    
    sections.append(endingSection)
    
    let scores: [[PLMusicPlayerNote]] = sections.map {
      section in
      
      var instruments: [(music: [ChordNoteMeasure], instrument: PLMusicPlayer.InstrumentType, velocity: UInt8)] = []
      // Piano
      if !muted[0] {
        instruments.append(ScoreCreator.instrumentScore(section.melody, .Piano, 70))
      }
      // Rhythm
      if !muted[1] {
        instruments.append(ScoreCreator.instrumentScore(section.rhythm, .Piano, 50))
      }
      // Bass
      if !muted[2] {
        instruments.append(ScoreCreator.instrumentScore(section.bass, .Bass, 70))
      }
      // Drums
      if !muted[3] {
        instruments.append(ScoreCreator.instrumentScore(section.drums, .Drums, 50))
      }
      
      let fromZero = ScoreCreator.createScore(instruments, secondsPerBeat: secondsPerBeat)
      let adjusted: [PLMusicPlayerNote] = fromZero.map {
        (var x) in
        x.start = x.start + currentStart
        return x
      }
      currentStart += secondsPerBeat * 4 * Float(section.chords.count)
      
      return adjusted
    }
    
    let score = scores.reduce(initialScore) {
      current, next in
      return current + next
    }
    
    player.playMusic(score, maxNumberOfTimers: 5)
  }
  
  func stopMusic() {
    player.stopMusic()
    player = PLMusicPlayer()
  }
  
  class var sharedInstance:JukeBox {
    get {
      struct StaticMusicPlayerContainer {
        static var instance : JukeBox? = nil
      }
      
      if StaticMusicPlayerContainer.instance == nil {
        StaticMusicPlayerContainer.instance = JukeBox()
      }
      
      return StaticMusicPlayerContainer.instance!
    }
  }
}
