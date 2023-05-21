//
//  BEServices.swift
//  
//
//  Created by Massimiliano Faustini on 20/05/23.
//

import Foundation

public protocol BEServiceProviding {
  func fetchMovieList(searchExpression: String) async -> Result<[Movie], BEServiceError>
  func fetchMovieRatings(id: String) async -> Result<Ratings, Movieland_Model.BEServiceError>
  func fetchMovieDetails(detailOptions: TitleDetailOptions ..., for id: String) async -> Result<MovieWithDetails, BEServiceError>
}
