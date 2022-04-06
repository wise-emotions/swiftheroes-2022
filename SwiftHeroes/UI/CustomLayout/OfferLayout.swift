//
//  OfferLayout.swift
//  SwiftHeroes
//
//  Created by Gaetano Matonti on 04/03/22.
//

import UIKit

final class OfferLayout: UICollectionViewCompositionalLayout {
  enum Decoration {
    static let serviceGroupBackground = "serviceGroupBackground"
  }
  
  convenience init() {
    let configuration = UICollectionViewCompositionalLayoutConfiguration()
    configuration.interSectionSpacing = 24

    self.init(sectionProvider: { sectionIndex, environment in
      switch sectionIndex {
      case .zero:
        return Self.offerSection(environment: environment)

      default:
        return Self.serviceSection()
      }
    }, configuration: configuration)
    
    register(ServiceGroupBackground.self, forDecorationViewOfKind: Decoration.serviceGroupBackground)
  }
  
  class func offerSection(environment: NSCollectionLayoutEnvironment) -> NSCollectionLayoutSection {
    let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .fractionalHeight(1))
    let item = NSCollectionLayoutItem(layoutSize: itemSize)
      
    let estimatedFocusedItemWidth = Self.estimatedFocusedItemWidth(for: environment.container.contentSize)
    let groupSize = NSCollectionLayoutSize(widthDimension: .absolute(estimatedFocusedItemWidth), heightDimension: .absolute(256))
    let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitems: [item])
    
    let section = NSCollectionLayoutSection(group: group)
    section.orthogonalScrollingBehavior = .groupPagingCentered
    section.contentInsets = NSDirectionalEdgeInsets(top: 24, leading: 0, bottom: 0, trailing: 0)
    
    section.visibleItemsInvalidationHandler = { items, offset, environment in
      for item in items {
        guard item.representedElementCategory == .cell else {
          continue
        }

        let scale = Self.scale(for: environment.container.contentSize, itemFrame: item.frame, contentOffset: offset)
        item.transform = CGAffineTransform(scaleX: scale, y: scale)
      }
    }
        
    return section
  }
  
  class func serviceSection() -> NSCollectionLayoutSection {
    let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .estimated(48))
    let item = NSCollectionLayoutItem(layoutSize: itemSize)
    
    let group = NSCollectionLayoutGroup.vertical(layoutSize: itemSize, subitems: [item])
    group.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: 16, bottom: 0, trailing: 16)
    
    let section = NSCollectionLayoutSection(group: group)
    section.interGroupSpacing = 24
    section.contentInsets = NSDirectionalEdgeInsets(top: 24, leading: 32, bottom: 24, trailing: 32)
    
    let backgroundItem = NSCollectionLayoutDecorationItem.background(elementKind: Decoration.serviceGroupBackground)
    backgroundItem.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: 32, bottom: 0, trailing: 32)
    section.decorationItems = [backgroundItem]
    
    return section
  }
  
  private class func estimatedFocusedItemWidth(for containerSize: CGSize) -> CGFloat {
    let focusedItemHorizontalInset = 32.0
    return containerSize.width - focusedItemHorizontalInset * 2
  }
  
  private class func estimatedUnfocusedItemWidth(for containerSize: CGSize) -> CGFloat {
    let visibleUnfocusedItemInset = 16.0
    return Self.estimatedFocusedItemWidth(for: containerSize) - visibleUnfocusedItemInset * 2
  }
    
  private class func scale(for containerSize: CGSize, itemFrame: CGRect, contentOffset: CGPoint) -> CGFloat {
    let maximumScale: CGFloat = 1
    
    let unfocusedItemScale = Self.estimatedUnfocusedItemWidth(for: containerSize) / Self.estimatedFocusedItemWidth(for: containerSize)
    
    let containerHorizontalCenter = containerSize.width / 2

    let distanceFromCenter = abs(itemFrame.midX - contentOffset.x - containerHorizontalCenter)

    return max(maximumScale - distanceFromCenter / containerSize.width, unfocusedItemScale)
  }
  
  // Alternative solution to the visibleItemsInvalidationHandler with estimated layout sizes.
  /*
  override func layoutAttributesForElements(in rect: CGRect) -> [UICollectionViewLayoutAttributes]? {
    guard let collectionView = collectionView else {
      return super.layoutAttributesForElements(in: rect)
    }
    
    let scrollViews = collectionView.subviews.compactMap { $0 as? UIScrollView }
    
    guard let orthogonalScrollView = scrollViews.first else {
      return super.layoutAttributesForElements(in: rect)
    }

    let attributes = super.layoutAttributesForElements(in: rect)
    
    attributes?.forEach { layoutAttributes in
      guard layoutAttributes.representedElementCategory == .cell && layoutAttributes.indexPath.section == .zero else {
        return
      }
      
      let scale = Self.scale(for: collectionView.frame.size, itemFrame: layoutAttributes.frame, contentOffset: orthogonalScrollView.contentOffset)
      layoutAttributes.transform = CGAffineTransform(scaleX: scale, y: scale)
    }
    
    return attributes
  }
  */
}
