//
//  BEServiceProviderMock.swift
//  SharedMocks
//
//  Created by Massimiliano Faustini on 20/05/23.
//

import Foundation
import Movieland_Model

public final class BEServiceProviderMock: BEServiceProviding {
  public var receivedFetchMovieListCalls: [String] = []
  public var fetchMovieListValueToReturn: Result<[Movie], BEServiceError>
  
  public func fetchMovieList(searchExpression: String) async -> Result<[Movie], BEServiceError> {
    receivedFetchMovieListCalls.append(searchExpression)
    return fetchMovieListValueToReturn
  }

  public var receivedmovieRatingsCalls: [String] = []
  public var fetchMovieRatingsValueToReturn: Result<Ratings, BEServiceError>
  public func fetchMovieRatings(id: String) async -> Result<Ratings, BEServiceError> {
    receivedmovieRatingsCalls.append(id)
    return fetchMovieRatingsValueToReturn
  }
  
  
  public var receivedFetchMovieDetails: [(detailOptions: [TitleDetailOptions], id: String)] = []
  public var fetchMovieDetailsValueToReturn: Result<MovieWithDetails, BEServiceError>
  public func fetchMovieDetails(detailOptions: TitleDetailOptions..., for id: String) async -> Result<MovieWithDetails, BEServiceError> {
    receivedFetchMovieDetails.append((detailOptions: detailOptions, id: id))
    return fetchMovieDetailsValueToReturn
  }
  
  
  public init(
    fetchMovieListValueToReturn: Result<[Movie], BEServiceError> = .failure(.unknown),
    fetchMovieRatingsValueToReturn: Result<Ratings, BEServiceError> = .failure(.unknown),
    fetchMovieDetailsValueToReturn: Result<MovieWithDetails, BEServiceError> = .failure(.unknown)
  ) {
    self.fetchMovieListValueToReturn = fetchMovieListValueToReturn
    self.fetchMovieRatingsValueToReturn = fetchMovieRatingsValueToReturn
    self.fetchMovieDetailsValueToReturn = fetchMovieDetailsValueToReturn
  }
  
}
