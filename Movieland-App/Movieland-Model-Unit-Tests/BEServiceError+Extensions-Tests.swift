//
//  BEServiceError+Extensions-Tests.swift
//  Movieland-Model-Unit-Tests
//
//  Created by Massimiliano Faustini on 21/05/23.
//

import XCTest

@testable import Movieland_Model

final class BEServiceError_Extensions_Tests: XCTestCase {
  
  var sut: BEServiceError!

  func test_GivenSutIsEmailNotConfirmed_ThenDisplayableMessageIsAsExpexted() throws {
    sut = .emailNotConfirmed
    XCTAssertEqual(sut.displayableMessage, "Unable to fulfill request, please ensure your email has been confirmed ✉️")
  }
  
  func test_GivenSutIsListIsEmpty_ThenDisplayableMessageIsAsExpexted() throws {
    sut = .listIsEmpty
    XCTAssertEqual(sut.displayableMessage, "Uhm... looks like there is nothing like that around... 🌵")
  }
  
  func test_GivenSutIsServerBusy_ThenDisplayableMessageIsAsExpexted() throws {
    sut = .serverBusy
    XCTAssertEqual(sut.displayableMessage, "We are experiencing high traffic volumes. Please retry later ⏰")
  }
  
  func test_GivenSutIsSuspendedAccount_ThenDisplayableMessageIsAsExpexted() throws {
    sut = .suspendedAccount
    XCTAssertEqual(sut.displayableMessage, "Unable to fulfill request, your account has been suspended 🫤")
  }
  
  func test_GivenSutIsUnableToBuildValidURL_ThenDisplayableMessageIsAsExpexted() throws {
    sut = .unableToBuildValidURL
    XCTAssertEqual(sut.displayableMessage, "An error has occurred, please retry later. 🙄")
  }
  
  func test_GivenSutIsUnableToRetrieveDecodableData_ThenDisplayableMessageIsAsExpexted() throws {
    sut = .unableToRetrieveDecodableData
    XCTAssertEqual(sut.displayableMessage, "An error has occurred, please retry later. 🙄")
  }
  
  func test_GivenSutIsUnknown_ThenDisplayableMessageIsAsExpexted() throws {
    sut = .unknown
    XCTAssertEqual(sut.displayableMessage, "An error has occurred, please retry later. 🙄")
  }
  
}
