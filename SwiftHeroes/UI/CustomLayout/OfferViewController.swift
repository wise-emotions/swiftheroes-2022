//
//  ContentView.swift
//  SwiftHeroes
//
//  Created by Gaetano Matonti on 04/03/22.
//

import UIKit

final class OfferViewController: UICollectionViewController {
  private lazy var dataSource = OfferDataSource(collectionView: collectionView)
  
  convenience init() {
    self.init(collectionViewLayout: OfferLayout())
    
    tabBarItem = UITabBarItem(
      title: "Custom Layout",
      image: UIImage(systemName: "seal"),
      selectedImage: UIImage(systemName: "seal.fill")
    )
  }
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    collectionView.backgroundColor = .clear
    collectionView.contentInset.bottom = 24
    view.backgroundColor = .systemGroupedBackground
    
    dataSource.applyInitialSnapshot()
  }
  
  override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
    guard let item = dataSource.itemIdentifier(for: indexPath) else {
      return
    }
    
    guard case let .category(identifier) = item else {
      return
    }
    
    dataSource.toggleCategoryExpansion(for: identifier)
  }
}
