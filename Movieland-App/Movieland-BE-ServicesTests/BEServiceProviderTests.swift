//
//  BEServiceProviderTests.swift
//  Movieland-BE-ServicesTests
//
//  Created by Massimiliano Faustini on 21/05/23.
//

import XCTest

@testable import Movieland_BE_Services
import Movieland_Model

final class BEServiceProviderTests: XCTestCase {
  
  var sut: BEServiceProvider!
  var urlBuilderMock: URLBuilderMock!
  
  override func setUpWithError() throws {
    urlBuilderMock = .init()
    sut = .init(urlBuilder: urlBuilderMock)
  }
  
  
  // MARK: - fetchMovieList(_) tests
  
  func test_GivenAnySut_WhenSutCallsFetchMoviewList_ThenSutCallsUrlBuilderOnceAndWithRightParameter() async throws {
    _ = await sut.fetchMovieList(searchExpression: "someId")
    XCTAssertEqual(urlBuilderMock.urlForMovieListReceivedCalls, ["someId"])
  }
  
  func test_GivenURLBuilderReturnsNilURL_WhenSutCallsFetchMoviewList_ThenSutReturnsCorrectError() async throws {
    urlBuilderMock.urlForMovieListValueToReturn = nil
    let result = await sut.fetchMovieList(searchExpression: "someId")
    switch result {
    case .failure(.unableToBuildValidURL):
      break
    default:
      XCTFail("returned wrong result")
    }
  }
  
  func test_GivenURLBuilderReturnsURL_AndURLDoesntProvideData_WhenSutCallsFetchMoviewList_ThenSutReturnsCorrectError() async throws {
    guard let url = URL(string: "file://notExisting") else {
      XCTFail("wrong test setup")
      return
    }
    urlBuilderMock.urlForMovieListValueToReturn = url
    let result = await sut.fetchMovieList(searchExpression: "someId")
    switch result {
    case .failure(.unableToRetrieveDecodableData):
      break
    default:
      XCTFail("returned wrong result")
    }
  }
  
  func test_GivenURLBuilderReturnsURL_AndURLProvidesUndecodabldData_WhenSutCallsFetchMoviewList_ThenSutReturnsCorrectError() async throws {
    
    let bundle = Bundle(for: type(of: self))
    let path = bundle.path(forResource: "undecodableResponse", ofType: nil)
    
    guard let path = path, let url = URL(string: "file://" + path) else {
      XCTFail("wrong test setup")
      return
    }
    urlBuilderMock.urlForMovieListValueToReturn = url
    let result = await sut.fetchMovieList(searchExpression: "someId")
    switch result {
    case .failure(.unableToRetrieveDecodableData):
      break
    default:
      XCTFail("returned wrong result")
    }
  }
  
  func test_GivenURLBuilderReturnsURL_AndURLProvidesDecodableData_AndThereIsEmailNotConfirmedError_WhenSutCallsFetchMoviewList_ThenSutReturnsCorrectError() async throws {
    
    let bundle = Bundle(for: type(of: self))
    let path = bundle.path(forResource: "errorMessageEmailNotConfirmed", ofType: nil)
    
    guard let path = path, let url = URL(string: "file://" + path) else {
      XCTFail("wrong test setup")
      return
    }
    urlBuilderMock.urlForMovieListValueToReturn = url
    let result = await sut.fetchMovieList(searchExpression: "someId")
    switch result {
    case .failure(.emailNotConfirmed):
      break
    default:
      XCTFail("returned wrong result")
    }
  }
  
  func test_GivenURLBuilderReturnsURL_AndURLProvidesDecodableData_AndThereIsSuspendedAccountError_WhenSutCallsFetchMoviewList_ThenSutReturnsCorrectError() async throws {
    
    let bundle = Bundle(for: type(of: self))
    let path = bundle.path(forResource: "errorSuspendedAccount", ofType: nil)
    
    guard let path = path, let url = URL(string: "file://" + path) else {
      XCTFail("wrong test setup")
      return
    }
    urlBuilderMock.urlForMovieListValueToReturn = url
    let result = await sut.fetchMovieList(searchExpression: "someId")
    switch result {
    case .failure(.suspendedAccount):
      break
    default:
      XCTFail("returned wrong result")
    }
  }
  
  func test_GivenURLBuilderReturnsURL_AndURLProvidesDecodableData_AndThereIsServerBusyError_WhenSutCallsFetchMoviewList_ThenSutReturnsCorrectError() async throws {
    
    let bundle = Bundle(for: type(of: self))
    let path = bundle.path(forResource: "errorMessageServerBusy", ofType: nil)
    
    guard let path = path, let url = URL(string: "file://" + path) else {
      XCTFail("wrong test setup")
      return
    }
    urlBuilderMock.urlForMovieListValueToReturn = url
    let result = await sut.fetchMovieList(searchExpression: "someId")
    switch result {
    case .failure(.serverBusy):
      break
    default:
      XCTFail("returned wrong result")
    }
  }
  
  func test_GivenURLBuilderReturnsURL_AndURLProvidesDecodableData_AndThereListIsEmptyError_WhenSutCallsFetchMoviewList_ThenSutReturnsCorrectError() async throws {
    
    let bundle = Bundle(for: type(of: self))
    let path = bundle.path(forResource: "errorListIsEmpty", ofType: nil)
    
    guard let path = path, let url = URL(string: "file://" + path) else {
      XCTFail("wrong test setup")
      return
    }
    urlBuilderMock.urlForMovieListValueToReturn = url
    let result = await sut.fetchMovieList(searchExpression: "someId")
    switch result {
    case .failure(.listIsEmpty):
      break
    default:
      XCTFail("returned wrong result")
    }
  }
  
  func test_GivenURLBuilderReturnsURL_AndURLProvidesDecodableData_AndThereNoError_AndThereAreNoItems_WhenSutCallsFetchMoviewList_ThenSutReturnsEmptyList() async throws {
    
    let bundle = Bundle(for: type(of: self))
    let path = bundle.path(forResource: "noErrorNoItems", ofType: nil)
    
    guard let path = path, let url = URL(string: "file://" + path) else {
      XCTFail("wrong test setup")
      return
    }
    urlBuilderMock.urlForMovieListValueToReturn = url
    let result = await sut.fetchMovieList(searchExpression: "someId")
    switch result {
    case let .success(movies):
      XCTAssertEqual(movies.count, 0)
    default:
      XCTFail("returned wrong result")
    }
  }
  
  func test_GivenURLBuilderReturnsURL_AndURLProvidesDecodableData_AndThereNoError_AndThereIsOneItem_WhenSutCallsFetchMoviewList_ThenSutReturnsListWithSameItem() async throws {
    
    let bundle = Bundle(for: type(of: self))
    let path = bundle.path(forResource: "noErrorOneMovieItem", ofType: nil)
    
    guard let path = path, let url = URL(string: "file://" + path) else {
      XCTFail("wrong test setup")
      return
    }
    urlBuilderMock.urlForMovieListValueToReturn = url
    let result = await sut.fetchMovieList(searchExpression: "someId")
    switch result {
    case let .success(movies):
      let expectedMovie: Movie = .init(
        id: "tt1375666",
        image: "https://m.media-amazon.com/images/M/MV5BMjAxMzY3NjcxNF5BMl5BanBnXkFtZTcwNTI5OTM0Mw@@._V1_Ratio0.6800_AL_.jpg",
        title: "Inception"
      )
      XCTAssertEqual(movies.count, 1)
      XCTAssertEqual(movies.first, expectedMovie)
    default:
      XCTFail("returned wrong result")
    }
  }
  
  // MARK: - fetchMovieRatings(_) tests
  
  // To be implemented. Left out due to lack of time. It would follow the same approach as the above ones.

  // MARK: - fetchMovieDetails(_, _) tests
  
  // To be implemented. Left out due to lack of time. It would follow the same approach as the above ones.
  
}
