//
//  BEServiceProvider.swift
//  Movieland-BE-Services
//
//  Created by Massimiliano Faustini on 20/05/23.
//

import Foundation
import Movieland_Model

public final class BEServiceProvider: BEServiceProviding {
  
  let urlBuilder: URLBuilding

  public func fetchMovieList(searchExpression: String) async -> Result<[Movie], BEServiceError> {
    guard let url = urlBuilder.urlForMovieList(searchExpression: searchExpression) else {
      return .failure(.unableToBuildValidURL)
    }
    do {
      let (data, _) = try await URLSession.shared.data(from: url)
      let decoded = try JSONDecoder().decode(MovieListResponse.self, from: data)
      
      guard decoded.errorMessage.isEmpty else {
        return .failure(decoded.errorMessage.beServiceError)
      }
      
      return .success(decoded.results)
    }
    catch {
      return .failure(.unableToRetrieveDecodableData)
    }
  }
  
  public func fetchMovieRatings(id: String) async -> Result<Ratings, Movieland_Model.BEServiceError> {
    guard let url = urlBuilder.urlForMovieRatings(id: id) else {
      return .failure(.unableToBuildValidURL)
    }
    do {
      let (data, _) = try await URLSession.shared.data(from: url)
      let decoded = try JSONDecoder().decode(MovieRatingsResponse.self, from: data)
      
      guard decoded.errorMessage.isEmpty else {
        return .failure(decoded.errorMessage.beServiceError)
      }
      
      return .success(decoded.ratings)
    }
    catch {
      return .failure(.unableToRetrieveDecodableData)
    }
  }
  
  public func fetchMovieDetails(detailOptions: TitleDetailOptions ..., for id: String) async -> Result<Movieland_Model.MovieWithDetails, BEServiceError> {
    guard let url = urlBuilder.urlForMovieDetails(detailOptions: detailOptions, for: id) else {
      return .failure(.unableToBuildValidURL)
    }
    do {
      let (data, _) = try await URLSession.shared.data(from: url)
      let decoded = try JSONDecoder().decode(MovieDetailsResponse.self, from: data)
      
      guard decoded.errorMessage.isEmpty else {
        return .failure(decoded.errorMessage.beServiceError)
      }
      
      return .success(decoded.movieWithDetails)
    }
    catch {
      return .failure(.unableToRetrieveDecodableData)
    }
  }
  
  public init(urlBuilder: URLBuilding) {
    self.urlBuilder = urlBuilder
  }
}
