//
//  ListDataSource.swift
//  SwiftHeroes
//
//  Created by Gaetano Matonti on 10/03/22.
//

import UIKit

enum ListSection: Int, CaseIterable {
  case locations
  case favourites
}

enum ListItem: Hashable {
  case header(String)
  case item(String)
}

final class ListDataSource: UICollectionViewDiffableDataSource<ListSection, ListItem> {
  convenience init(collectionView: UICollectionView) {
    let headerRegistration = UICollectionView.CellRegistration<UICollectionViewListCell, ListItem> { cell, _, item in
      guard case let .header(title) = item else {
        return
      }
      
      var contentConfiguration = cell.defaultContentConfiguration()
      contentConfiguration.text = title
      
      cell.contentConfiguration = contentConfiguration
      
      cell.accessories = [.outlineDisclosure()]
    }
    
    let itemRegistration = UICollectionView.CellRegistration<UICollectionViewListCell, ListItem> { cell, _, item in
      guard case let .item(title) = item else {
        return
      }
      
      var contentConfiguration = cell.defaultContentConfiguration()
      contentConfiguration.text = title
      
      cell.contentConfiguration = contentConfiguration
    }
    
    self.init(collectionView: collectionView) { collectionView, indexPath, item in
      switch item {
      case .header:
        return collectionView.dequeueConfiguredReusableCell(
          using: headerRegistration,
          for: indexPath,
          item: item
        )
        
      case .item:
        return collectionView.dequeueConfiguredReusableCell(
          using: itemRegistration,
          for: indexPath,
          item: item
        )
      }
    }
  }
  
  func applyInitialSnapshot() {
    var locationSectionSnapshot = NSDiffableDataSourceSectionSnapshot<ListItem>()
    
    let locationHeaderItem: ListItem = .header("Locations")
    locationSectionSnapshot.append([locationHeaderItem])
    locationSectionSnapshot.append(
      [
        .item("On My iPhone"),
        .item("iCloud Drive"),
        .item("Shared"),
        .item("Recently Deleted")
      ],
      to: locationHeaderItem
    )
    
    var favouriteSectionSnapshot = NSDiffableDataSourceSectionSnapshot<ListItem>()
    
    let favouritesHeaderItem: ListItem = .header("Favourites")
    favouriteSectionSnapshot.append([favouritesHeaderItem])
    favouriteSectionSnapshot.append(
      [
        .item("Documents"),
        .item("Downloads")
      ],
      to: favouritesHeaderItem
    )
    
    apply(locationSectionSnapshot, to: .locations)
    apply(favouriteSectionSnapshot, to: .favourites)
  }
}
