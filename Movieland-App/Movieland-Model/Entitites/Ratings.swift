//
//  Ratings.swift
//  Movieland-Model
//
//  Created by Massimiliano Faustini on 20/05/23.
//

import Foundation

public struct Ratings: Codable, Equatable {
  public let imDb: String
  public let metacritic: String
  public let theMovieDb: String
  public let rottenTomatoes: String
  public let filmAffinity: String
  
  public init(imDb: String, metacritic: String, theMovieDb: String, rottenTomatoes: String, filmAffinity: String) {
    self.imDb = imDb
    self.metacritic = metacritic
    self.theMovieDb = theMovieDb
    self.rottenTomatoes = rottenTomatoes
    self.filmAffinity = filmAffinity
  }
}
