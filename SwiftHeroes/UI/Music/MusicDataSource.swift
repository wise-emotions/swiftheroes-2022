//
// Apple Music
//

import UIKit

enum MusicSection: Int, CaseIterable {
  case menu
  case recents
}

enum MusicItem: Hashable {
  case menuItem(MenuItem)
  case music(Album)
}

final class MusicDataSource: UICollectionViewDiffableDataSource<MusicSection, MusicItem> {
  convenience init(collectionView: UICollectionView) {
    let menuItemRegistration = UICollectionView.CellRegistration<MenuCell, MenuItem> { cell, _, item in
      cell.menuContentConfiguration = MenuContentConfiguration(menuItem: item)
    }
    
    let recentsHeaderRegistration = UICollectionView.SupplementaryRegistration<RecentsHeaderView>(
      elementKind: UICollectionView.elementKindSectionHeader
    ) { view, _, _ in
      view.title = "Recently Added"
    }
    
    let musicItemRegistration = UICollectionView.CellRegistration<AlbumCell, Album> { cell, _, item in
      cell.title = item.title
      cell.subtitle = item.artist
    }
    
    self.init(collectionView: collectionView) { collectionView, indexPath, item in
      switch item {
      case let .menuItem(item):
        return collectionView.dequeueConfiguredReusableCell(
          using: menuItemRegistration,
          for: indexPath,
          item: item
        )
        
      case let .music(album):
        return collectionView.dequeueConfiguredReusableCell(
          using: musicItemRegistration,
          for: indexPath,
          item: album
        )
      }
    }
    
    supplementaryViewProvider = { [weak self] collectionView, kind, indexPath in
      guard let section = self?.sectionIdentifier(for: indexPath.section) else {
        return nil
      }
      
      if kind == UICollectionView.elementKindSectionHeader {
        switch section {
        case .menu:
          return nil
          
        case .recents:
          return collectionView.dequeueConfiguredReusableSupplementary(
            using: recentsHeaderRegistration,
            for: indexPath
          )
        }
      }
            
      return nil
    }
  }
  
  func applyInitialSnapshot() {
    var snapshot = NSDiffableDataSourceSnapshot<MusicSection, MusicItem>()
    snapshot.appendSections(MusicSection.allCases)
   
    let menuItems: [MusicItem] = [
      MenuItem(title: "Playlists", iconName: "music.note.list"),
      MenuItem(title: "Artists", iconName: "music.mic"),
      MenuItem(title: "Albums", iconName: "square.stack"),
      MenuItem(title: "Songs", iconName: "music.note"),
      MenuItem(title: "Genres", iconName: "guitars")
    ].map { .menuItem($0) }
    
    snapshot.appendItems(menuItems, toSection: .menu)
    
    let albums: [MusicItem] = [
      Album(
        title: "CRASH",
        artist: "Charli XCX"
      ),
      Album(
        title: "Planet Her",
        artist: "Doja Cat"
      ),
      Album(
        title: "Chromatica",
        artist: "Lady Gaga"
      ),
      Album(
        title: "Future Nostalgia",
        artist: "Dua Lipa"
      )
    ].map { .music($0) }
    
    snapshot.appendItems(albums, toSection: .recents)
    
    apply(snapshot)
  }
  
  func setEditing(_ isEditing: Bool) {
    reorderingHandlers.canReorderItem = { item in
      if case .menuItem = item {
        return isEditing
      }
      
      return false
    }
  }
}
