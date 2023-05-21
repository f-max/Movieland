//
//  MoviewWithRatingsAndYear.swift
//  Movieland-Model
//
//  Created by Massimiliano Faustini on 20/05/23.
//

import Foundation

public struct MoviewWithRatings: Codable {
  let movie: Movie
  let ratings: Ratings
}
