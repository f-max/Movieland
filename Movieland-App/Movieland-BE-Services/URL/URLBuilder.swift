//
//  URLBuilder.swift
//  Movieland-BE-Services
//
//  Created by Massimiliano Faustini on 20/05/23.
//

import Foundation
import Movieland_Model

public final class URLBuilder: URLBuilding {
  
  let baseURLProvider: BaseURLProviding
  let languageProvider: LanguageProviding
  let keyProvider: KeyProviding
  
  public init(
    baseURLProvider: BaseURLProviding,
    languageProvider: LanguageProviding,
    keyProvider: KeyProviding
  ) {
    self.baseURLProvider = baseURLProvider
    self.languageProvider = languageProvider
    self.keyProvider = keyProvider
  }
}

public extension URLBuilder {
  func urlForMovieList(searchExpression: String) -> URL? {
    URL(
      string: "https://" + baseURLProvider.baseURL + "/"
    )?
    
      .appendingPathComponent(languageProvider.language)
      .appendingPathComponent("api")
      .appendingPathComponent(EndPoints.searchMovie)
      .appendingPathComponent(keyProvider.key)
      .appendingPathComponent(searchExpression)
  }
}

public extension URLBuilder {
  func urlForMovieRatings(id: String) -> URL? {
    URL(
      string: "https://" + baseURLProvider.baseURL + "/"
    )?
    
      .appendingPathComponent(languageProvider.language)
      .appendingPathComponent("api")
      .appendingPathComponent(EndPoints.ratings)
      .appendingPathComponent(keyProvider.key)
      .appendingPathComponent(id)
  }
}

public extension URLBuilder {
  func urlForMovieDetails(detailOptions: [TitleDetailOptions], for id: String) -> URL? {
    URL(
      string: "https://" + baseURLProvider.baseURL + "/"
    )?
    
      .appendingPathComponent(languageProvider.language)
      .appendingPathComponent("api")
      .appendingPathComponent(EndPoints.title)
      .appendingPathComponent(keyProvider.key)
      .appendingPathComponent(id)
      .appendingPathComponent(detailOptions.reduce("", {
        $0 + $1.rawValue + ","
      }))
  }
}
