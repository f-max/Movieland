//
//  SearchMovieModelMock.swift
//  Movieland-App-Unit-Tests
//
//  Created by Massimiliano Faustini on 21/05/23.
//

import Foundation

@testable import Movieland_App
import Movieland_Model
import Movieland_SharedMocks

final class SearchMovieModelMock: SearchMovieModeling {
  var service: SearchMovieServicing
  init(service: BEServiceProviderMock) {
    self.service = service
  }
}
