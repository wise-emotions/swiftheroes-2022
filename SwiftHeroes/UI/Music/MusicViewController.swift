//
//  MusicViewController.swift
//  SwiftHeroes
//
//  Created by Gaetano Matonti on 07/03/22.
//

import UIKit

final class MusicViewController: UICollectionViewController {
  lazy var dataSource = MusicDataSource(collectionView: collectionView)
  
  convenience init() {
    self.init(collectionViewLayout: MusicLayout())
    
    title = "Library"
    tabBarItem = UITabBarItem(
      title: "Music",
      image: UIImage(systemName: "square.stack"),
      selectedImage: UIImage(systemName: "square.stack.fill")
    )
  }
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    view.backgroundColor = .systemBackground
    view.tintColor = .systemPink
    
    navigationController?.navigationBar.tintColor = .systemPink
    navigationController?.navigationBar.prefersLargeTitles = true
    navigationItem.setRightBarButton(editButtonItem, animated: false)
    
    dataSource.applyInitialSnapshot()
  }
  
  override func setEditing(_ editing: Bool, animated: Bool) {
    super.setEditing(editing, animated: animated)
    
    dataSource.setEditing(editing)
  }
}
