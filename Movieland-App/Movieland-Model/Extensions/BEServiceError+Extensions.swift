//
//  BEServiceError+Extensions.swift
//  Movieland-Model
//
//  Created by Massimiliano Faustini on 21/05/23.
//

import Foundation

public extension BEServiceError {
  var displayableMessage: String {
    switch self {
    case .unknown, .unableToBuildValidURL, .unableToRetrieveDecodableData:
      return "An error has occurred, please retry later. 🙄"
    case .emailNotConfirmed:
      return "Unable to fulfill request, please ensure your email has been confirmed ✉️"
    case .suspendedAccount:
      return "Unable to fulfill request, your account has been suspended 🫤"
    case .serverBusy:
      return "We are experiencing high traffic volumes. Please retry later ⏰"
    case .listIsEmpty:
      return "Uhm... looks like there is nothing like that around... 🌵"
    case .maximumUsage:
      return "Maximum usage per day ecceeded ⚖️"
    }
  }
}
