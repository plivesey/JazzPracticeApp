//
//  CurrentSongDataCenter.swift
//  JazzPractice
//
//  Created by Peter Livesey on 7/25/14.
//  Copyright (c) 2014 Peter Livesey. All rights reserved.
//

import Foundation

class CurrentSongDataCenter {
  
  var currentSong = MusicGenerator.generateSections()
  
  class var sharedInstance:CurrentSongDataCenter {
    get {
      struct StaticMusicPlayerContainer {
        static var instance : CurrentSongDataCenter? = nil
      }
      
      if StaticMusicPlayerContainer.instance == nil {
        StaticMusicPlayerContainer.instance = CurrentSongDataCenter()
      }
      
      return StaticMusicPlayerContainer.instance!
  }
  }
}