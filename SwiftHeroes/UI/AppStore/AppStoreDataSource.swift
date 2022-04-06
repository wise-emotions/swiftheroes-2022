//
//  AppStoreDataSource.swift
//  SwiftHeroes
//
//  Created by Gaetano Matonti on 09/03/22.
//

import UIKit

enum AppSection: Int, CaseIterable {
  case group
}

enum AppItem: Hashable {
  case app(_ identifier: App.ID)
}

fileprivate var storage = AppStoreDataSource.Storage()

final class AppStoreDataSource: UICollectionViewDiffableDataSource<AppSection, AppItem> {
  convenience init(collectionView: UICollectionView) {
    let appRegistration = UICollectionView.CellRegistration<AppCell, App> { cell, _, item in
      cell.title = item.title
      cell.caption = item.caption
    }
    
    self.init(collectionView: collectionView) { collectionView, indexPath, item in
      switch item {
      case let .app(identifier):
        return collectionView.dequeueConfiguredReusableCell(
          using: appRegistration,
          for: indexPath,
          item: storage.app(for: identifier)
        )
      }
    }
  }
  
  func applyInitialSnapshot() {
    var snapshot = NSDiffableDataSourceSnapshot<AppSection, AppItem>()
    snapshot.appendSections(AppSection.allCases)
    
    let items: [AppItem] = storage.apps.map { .app($0.id) }
    
    snapshot.appendItems(items, toSection: .group)
    
    apply(snapshot, animatingDifferences: false)
  }
}

extension AppStoreDataSource {
  struct Storage {
    let apps = [
      App(id: 0, title: "App", caption: "Lorem Ipsum"),
      App(id: 1, title: "App", caption: "Lorem Ipsum"),
      App(id: 2, title: "App", caption: "Lorem Ipsum"),
      App(id: 3, title: "App", caption: "Lorem Ipsum"),
      App(id: 4, title: "App", caption: "Lorem Ipsum"),
      App(id: 5, title: "App", caption: "Lorem Ipsum")
    ]
    
    func app(for identifier: App.ID) -> App? {
      apps.first { $0.id == identifier }
    }
  }
}
