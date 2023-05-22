//
//  SceneDelegate+ModelInitialiser.swift
//  Movieland-App
//
//  Created by Massimiliano Faustini on 20/05/23.
//

import Foundation

import Eustace_inPackage
import Movieland_BE_Services
import Movieland_Model
import Movieland_SharedMocks

let diContainer = Eustace_inPackage.Container()

extension Eustace_inPackage.Container {
  func initialise() {
    initialiseCommon()
    initialiseAsPerBuildConfiguration()
  }
}
 

private extension Eustace_inPackage.Container {
  func initialiseCommon() {
    register(serviceType: (any SearchMovieCoordinating).self) {
      SearchMovieCoordinator()
    }
    register(serviceType: (any MovieDetailCoordinating).self) {
      MovieDetailCoordinator()
    }
  }
}

#if DEBUG

private extension Eustace_inPackage.Container {
  func initialiseAsPerBuildConfiguration() {
    
    register(serviceType: BEServiceProviding.self) {
      let service = BEServiceProviderMock()
      service.delayInSeconds = 3
      service.fetchMovieListValueToReturn = .failure(.emailNotConfirmed)
      return service
    }
    
    register(serviceType: SearchMovieServicing.self) {
      let service = BEServiceProviderMock()
      service.delayInSeconds = 3
      
      // Choose which one to uncomment
      
      //service.fetchMovieListValueToReturn = .failure(.suspendedAccount)
      //service.fetchMovieListValueToReturn = .success([])
      
      let movie_0: Movie = .init(id: "someId0", image: "someImage", title: "Some title 0 ")
      let movie_1: Movie = .init(id: "someId1", image: "someImage", title: "Some title 1")
      service.fetchMovieListValueToReturn = .success([movie_0, movie_1])
      
      return service
    }
    
    register(serviceType: MovieDetailServicing.self) {
      let service = BEServiceProviderMock()
      return service
    }
    
  }
}

#elseif RELEASE

private extension Eustace_inPackage.Container {
  func initialiseAsPerBuildConfiguration() {
    
    register(serviceType: BaseURLProviding.self) {
      BaseURLProvider()
    }
    
    register(serviceType: LanguageProviding.self) {
      LanguageProvider()
    }
    
    register(serviceType: KeyProviding.self) {
      KeyProvider()
    }
    
    register(serviceType: URLBuilding.self) { [weak self] in
      guard let baseURLProvider = try? self?.resolve(serviceType: BaseURLProviding.self),
              let languageProvider = try? self?.resolve(serviceType: LanguageProviding.self),
              let keyProvider = try? self?.resolve(serviceType: KeyProviding.self) else {
        return nil
      }
      return URLBuilder(
        baseURLProvider: baseURLProvider,
        languageProvider: languageProvider,
        keyProvider: keyProvider
      )
    }
    
    register(serviceType: BEServiceProviding.self) { [weak self] in
      guard let urlBuilder = try? self?.resolve(serviceType: URLBuilding.self) else {
        return nil
      }
      return BEServiceProvider(urlBuilder: urlBuilder)
    }
    
    register(serviceType: SearchMovieServicing.self) { [weak self] in
      guard let urlBuilder = try? self?.resolve(serviceType: URLBuilding.self) else {
        return nil
      }
      return BEServiceProvider(urlBuilder: urlBuilder)
    }
    
    register(serviceType: MovieDetailServicing.self) { [weak self] in
      guard let urlBuilder = try? self?.resolve(serviceType: URLBuilding.self) else {
        return nil
      }
      return BEServiceProvider(urlBuilder: urlBuilder)
    }
    
  }
}

#elseif UNIT_TESTS

private extension Eustace_inPackage.Container {
  func initialiseAsPerBuildConfiguration() {
  }
}

#else

#endif
