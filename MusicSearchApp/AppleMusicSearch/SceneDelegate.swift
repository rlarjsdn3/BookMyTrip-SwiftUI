//
//  SceneDelegate.swift
//  AppleMusicSearch
//
//  Created by 김건우 on 11/30/23.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {
    var window: UIWindow?
    
    func scene(
        _ scene: UIScene,
        willConnectTo session: UISceneSession,
        options connectionOptions: UIScene.ConnectionOptions) {
        guard let windowScene = (scene as? UIWindowScene) else { return }
        window = UIWindow(windowScene: windowScene)
        let musicNavVC = UINavigationController(rootViewController: MusicViewController())
        window?.rootViewController = musicNavVC
        window?.makeKeyAndVisible()
    }

}

