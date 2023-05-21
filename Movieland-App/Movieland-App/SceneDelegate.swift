//
//  SceneDelegate.swift
//  Movieland-App
//
//  Created by Massimiliano Faustini on 18/05/23.
//

import UIKit
import Eustace_inPackage
import Movieland_Model

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

  var window: UIWindow?
  var searchMovieCoordinator: (any SearchMovieCoordinating)?


  func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
    
    #if UNIT_TESTS
      return
    #endif
    
    guard let windowScene = (scene as? UIWindowScene) else { return }
    
    diContainer.initialise()
    
    searchMovieCoordinator = try? diContainer.resolve(serviceType: (any SearchMovieCoordinating).self)
    guard let searchMovieCoordinator = searchMovieCoordinator else {
      return
    }
    
    let windowForScene = UIWindow(windowScene: windowScene)
    window = windowForScene
    searchMovieCoordinator.setRootViewController(window: windowForScene)
  }

  func sceneDidDisconnect(_ scene: UIScene) {}
  func sceneDidBecomeActive(_ scene: UIScene) {}
  func sceneWillResignActive(_ scene: UIScene) {}
  func sceneWillEnterForeground(_ scene: UIScene) {}
  func sceneDidEnterBackground(_ scene: UIScene) {}
  
}
