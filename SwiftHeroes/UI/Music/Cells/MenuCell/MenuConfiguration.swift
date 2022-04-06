//
// Apple Music
//

import UIKit

struct MenuBackgroundConfiguration {
  private(set) var backgroundConfiguration: UIBackgroundConfiguration
  
  init() {
    backgroundConfiguration = UIBackgroundConfiguration.listPlainCell()
  }
  
  init(backgroundConfiguration: UIBackgroundConfiguration) {
    self.backgroundConfiguration = backgroundConfiguration
  }
  
  func updated(for state: UIConfigurationState) -> MenuBackgroundConfiguration {
    guard let state = state as? UICellConfigurationState else {
      return MenuBackgroundConfiguration()
    }
    
    var newBackgroundConfiguration = backgroundConfiguration

    if state.isHighlighted || state.isSelected {
      newBackgroundConfiguration.backgroundColor = .tintColor
    } else {
      newBackgroundConfiguration.backgroundColor = .clear
    }
    
    return MenuBackgroundConfiguration(backgroundConfiguration: newBackgroundConfiguration)
  }
}

struct MenuContentConfiguration {
  
  // MARK: - Stored Properties
  
  private let symbolConfiguration = UIImage.SymbolConfiguration(textStyle: .body)
  
  private(set) var listContentConfiguration: UIListContentConfiguration
  
  // MARK: - Init
    
  init(menuItem: MenuItem) {
    self.init()
    listContentConfiguration.image = UIImage(systemName: menuItem.iconName, withConfiguration: symbolConfiguration)
    listContentConfiguration.text = menuItem.title
  }
  
  fileprivate init(contentConfiguration: UIListContentConfiguration) {
    self.init()
    
    listContentConfiguration = contentConfiguration
  }

  private init() {
    var configuration = UIListContentConfiguration.cell()
    configuration.textProperties.font = .preferredFont(forTextStyle: .title2)
    configuration.directionalLayoutMargins.top = 14
    configuration.directionalLayoutMargins.bottom = 14
    self.listContentConfiguration = configuration
  }
  
  // MARK: - Functions
    
  func updated(for state: UICellConfigurationState) -> MenuContentConfiguration {
    var newContentConfiguration = listContentConfiguration

    if state.isHighlighted || state.isSelected {
      newContentConfiguration.imageProperties.tintColor = .white
      newContentConfiguration.textProperties.color = .white
    } else {
      newContentConfiguration.imageProperties.tintColor = .tintColor
      newContentConfiguration.textProperties.color = .label
    }
    
    return MenuContentConfiguration(contentConfiguration: newContentConfiguration)
  }
}
