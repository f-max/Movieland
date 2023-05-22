//
//  MovieDetailServicing.swift
//  Movieland-Model
//
//  Created by Massimiliano Faustini on 22/05/23.
//

import Foundation

public protocol MovieDetailServicing {
  func fetchMovieDetails(detailOptions: TitleDetailOptions ..., for id: String) async -> Result<MovieWithDetails, BEServiceError>
}
