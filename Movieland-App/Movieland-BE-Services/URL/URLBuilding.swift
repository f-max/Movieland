//
//  URLBuilding.swift
//  Movieland-BE-Services
//
//  Created by Massimiliano Faustini on 20/05/23.
//

import Foundation
import Movieland_Model

public protocol URLBuilding {
  func urlForMovieList(searchExpression: String) -> URL?
  func urlForMovieRatings(id: String) -> URL?
  func urlForMovieDetails(detailOptions: [TitleDetailOptions], for id: String) -> URL?
}
