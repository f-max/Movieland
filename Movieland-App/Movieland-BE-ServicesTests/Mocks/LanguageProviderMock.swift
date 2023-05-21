//
//  LanguageProviderMock.swift
//  Movieland-BE-ServicesTests
//
//  Created by Massimiliano Faustini on 20/05/23.
//

import Foundation

@testable import Movieland_BE_Services
import Movieland_Model

final class LanguageProviderMock: LanguageProviding {
  var language: String
  
  init(language: String = "language") {
    self.language = language
  }
}

final class URLBuilderMock: URLBuilding {
  
  var urlForMovieListReceivedCalls = [String]()
  var urlForMovieListValueToReturn: URL?
  func urlForMovieList(searchExpression: String) -> URL? {
    urlForMovieListReceivedCalls.append(searchExpression)
    return urlForMovieListValueToReturn
  }
  
  var urlForMovieRatingsReceivedCalls = [String]()
  var urlForMovieRatingsValueToReturn: URL?
  func urlForMovieRatings(id: String) -> URL? {
    urlForMovieRatingsReceivedCalls.append(id)
    return urlForMovieRatingsValueToReturn
  }
  
  var urlForMovieDetailsReceivedCalls = [(detailOptions: [TitleDetailOptions], id: String)]()
  var urlForMovieDetailsValueToReturn: URL?
  func urlForMovieDetails(detailOptions: [TitleDetailOptions], for id: String) -> URL? {
    urlForMovieDetailsReceivedCalls.append((detailOptions: detailOptions, id: id))
    return urlForMovieDetailsValueToReturn
  }
  
}
