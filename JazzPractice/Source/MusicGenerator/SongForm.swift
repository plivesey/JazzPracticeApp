//
//  SongForm.swift
//  JazzPractice
//
//  Created by Peter Livesey on 10/29/14.
//  Copyright (c) 2014 Peter Livesey. All rights reserved.
//

import Foundation

enum SongForm: String {
  case A = "A"
  case AB = "AB"
  case AAB = "AAB"
  case ABA = "ABA"
  case AABB = "AABB"
  
  static func allForms() -> [SongForm] {
    return [ .A, .AB, .AAB, .ABA, .AABB ]
  }
  
  func numberOfSections() -> Int {
    switch self {
    case .A:
      return 1
    case .AB, .AAB, .ABA, .AABB:
      return 2
    }
  }
}
