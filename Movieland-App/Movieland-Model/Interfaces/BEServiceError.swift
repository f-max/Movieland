//
//  BEServiceError.swift
//  Movieland-Model
//
//  Created by Massimiliano Faustini on 21/05/23.
//

import Foundation

public enum BEServiceError: Error {
  case emailNotConfirmed
  case listIsEmpty
  case serverBusy
  case suspendedAccount
  case unableToBuildValidURL
  case unableToRetrieveDecodableData
  case unknown
}
