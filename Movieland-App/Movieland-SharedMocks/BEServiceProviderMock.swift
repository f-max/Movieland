//
//  BEServiceProviderMock.swift
//  SharedMocks
//
//  Created by Massimiliano Faustini on 20/05/23.
//

import Foundation
import Movieland_Model

public final class BEServiceProviderMock: BEServiceProviding {
  public var delayInSeconds: UInt64 = 0
  public var receivedFetchMovieListCalls: [String] = []
  public var fetchMovieListValueToReturn: Result<[Movie], BEServiceError>
  
  public func fetchMovieList(searchExpression: String) async -> Result<[Movie], BEServiceError> {
    receivedFetchMovieListCalls.append(searchExpression)
    try? await Task.sleep(nanoseconds: delayInSeconds * 1_000_000_000)
    return fetchMovieListValueToReturn
  }

  public var receivedMovieRatingsCalls: [String] = []
  public var fetchMovieRatingsValueToReturn: Result<Ratings, BEServiceError>
  public func fetchMovieRatings(id: String) async -> Result<Ratings, BEServiceError> {
    receivedMovieRatingsCalls.append(id)
    try? await Task.sleep(nanoseconds: delayInSeconds * 1_000_000_000)
    return fetchMovieRatingsValueToReturn
  }
  
  
  public var receivedFetchMovieDetails: [(detailOptions: [TitleDetailOptions], id: String)] = []
  public var fetchMovieDetailsValueToReturn: Result<MovieWithDetails, BEServiceError>
  public func fetchMovieDetails(detailOptions: TitleDetailOptions..., for id: String) async -> Result<MovieWithDetails, BEServiceError> {
    receivedFetchMovieDetails.append((detailOptions: detailOptions, id: id))
    try? await Task.sleep(nanoseconds: delayInSeconds * 1_000_000_000)
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
