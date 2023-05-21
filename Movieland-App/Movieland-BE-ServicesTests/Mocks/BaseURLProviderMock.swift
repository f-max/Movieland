//
//  BaseURLProviderMock.swift
//  Movieland-BE-ServicesTests
//
//  Created by Massimiliano Faustini on 20/05/23.
//

import Foundation

@testable import Movieland_BE_Services

final class BaseURLProviderMock: BaseURLProviding {
  var baseURL: String
  
  init(baseURL: String = "baseURL") {
    self.baseURL = baseURL
  }
}
