//
//  Person.swift
//  Movieland-Model
//
//  Created by Massimiliano Faustini on 21/05/23.
//

import Foundation

public struct Person: Codable {
  public let id: String
  public let name: String
  public let image: String?
  public let descriprion: String?
  public let asCharacter: String?
}
