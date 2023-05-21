//
//  Movie.swift
//  Movieland-Model
//
//  Created by Massimiliano Faustini on 20/05/23.
//

import Foundation

public struct Movie: Codable, Equatable  {
  var id: String
  var image: String
  var title: String
  
  public  init(id: String, image: String, title: String) {
    self.id = id
    self.image = image
    self.title = title
  }
}

