//
//  SearchMovieCoordinating.swift
//  Movieland-App
//
//  Created by Massimiliano Faustini on 21/05/23.
//

import Foundation

enum SerchMovieLocations: Location {
  case list
  case detail(id: String)
}

protocol SearchMovieCoordinating: RootNavigating {}
