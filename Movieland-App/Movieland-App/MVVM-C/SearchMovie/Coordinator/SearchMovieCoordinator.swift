//
//  SearchMovieCoordinator.swift
//  Movieland-App
//
//  Created by Massimiliano Faustini on 21/05/23.
//

import UIKit
import Movieland_Model

final class SearchMovieCoordinator: SearchMovieCoordinating {
  
  var navigationController: UINavigationController?
  
  func setRootViewController(window: UIWindow) {
    Task { @MainActor in
      guard let controller = await serchViewController() else {
        return
      }
      controller.view.backgroundColor = .white
      navigationController = UINavigationController(rootViewController: controller)
      window.rootViewController = navigationController
      window.makeKeyAndVisible()
    }
  }
  
  @MainActor
  func navigateTo(location: SerchMovieLocations, completion: (() -> Void)?) async {
    switch location {
    case let .detail(movieWithRatings):
      guard let viewController = await movieDetailViewController(movieWithRatings: movieWithRatings) else {
        return
      }
      navigationController?.pushViewController(viewController, animated: true)
    default:
      break
    }
  }
    
  func didSelectMovie(movieWithRatings: MovieWithRatings) {
    Task {
      await navigateTo(location: .detail(movieWithRatings: movieWithRatings), completion: nil)
    }
  }
  
  func dismissDetail() {
    navigationController?.popViewController(animated: true)
  }
  
}


// MARK: - SearchMovie MVVM-C

private extension SearchMovieCoordinator {
  
  func searchMovieModel() -> SearchMovieModeling? {
    guard let service = try? diContainer.resolve(serviceType: SearchMovieServicing.self) else {
      return nil
    }
    return SearchMovieModel(service: service)
  }
  
  func searchMovieViewModel() async -> SearchMovieViewModel? {
    guard let model = searchMovieModel() else {
      return nil
    }
    // need to update Eustace to support async operations to resolve it via DI
    return await SearchMovieViewModel(model: model, coordinator: self)
  }
  
  func serchViewController() async -> UIViewController? {
    guard let viewModel = await searchMovieViewModel() else {
      return nil
    }
    // need to update Eustace to support async operations to resolve it via DI
    return await SearchMovieViewController(viewModel: viewModel)
  }
}

// MARK: - MovieDetail MVVM-C

private extension SearchMovieCoordinator {
  
  func movieDetailModel() -> MovieDetailModeling? {
    guard let service = try? diContainer.resolve(serviceType: MovieDetailServicing.self) else {
      return nil
    }
    return MovieDetailModel(service: service)
  }
  
  func movieDetailViewModel(movieWithRatings: MovieWithRatings) async -> MovieDetailViewModel? {
    guard let model = movieDetailModel() else {
      return nil
    }
    // need to update Eustace to support async operations to resolve it via DI
    return await MovieDetailViewModel(
      model: model,
      coordinator: self,
      movieWithRatings: movieWithRatings
    )
  }
  
  func movieDetailViewController(movieWithRatings: MovieWithRatings) async -> UIViewController? {
    guard let viewModel = await movieDetailViewModel(movieWithRatings: movieWithRatings) else {
      return nil
    }
    // need to update Eustace to support async operations to resolve it via DI
    return await MovieDetailViewController(viewModel: viewModel)
  }
  
}
