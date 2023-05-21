//
//  MovideDetailsResponse.swift
//  Movieland-BE-Services
//
//  Created by Massimiliano Faustini on 21/05/23.
//

import Foundation
import Movieland_Model

struct MovieDetailsResponse: Codable {
  let actorList: [Person]
  let directorList: [Person]
  let errorMessage: String
  let id: String
  let image: String
  let plot: String
  let ratings: Ratings
  let starList: [Person]
  let title: String
  let writerList: [Person]
  let year: String
}

extension MovieDetailsResponse {
  var movieWithDetails: MovieWithDetails {
    .init(
      fullCast: self.cast,
      movie: self.movie,
      plot: self.plot,
      ratings: self.ratings,
      starList: self.starList,
      year: self.year
    )
  }
  
  var cast: Cast {
    .init(
      actorList: self.actorList,
      directorList: self.directorList,
      writerList: self.writerList
    )
  }
  
  var movie: Movie {
    .init(
      id: self.id,
      image: self.image,
      title: self.title
    )
  }
  
}
