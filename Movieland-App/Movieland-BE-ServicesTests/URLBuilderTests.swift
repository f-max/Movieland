//
//  URLBuilderTests.swift
//  Movieland-BE-ServicesTests
//
//  Created by Massimiliano Faustini on 20/05/23.
//

import XCTest

@testable import Movieland_BE_Services

final class URLBuilderTests: XCTestCase {
  
  var sutWithMocks: URLBuilder!
  var sutWithDefaults: URLBuilder!
    
  override func setUpWithError() throws {
    
    sutWithMocks = .init(
      baseURLProvider: BaseURLProviderMock(),
      languageProvider: LanguageProviderMock(),
      keyProvider: KeyProviderMock()
    )
    
    sutWithDefaults = .init(
      .init(
        baseURLProvider: BaseURLProvider(),
        languageProvider: LanguageProvider(),
        keyProvider: KeyProvider()
      )
    )
    
  }

  // MARK: -  With mock dependencies
  
  func test_GivenASutWithMockDependencies_WhenCallingUrlForMovieList_ItWillProduceExpectedResult() throws {
    let url = sutWithMocks.urlForMovieList(searchExpression: "some search")
    XCTAssertEqual( url?.absoluteString, "https://baseURL/language/api/searchMovie/key/some%20search")
  }
  
  func test_GivenASutWithMockDependencies_WhenCallingUrlForMovieList_WithSpecialCharsSearchExpression_ItWillProduceExpectedResult() throws {
    let url = sutWithMocks.urlForMovieList(searchExpression: "£$%^&")
    XCTAssertEqual( url?.absoluteString, "https://baseURL/language/api/searchMovie/key/%C2%A3$%25%5E&")
  }
  
  func test_GivenASutWithMockDependencies_WhenCallingUrlForRatings_ItWillProduceExpectedResult() throws {
    let url = sutWithMocks.urlForMovieRatings(id: "someId")
    XCTAssertEqual( url?.absoluteString, "https://baseURL/language/api/ratings/key/someId")
  }
  
  func test_GivenASutWithMockDependencies_WhenCallingUrlForMoviewDetails_AndProvidingNoOptions_ItWillProduceExpectedResult() throws {
    let url = sutWithMocks.urlForMovieDetails(detailOptions: [], for: "someId")
    XCTAssertEqual(url?.absoluteString, "https://baseURL/language/api/title/key/someId/")
  }
  
  func test_GivenASutWithMockDependencies_WhenCallingUrlFormoviewDetail_AndProvidingOneOption_ItWillProduceExpectedResult() throws {
    let url = sutWithMocks.urlForMovieDetails(detailOptions: [.fullCast], for: "someId")
    XCTAssertEqual(url?.absoluteString, "https://baseURL/language/api/title/key/someId/fullCast,")
  }
  
  func test_GivenASutWithMockDependencies_WhenCallingUrlFormoviewDetail_AndProvidingTwoOptions_ItWillProduceExpectedResult() throws {
    let url = sutWithMocks.urlForMovieDetails(detailOptions: [.fullCast, .fullActor], for: "someId")
    XCTAssertEqual(url?.absoluteString, "https://baseURL/language/api/title/key/someId/fullCast,fullActor,")
  }
  
  // MARK: -  With default dependencies
  
  func test_GivenASutWithDefaultDependencies_WhenCallingUrlForMovieList_ItWillProduceExpectedResult() throws {
    let url = sutWithDefaults.urlForMovieList(searchExpression: "some search")
    XCTAssertEqual( url?.absoluteString, "https://imdb-api.com/en/api/searchMovie/k_aepvkpi5/some%20search")
  }
  
  func test_GivenASutWithDefaultDependencies_WhenCallingUrlForMovieList_WithSpecialCharsSearchExpression_ItWillProduceExpectedResult() throws {
    let url = sutWithDefaults.urlForMovieList(searchExpression: "£$%^&")
    XCTAssertEqual( url?.absoluteString, "https://imdb-api.com/en/api/searchMovie/k_aepvkpi5/%C2%A3$%25%5E&")
  }

  func test_GivenASutWithDefaultDependencies_WhenCallingUrlForRatings_ItWillProduceExpectedResult() throws {
    let url = sutWithDefaults.urlForMovieRatings(id: "someId")
    XCTAssertEqual( url?.absoluteString, "https://imdb-api.com/en/api/ratings/k_aepvkpi5/someId")
  }
  
  func test_GivenASutWithDefaultDependencies_WhenCallingUrlForMoviewDetails_AndProvidingNoOptions_ItWillProduceExpectedResult() throws {
    let url = sutWithDefaults.urlForMovieDetails(detailOptions: [], for: "tt1375666")
    XCTAssertEqual(url?.absoluteString, "https://imdb-api.com/en/api/title/k_aepvkpi5/tt1375666/")
  }
  
  func test_GivenASutWithDefaultDependencies_WhenCallingUrlFormoviewDetail_AndProvidingOneOption_ItWillProduceExpectedResult() throws {
    let url = sutWithDefaults.urlForMovieDetails(detailOptions: [.fullCast], for: "tt1375666")
    XCTAssertEqual(url?.absoluteString, "https://imdb-api.com/en/api/title/k_aepvkpi5/tt1375666/fullCast,")
  }
  
  func test_GivenASutWithDefaultDependencies_WhenCallingUrlFormoviewDetail_AndProvidingTwoOptions_ItWillProduceExpectedResult() throws {
    let url = sutWithDefaults.urlForMovieDetails(detailOptions: [.fullCast, .fullActor], for: "tt1375666")
    XCTAssertEqual(url?.absoluteString, "https://imdb-api.com/en/api/title/k_aepvkpi5/tt1375666/fullCast,fullActor,")
  }
}
