//
//  SearchMovieViewModel.swift
//  Movieland-App
//
//  Created by Massimiliano Faustini on 21/05/23.
//

import Foundation

@MainActor
final class SearchMovieViewModel: SearchMovieViewModeling & ObservableObject {
  
  let model: SearchMovieModeling
  let coordinator: any SearchMovieCoordinating
  
  init(model: SearchMovieModeling, coordinator: any SearchMovieCoordinating) {
    self.model = model
    self.coordinator = coordinator
  }
    
}
