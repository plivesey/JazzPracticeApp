//
//  JazzChordFontTextProvider.swift
//  JazzPractice
//
//  Created by Peter Livesey on 11/19/14.
//  Copyright (c) 2014 Peter Livesey. All rights reserved.
//

import Foundation
import JazzMusicGenerator

class JazzChordFontTextProvider {
  
  class func jazzFontOfSize(size: CGFloat) -> UIFont {
    return UIFont(name: "JazzCord", size: size)!
  }
  
  class func textFromChordMeasure(chordMeasure: ChordMeasure) -> String {
    var result = chordTextFromChord(chordMeasure.chords[0].chord)
    for i in 1..<chordMeasure.chords.count {
      result += "    "
      result += chordTextFromChord(chordMeasure.chords[i].chord)
    }
    return result
  }
  
  class func chordTextFromChord(chord: ChordData) -> String {
    var output = ""
    
    // Base note
    output += noteToJazzString(chord.baseNote)
    
    // Type
    switch chord.type {
    case .Major7:
      output += ""
    case .Minor7:
      output += ""
    case .Dom7:
      output += ""
    case .MinorMajor7:
      output += ""
    case .DimFully:
      output += "°"
    case .DimPartial:
      output += "ø"
    case .Sus7:
      output += ""
    }
    
    if chord.root != chord.baseNote {
      output += "" + noteToJazzString(chord.root)
    }
    
    return output
  }
  
  class func noteToJazzString(var note: Int) -> String {
    note = note % 12
    switch note {
    case -1:
      return ""
    case 0:
      return ""
    case 1:
      return ""
    case 2:
      return ""
    case 3:
      return ""
    case 4:
      return ""
    case 5:
      return ""
    case 6:
      return ""
    case 7:
      return ""
    case 8:
      return ""
    case 9:
      return ""
    case 10:
      return ""
    case 11:
      return ""
    default:
      return "ERROR"
    }
  }
}
