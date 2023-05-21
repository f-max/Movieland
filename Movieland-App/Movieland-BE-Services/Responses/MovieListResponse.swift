//
//  MovieListResponse.swift
//  Movieland-BE-Services
//
//  Created by Massimiliano Faustini on 20/05/23.
//

import Foundation
import Movieland_Model

struct MovieListResponse: Codable {
  let errorMessage: String
  let results: [Movie]
}
