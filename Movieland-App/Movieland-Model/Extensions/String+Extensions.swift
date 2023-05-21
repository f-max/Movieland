//
//  String+Extensions.swift
//  Movieland-Model
//
//  Created by Massimiliano Faustini on 21/05/23.
//

import Foundation

// We are assuming that the list of possible error messages as per docs is not localised.
// We are intercepting the error message, mapping it to a list of possible cases, each of them with a displayable message, which in turn can be localised in the bundle.
public extension String {
  var beServiceError: BEServiceError {
    guard  !self.hasPrefix("Maximum usage") else {
      return .maximumUsage
    }
    
    switch self {
    case "Email not confirmed":
      return .emailNotConfirmed
    case "Your account has been suspended.":
      return .suspendedAccount
    case "Server busy":
      return .serverBusy
    case "List is empty":
      return .listIsEmpty
    default:
      return .unknown
    }
  }
}
