//
//  AppStoreLayout.swift
//  SwiftHeroes
//
//  Created by Gaetano Matonti on 09/03/22.
//

import UIKit

final class AppStoreLayout: UICollectionViewCompositionalLayout {
  convenience init() {
    self.init { _, environment in
      Self.appGroupSection(environment: environment)
    }
  }
  
  class func appGroupSection(environment: NSCollectionLayoutEnvironment) -> NSCollectionLayoutSection {
    let minimumItemHeight: CGFloat = environment.traitCollection.preferredContentSizeCategory.isAccessibilityCategory ? 64 * 2 : 64
    let itemHeight = UIFontMetrics.default.scaledValue(for: minimumItemHeight)
    let groupItemsCount = 3
    
    let itemSize = NSCollectionLayoutSize(
      widthDimension: .fractionalWidth(1),
      heightDimension: .estimated(itemHeight)
    )
    let item = NSCollectionLayoutItem(layoutSize: itemSize)
    item.contentInsets = NSDirectionalEdgeInsets(
      top: 0,
      leading: 4,
      bottom: 0,
      trailing: 4
    )
    
    item.edgeSpacing = NSCollectionLayoutEdgeSpacing(
      leading: nil,
      top: .fixed(UIFontMetrics.default.scaledValue(for: 8)),
      trailing: nil,
      bottom: .fixed(UIFontMetrics.default.scaledValue(for: 8))
    )
    
    let groupInset: CGFloat = 12
    let availableWidth = environment.container.effectiveContentSize.width - groupInset * 2
    
    let groupSize = NSCollectionLayoutSize(
      widthDimension: .absolute(availableWidth),
      heightDimension: .estimated(itemHeight * CGFloat(groupItemsCount))
    )
    let group = NSCollectionLayoutGroup.vertical(layoutSize: groupSize, subitem: item, count: groupItemsCount)
    
    let section = NSCollectionLayoutSection(group: group)
    section.orthogonalScrollingBehavior = .groupPagingCentered
  
    return section
  }
}
