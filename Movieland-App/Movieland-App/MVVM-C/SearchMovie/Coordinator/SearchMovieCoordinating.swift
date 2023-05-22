//
//  SearchMovieCoordinating.swift
//  Movieland-App
//
//  Created by Massimiliano Faustini on 21/05/23.
//

import Foundation
import Movieland_Model

enum SerchMovieLocations: Location {
  case list
  case detail(movieWithRatings: MovieWithRatings)
}

protocol SearchMovieCoordinating: RootNavigating  {
  func didSelectMovie(movieWithRatings: MovieWithRatings)
  func dismissDetail()
}
