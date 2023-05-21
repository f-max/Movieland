//
//  MovieRatingsResponse.swift
//  Movieland-BE-Services
//
//  Created by Massimiliano Faustini on 20/05/23.
//

import Foundation
import Movieland_Model

struct MovieRatingsResponse: Codable {
  let imDb: String
  let metacritic: String
  let theMovieDb: String
  let rottenTomatoes: String
  let filmAffinity: String
  let errorMessage: String
  let year: String
}

extension MovieRatingsResponse {
  var ratings: Ratings {
    .init(
      imDb: self.imDb,
      metacritic: self.metacritic,
      theMovieDb: self.theMovieDb,
      rottenTomatoes: self.rottenTomatoes,
      filmAffinity: self.filmAffinity
    )
  }
}
