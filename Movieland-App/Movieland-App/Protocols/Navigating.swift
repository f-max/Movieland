//
//  Navigating.swift
//  Movieland-App
//
//  Created by Massimiliano Faustini on 21/05/23.
//

import UIKit

protocol Navigating {
  associatedtype L: Location
  func navigateTo(location: L, completion: (()->Void)?) async
}

protocol Location {}
