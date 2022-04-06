//
//  AppStoreViewController.swift
//  SwiftHeroes
//
//  Created by Gaetano Matonti on 07/03/22.
//

import UIKit

final class AppStoreViewController: UICollectionViewController {
  
  lazy var dataSource = AppStoreDataSource(collectionView: collectionView)
  
  convenience init() {
    self.init(collectionViewLayout: AppStoreLayout())
    
    title = "Apps"
    tabBarItem = UITabBarItem(
      title: "App Store",
      image: UIImage(systemName: "square.stack.3d.up"),
      selectedImage: UIImage(systemName: "square.stack.3d.up.fill")
    )
  }
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    view.backgroundColor = .systemBackground
    
    navigationController?.navigationBar.prefersLargeTitles = true
    
    dataSource.applyInitialSnapshot()
  }
  
  override func traitCollectionDidChange(_ previousTraitCollection: UITraitCollection?) {
    collectionView.collectionViewLayout.invalidateLayout()
  }
}
