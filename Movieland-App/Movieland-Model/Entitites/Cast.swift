//
//  Cast.swift
//  Movieland-Model
//
//  Created by Massimiliano Faustini on 21/05/23.
//

import Foundation

public struct Cast: Codable {
  public let actorList: [Person]
  public let directorList: [Person]
  public let writerList: [Person]
  
  public init(actorList: [Person], directorList: [Person], writerList: [Person]) {
    self.actorList = actorList
    self.directorList = directorList
    self.writerList = writerList
  }
}
