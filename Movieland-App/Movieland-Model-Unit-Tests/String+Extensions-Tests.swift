//
//  String+Extensions-Tests.swift
//  Movieland-Model-Unit-Tests
//
//  Created by Massimiliano Faustini on 21/05/23.
//

import XCTest

final class String_Extensions_Tests: XCTestCase {
  
  var sut: String!
  
  func test_GivenSutIsTheExpectedOne_ThenItMapsToEmailNotConfirmedError() throws {
    sut = "Email not confirmed"
    XCTAssertEqual(sut.beServiceError, .emailNotConfirmed)
  }
  
  func test_GivenSutIsTheExpectedOne_ThenItMapsToSuspendedError() throws {
    sut = "Your account has been suspended."
    XCTAssertEqual(sut.beServiceError, .suspendedAccount)
  }
  
  func test_GivenSutIsTheExpectedOne_ThenItMapsToServerBusyError() throws {
    sut = "Server busy"
    XCTAssertEqual(sut.beServiceError, .serverBusy)
  }
  
  func test_GivenSutIsTheExpectedOne_ThenItMapsToListIsEmptyError() throws {
    sut = "List is empty"
    XCTAssertEqual(sut.beServiceError, .listIsEmpty)
  }
  
  func test_GivenSutIsNoneOfTheExpectedOnes_ThenItMapsToUnknwonError() throws {
    sut = "some string"
    XCTAssertEqual(sut.beServiceError, .unknown)
  }
  
}
