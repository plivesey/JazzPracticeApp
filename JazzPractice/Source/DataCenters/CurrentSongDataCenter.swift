//
//  CurrentSongDataCenter.swift
//  JazzPractice
//
//  Created by Peter Livesey on 7/25/14.
//  Copyright (c) 2014 Peter Livesey. All rights reserved.
//

import Foundation

class CurrentSongDataCenter {
  
  var currentSong: SongData = {
    // Default
    let sections = MusicGenerator.generateSectionsWithKey(0, numberOfMeasures: 8, numberOfSections: 2)
    return SongData(sections: sections, form: .ABA, repeat: 1)
    }()
  
  class var sharedInstance:CurrentSongDataCenter {
    get {
      struct StaticMusicPlayerContainer {
        static let instance : CurrentSongDataCenter = CurrentSongDataCenter()
      }
      
      return StaticMusicPlayerContainer.instance
    }
  }
}