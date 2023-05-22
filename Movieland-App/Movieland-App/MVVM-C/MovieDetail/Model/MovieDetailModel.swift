//
//  MoviewDetailModel.swift
//  Movieland-App
//
//  Created by Massimiliano Faustini on 22/05/23.
//

import Foundation
import Movieland_Model

final class MovieDetailModel: MovieDetailModeling {
  var service: MovieDetailServicing
  
  init(service: MovieDetailServicing) {
    self.service = service
  }
}
