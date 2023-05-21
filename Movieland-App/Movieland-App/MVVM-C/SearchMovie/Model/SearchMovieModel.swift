//
//  SearchMovieModel.swift
//  Movieland-App
//
//  Created by Massimiliano Faustini on 21/05/23.
//

import Foundation
import  Movieland_Model

final class SearchMovieModel: SearchMovieModeling {
  
  var service: SearchMovieServicing
  
  init(service: SearchMovieServicing) {
    self.service = service
  }
  
}
