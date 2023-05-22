//
//  SearchMoviewCoordinatorMock.swift
//  Movieland-App-Unit-Tests
//
//  Created by Massimiliano Faustini on 21/05/23.
//

import UIKit

@testable import Movieland_App
import Movieland_Model
import Movieland_SharedMocks

final class SearchMovieCoordinatorMock: SearchMovieCoordinating {
  
  func setRootViewController(window: UIWindow) {
    
  }
  
  func navigateTo(location: LocationMock, completion: (()->Void)?) {}
  
  var didSelectMovieCalls: [MovieWithRatings] = .init()
  func didSelectMovie(movieWithRatings: MovieWithRatings) {
    didSelectMovieCalls.append(movieWithRatings)
  }
}
