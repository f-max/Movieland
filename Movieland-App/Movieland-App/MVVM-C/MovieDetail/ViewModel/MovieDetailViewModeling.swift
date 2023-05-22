//
//  MovieDetailViewModeling.swift
//  Movieland-App
//
//  Created by Massimiliano Faustini on 22/05/23.
//

import Foundation
import Movieland_Model

protocol MovieDetailViewModeling {
  nonisolated var director: String { get }
  nonisolated var errorMessage: String { get }
  nonisolated var movieWithDetails: MovieWithDetails? { get set }
  nonisolated var movieWithRatings: MovieWithRatings { get }
  nonisolated var plot: String { get }
  nonisolated var stars: String { get }
  
  func didPerformAlertOkAction() async
}
