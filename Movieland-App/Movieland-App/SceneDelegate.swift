//
//  SceneDelegate.swift
//  Movieland-App
//
//  Created by Massimiliano Faustini on 18/05/23.
//

import UIKit
import Eustace_inPackage

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

  var window: UIWindow?


  func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
    
    guard let windowScene = (scene as? UIWindowScene) else { return }
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
