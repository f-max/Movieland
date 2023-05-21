//
//  SearchMovieCoordinator.swift
//  Movieland-App
//
//  Created by Massimiliano Faustini on 21/05/23.
//

import UIKit
import Movieland_Model

final class SearchMovieCoordinator: SearchMovieCoordinating {
  func setRootViewController(window: UIWindow) {
    Task { @MainActor in
      window.rootViewController = await serchViewController()
      window.rootViewController?.view.backgroundColor = .lightGray
      window.makeKeyAndVisible()
    }
  }
  

  func navigateTo(location: SerchMovieLocations, completion: (() -> Void)?) {
    
  }
  
}

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
    return await SearchMoviewViewController(viewModel: viewModel)
  }
}
