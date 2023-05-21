//
//  Ratings.swift
//  Movieland-Model
//
//  Created by Massimiliano Faustini on 20/05/23.
//

import Foundation

public struct Ratings: Codable {
  let imDb: String
  let metacritic: String
  let theMovieDb: String
  let rottenTomatoes: String
  let filmAffinity: String
  
  public init(imDb: String, metacritic: String, theMovieDb: String, rottenTomatoes: String, filmAffinity: String) {
    self.imDb = imDb
    self.metacritic = metacritic
    self.theMovieDb = theMovieDb
    self.rottenTomatoes = rottenTomatoes
    self.filmAffinity = filmAffinity
  }
}
