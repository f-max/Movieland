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

  func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
    
    guard let windowScene = (scene as? UIWindowScene) else { return }
    
    diContainer.initialise()
    
    window = UIWindow(windowScene: windowScene)
    window?.rootViewController = ViewController()
    window?.rootViewController?.view.backgroundColor = .lightGray

    window?.makeKeyAndVisible()
  }

  func sceneDidDisconnect(_ scene: UIScene) {}
  func sceneDidBecomeActive(_ scene: UIScene) {}
  func sceneWillResignActive(_ scene: UIScene) {}
  func sceneWillEnterForeground(_ scene: UIScene) {}
  func sceneDidEnterBackground(_ scene: UIScene) {}
  
}

/*
 if let service = try? diContainer.resolve(serviceType: BEServiceProviding.self) {
   Task {
     let result = await service.fetchMovieList(searchExpression: "ghost")
     switch result {
     case let .failure(error):
       print(error.displayableMessage)
     case let .success(movies): // turn into futures?
       //fetchRatingsForMovies(movies: [Movies])
       break
     }
   }
 }
 */
