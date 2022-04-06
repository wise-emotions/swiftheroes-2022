//
// Apple Music
//

import UIKit

final class MusicLayout: UICollectionViewCompositionalLayout {
  convenience init() {
    let sectionProvider: UICollectionViewCompositionalLayoutSectionProvider = { sectionIndex, environment in
      guard let section = MusicSection(rawValue: sectionIndex) else {
        return nil
      }
      
      switch section {
      case .menu:
        return Self.menuSectionLayout(environment: environment)

      case .recents:
        return Self.recentsSectionLayout()
      }
    }
    
    let configuration = UICollectionViewCompositionalLayoutConfiguration()
    configuration.interSectionSpacing = 24
    
    self.init(sectionProvider: sectionProvider, configuration: configuration)
  }
  
  class func menuSectionLayout(environment: NSCollectionLayoutEnvironment) -> NSCollectionLayoutSection {
    let listConfiguration = UICollectionLayoutListConfiguration(appearance: .plain)
    
    return NSCollectionLayoutSection.list(
      using: listConfiguration,
      layoutEnvironment: environment
    )
  }
  
  class func recentsSectionHeader() -> NSCollectionLayoutBoundarySupplementaryItem {
    let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .estimated(1))
    let item = NSCollectionLayoutBoundarySupplementaryItem(
      layoutSize: itemSize,
      elementKind: UICollectionView.elementKindSectionHeader,
      alignment: .top
    )
    
    return item
  }
  
  class func recentsSectionLayout() -> NSCollectionLayoutSection {
    let itemSize = NSCollectionLayoutSize(
      widthDimension: .fractionalWidth(0.5),
      heightDimension: .estimated(1)
    )
    
    let item = NSCollectionLayoutItem(layoutSize: itemSize)
    
    let groupSize = NSCollectionLayoutSize(
      widthDimension: .fractionalWidth(1),
      heightDimension: itemSize.heightDimension
    )
    
    let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitem: item, count: 2)
    group.interItemSpacing = .fixed(20)
    
    let section = NSCollectionLayoutSection(group: group)
    section.interGroupSpacing = 16
    section.contentInsets = NSDirectionalEdgeInsets(top: 12, leading: 20, bottom: 8, trailing: 20)
    section.boundarySupplementaryItems = [recentsSectionHeader()]
    
    return section
  }
}
