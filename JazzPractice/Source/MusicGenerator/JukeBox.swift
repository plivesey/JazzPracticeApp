//
//  JukeBox.swift
//  JazzPractice
//
//  Created by Peter Livesey on 7/25/14.
//  Copyright (c) 2014 Peter Livesey. All rights reserved.
//

import Foundation

class JukeBox {
  
  var player: PLMusicPlayer = PLMusicPlayer()
  
  func playMusic(sections: [SongSection], muted: [Bool], secondsPerBeat: Float) {
    stopMusic()
    
    let initialScore: [PLMusicPlayerNote] = []
    var currentStart: Float = 0
    let scores: [[PLMusicPlayerNote]] = sections.map {
      section in
      
      var instruments: [(music: [ChordNoteMeasure], instrument: PLMusicPlayer.InstrumentType, velocity: UInt8)] = []
      // Piano
      if !muted[0] {
        instruments.append(ScoreCreator.instrumentScore(section.melody, .Piano, 80))
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
