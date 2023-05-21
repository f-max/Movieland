//
//  MoviewWithRatingsAndYear.swift
//  Movieland-Model
//
//  Created by Massimiliano Faustini on 20/05/23.
//

import Foundation

public struct MoviewWithRatings: Codable, Equatable {
  public let movie: Movie
  public var ratings: Ratings?
  
  public init(movie: Movie, ratings: Ratings? = nil) {
    self.movie = movie
    self.ratings = ratings
  }
}
