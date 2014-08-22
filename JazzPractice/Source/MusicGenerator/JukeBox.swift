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
  
  func playMusic(sections: [SongSection], secondsPerBeat: Float) {
    stopMusic()
    
    let initialScore: [PLMusicPlayerNote] = []
    var currentStart: Float = 0
    let scores: [[PLMusicPlayerNote]] = sections.map {
      section in
      let fromZero = createScore(chords: section.rhythm, melody: section.melody, bassline: section.bass, drums: section.drums, secondsPerBeat: secondsPerBeat)
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
