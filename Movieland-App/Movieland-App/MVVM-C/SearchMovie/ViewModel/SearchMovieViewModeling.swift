//
//  SearchMovieViewModeling.swift
//  Movieland-App
//
//  Created by Massimiliano Faustini on 21/05/23.
//

import Foundation
import Movieland_Model

protocol SearchMovieViewModeling {
  
  nonisolated var errorMessage: String { get set }
  nonisolated var hasLoadedOnce: Bool { get set }
  nonisolated var loading: Bool { get set }
  nonisolated var movies: [MoviewWithRatings] { get set }
  nonisolated var noResultsCopy: String { get }
  nonisolated var searchExpression: String { get set }
  nonisolated var searchingCopy: String { get }
  
  func didPerformSearchAction() async
  func didPerformAlertOkAction() async
  func didUpdate(searchExpression: String) async 

}
