//
//  Person.swift
//  Movieland-Model
//
//  Created by Massimiliano Faustini on 21/05/23.
//

import Foundation

public struct Person: Codable {
  let id: String
  let name: String
  let image: String?
  let descriprion: String?
  let asCharacter: String?
}
