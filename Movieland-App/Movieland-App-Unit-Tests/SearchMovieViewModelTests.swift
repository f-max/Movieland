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
  
  
  func test_GivenAnySut_ThenSearchingCopyIsAsExpected() {
    XCTAssertEqual(sut.searchingCopy, "Searching... 👀")
  }
  
  func test_GivenAnySut_ThenNoResultsCopyIsAsExpected() {
    XCTAssertEqual(sut.noResultsCopy, "No results 🤷🏻‍♂️")
  }
  
  func test_GivenSearchExpressionIsEmpty_WhenUserPerformsSearchAction_ThenServiceIsInvokedWithEmptyQuery() async throws {
    sut.searchExpression = ""
    await sut.didPerformSearchAction()
    XCTAssertEqual(serviceMock.receivedFetchMovieListCalls, [""])
  }
  
  func test_GivenSearchExpressionHasOneChar_WhenUserPerformsSearchAction_ThenServiceIsInvokedWithCorrectQuery() async throws {
    sut.searchExpression = "l"
    await sut.didPerformSearchAction()
    XCTAssertEqual(serviceMock.receivedFetchMovieListCalls, ["l"])
  }
  
  func test_GivenSearchExpressionHasMoreThanOneChar_WhenUserPerformsSearchAction_ThenServiceIsInvokedWithCorrectQuery() async throws {
    sut.searchExpression = "ghost"
    await sut.didPerformSearchAction()
    XCTAssertEqual(serviceMock.receivedFetchMovieListCalls, ["ghost"])
  }
  
  func test_GivenServiceReturnsErrorMessage_WhenServiceIsInvoked_ThenSUTErrorMessageWillPopulateAccordingly() async throws {
    serviceMock.fetchMovieListValueToReturn = .failure(.emailNotConfirmed)
    await sut.didPerformSearchAction()
    XCTAssertEqual(sut.errorMessage, "Unable to fulfill request, please ensure your email has been confirmed ✉️")
  }
  
  func test_GivenServiceReturnsErrorMessage_WhenServiceIsInvoked_AndUserDismissesTheAlert_ThenSUTErrorMessageWillBeDeleted() async throws {
    serviceMock.fetchMovieListValueToReturn = .failure(.emailNotConfirmed)
    await sut.didPerformSearchAction()
    await sut.didPerformAlertOkAction()
    XCTAssertEqual(sut.errorMessage, "")
  }
  
  func test_GivenServiceReturnsonNoError_AndEmptyList_WhenServiceIsInvoked_ThenSUTListWillBePopulatedAccordingly() async throws {
    serviceMock.fetchMovieListValueToReturn = .success([])
    await sut.didPerformSearchAction()
    XCTAssertEqual(sut.movies, [])
  }
  
  func test_GivenServiceReturnsonNoError_AndNonEmptyList_WhenServiceIsInvoked_ThenSUTListWillBePopulatedAccordingly() async throws {
    
    let movie_0: Movie = .init(id: "someId", image: "someImage", title: "someTitle")
    let movie_1: Movie = .init(id: "someOtherId", image: "someOtherImage", title: "someOtherTitle")
    
    let movieWithRatings_0: MoviewWithRatings = .init(movie: movie_0, ratings: nil)
    let movieWithRatings_1: MoviewWithRatings = .init(movie: movie_1, ratings: nil)
    
    serviceMock.fetchMovieListValueToReturn = .success([movie_0, movie_1])
    await sut.didPerformSearchAction()
    XCTAssertEqual(sut.movies, [movieWithRatings_0, movieWithRatings_1])
  }
  
  func test_GivenSutHasMovies_WhenUserChangesSearchExpression_ThenSutDeletesAllMovies() async {
    let movie_0: Movie = .init(id: "someId", image: "someImage", title: "someTitle")
    let movie_1: Movie = .init(id: "someOtherId", image: "someOtherImage", title: "someOtherTitle")
    
    let movieWithRatings_0: MoviewWithRatings = .init(movie: movie_0, ratings: nil)
    let movieWithRatings_1: MoviewWithRatings = .init(movie: movie_1, ratings: nil)
    
    sut.searchExpression = "some expression"
    sut.movies = [movieWithRatings_0, movieWithRatings_1]
    await sut.didUpdate(searchExpression: "some expressio")
    
    XCTAssertEqual(sut.movies, [])
  }
  
}
