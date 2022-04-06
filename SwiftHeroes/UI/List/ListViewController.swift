//
//  ListViewController.swift
//  SwiftHeroes
//
//  Created by Gaetano Matonti on 10/03/22.
//

import UIKit

final class ListViewController: UICollectionViewController {
  lazy var dataSource = ListDataSource(collectionView: collectionView)
  
  convenience init() {
    var listConfiguration = UICollectionLayoutListConfiguration(appearance: .sidebar)
    listConfiguration.headerMode = .firstItemInSection
    let layout = UICollectionViewCompositionalLayout.list(using: listConfiguration)
    
    self.init(collectionViewLayout: layout)
    
    title = "List"
    tabBarItem = UITabBarItem(
      title: "List",
      image: UIImage(systemName: "list.bullet.rectangle.portrait"),
      selectedImage: UIImage(systemName: "list.bullet.rectangle.portrait.fill")
    )
  }
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    navigationController?.navigationBar.prefersLargeTitles = true
    
    dataSource.applyInitialSnapshot()
  }
}
