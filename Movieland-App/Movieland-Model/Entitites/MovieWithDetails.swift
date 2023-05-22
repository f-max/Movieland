//
//  MoviewWithDetails.swift
//  Movieland-Model
//
//  Created by Massimiliano Faustini on 21/05/23.
//

import Foundation

public struct MovieWithDetails: Codable {
  public let fullCast: Cast
  public let movie: Movie
  public let plot: String
  public let ratings: Ratings
  public let starList: [Person]
  public let year: String
  
  public init(fullCast: Cast, movie: Movie, plot: String, ratings: Ratings, starList: [Person], year: String) {
    self.fullCast = fullCast
    self.movie = movie
    self.plot = plot
    self.ratings = ratings
    self.starList = starList
    self.year = year
  }
}
