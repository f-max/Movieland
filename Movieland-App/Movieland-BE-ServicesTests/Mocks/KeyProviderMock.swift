//
//  KeyProviderMock.swift
//  Movieland-BE-ServicesTests
//
//  Created by Massimiliano Faustini on 20/05/23.
//

import Foundation

@testable import Movieland_BE_Services


final class KeyProviderMock: KeyProviding {
  var key: String
  
  init(key: String = "key") {
    self.key = key
  }
}
