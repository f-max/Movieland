//
//  SearchMovieViewModelTests.swift
//  Movieland-App-Unit-Tests
//
//  Created by Massimiliano Faustini on 21/05/23.
//

import XCTest

@testable import Movieland_App
import Movieland_Model
import Movieland_SharedMocks

final class SearchMovieViewModelTests: XCTestCase {
  
  var sut: SearchMovieViewModel!
  var serviceMock: BEServiceProviderMock!
  var modelMock: SearchMovieModelMock!
  var coordinatorMock: SearchMoviewCoordinatorMock!
  
  @MainActor
  override func setUpWithError() throws {
    serviceMock = .init()
    modelMock = .init(service: serviceMock)
    coordinatorMock = .init()
    sut = .init(
      model: modelMock,
      coordinator: coordinatorMock
    )
  }
  
  
  func testExample() throws {
    
  }
  
  
}
