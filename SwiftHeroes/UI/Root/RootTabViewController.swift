//
//  RootTabViewController.swift
//  SwiftHeroes
//
//  Created by Gaetano Matonti on 07/03/22.
//

import UIKit

final class RootTabViewController: UITabBarController {
  override func viewDidLoad() {
    viewControllers = [
      UINavigationController(rootViewController: ListViewController()),
      UINavigationController(rootViewController: AppStoreViewController()),
      UINavigationController(rootViewController: MusicViewController()),
      OfferViewController()
    ]
  }
}
