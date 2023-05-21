//
//  SearchMovieViewModel.swift
//  Movieland-App
//
//  Created by Massimiliano Faustini on 21/05/23.
//

import Foundation
import Movieland_Model

@MainActor
final class SearchMovieViewModel: SearchMovieViewModeling & ObservableObject {
  
  @Published var errorMessage: String = ""
  @Published var hasLoadedOnce: Bool = false
  @Published var loading: Bool = false
  @Published var movies: [MoviewWithRatings] = []
  @Published var noResultsCopy: String = "No results 🤷🏻‍♂️"
  @Published var searchExpression: String = ""
  @Published var searchingCopy: String = "Searching... 👀"
  
  
  let model: SearchMovieModeling
  let coordinator: any SearchMovieCoordinating
  
  init(model: SearchMovieModeling, coordinator: any SearchMovieCoordinating) {
    self.model = model
    self.coordinator = coordinator
  }
  
  func didPerformSearchAction() async {
    loading = true
    let result = await model.service.fetchMovieList(searchExpression: searchExpression)
    hasLoadedOnce = true
    switch result {
    case let .failure(error):
      errorMessage = error.displayableMessage
      hasLoadedOnce = false
    case let .success(movies):
      self.movies = movies.map {
        MoviewWithRatings(movie: $0, ratings: nil)
      }
      loadRatings()
    }
    loading = false
  }
  
  func didPerformAlertOkAction() async {
    errorMessage = ""
  }
    
  func didUpdate(searchExpression: String) async {
    self.searchExpression = searchExpression
    movies.removeAll()
    hasLoadedOnce = false
  }
}

private extension SearchMovieViewModel {
  func loadRatings() {
    for id in movies.map({ $0.movie.id }) {
      let model = self.model
      Task {
        let result = await model.service.fetchMovieRatings(id: id)
        if case let .success(ratings) = result {
          if let index = movies.firstIndex(where: { $0.movie.id == id }) {
            movies[index] = movies[index].updateWithRatings(ratings: ratings)
          }
        }
      }
    }
  }
}

extension MoviewWithRatings {
  mutating func updateWithRatings(ratings: Ratings) -> Self {
    .init(movie: self.movie, ratings: ratings)
  }
  
  var firstAvailableRating: String? {
    if let rating = ratings?.filmAffinity, !rating.isEmpty {
      return "Filmaffinity: " + rating
    }
    
    if let rating = ratings?.imDb, !rating.isEmpty {
      return "imDb: " + rating
    }
    
    if let rating = ratings?.metacritic, !rating.isEmpty {
      return "Metacritic: " + rating
    }
    
    if let rating = ratings?.rottenTomatoes, !rating.isEmpty {
      return "RottenTomatoes: " + rating
    }
    
    if let rating = ratings?.theMovieDb, !rating.isEmpty {
      return "TheMovieDB: " + rating
    }
    
    return nil
  }
}
