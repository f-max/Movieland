//
//  SearchMovieServicing.swift
//  Movieland-Model
//
//  Created by Massimiliano Faustini on 21/05/23.
//

import Foundation

public protocol SearchMovieServicing {
  func fetchMovieList(searchExpression: String) async -> Result<[Movie], BEServiceError>
  func fetchMovieRatings(id: String) async -> Result<Ratings, BEServiceError>
}
