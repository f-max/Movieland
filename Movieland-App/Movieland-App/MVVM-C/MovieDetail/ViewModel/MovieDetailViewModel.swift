//
//  MovieDetailViewModel.swift
//  Movieland-App
//
//  Created by Massimiliano Faustini on 22/05/23.
//

import Foundation
import Movieland_Model

@MainActor
final class MovieDetailViewModel: MovieDetailViewModeling & ObservableObject {
  
  let model: MovieDetailModeling
  let coordinator: any MovieDetailCoordinating
  
  @Published var errorMessage: String = ""
  @Published var movieWithRatings: MovieWithRatings
  @Published var movieWithDetails: MovieWithDetails?
  
  
  var plot: String  {
    guard let moviePlot = movieWithDetails?.plot, !moviePlot.isEmpty else {
      return ""
    }
    return "Plot: " + moviePlot
  }
  
  var director: String {
    "Director: \n" + (movieWithDetails?.fullCast.directorList.first?.name ?? "")
  }
  
  var stars: String {
    guard let stars = movieWithDetails?.starList, !stars.isEmpty else {
      return ""
    }
    return stars.reduce("Stars:") { $0 + "\n" + $1.name }
  }
  
  static var errorMessageCopy = "Sorry, something went wrong 😖"
  
  init(
    model: MovieDetailModeling,
    coordinator: any MovieDetailCoordinating,
    movieWithRatings: MovieWithRatings
  ) {
    self.model = model
    self.coordinator = coordinator
    self.movieWithRatings = movieWithRatings
    Task {
      await loadDetails()
    }
  }
  
  func didPerformAlertOkAction() {
    coordinator.dismissDetail()
  }
  
}

private extension MovieDetailViewModel {
  func loadDetails() async {
    let result = await self.model.service.fetchMovieDetails(
      detailOptions: .fullCast, .ratings,
      for: movieWithRatings.movie.id
    )
    objectWillChange.send()
    
    switch result {
    case .failure:
      errorMessage = Self.errorMessageCopy
    case let .success(movieWithDetails):
      errorMessage = ""
      self.movieWithDetails = movieWithDetails
      break
    }
  }
}
