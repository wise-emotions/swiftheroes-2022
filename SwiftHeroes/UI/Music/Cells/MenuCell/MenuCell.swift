//
// Apple Music
//

import UIKit

final class MenuCell: UICollectionViewListCell {
  var menuContentConfiguration: MenuContentConfiguration? {
    willSet {
      contentConfiguration = newValue?.listContentConfiguration
    }
  }
  
  override init(frame: CGRect) {
    super.init(frame: frame)
    
    style()
  }
  
  required init?(coder: NSCoder) {
    return nil
  }
  
  func style() {
    accessories = [
      .disclosureIndicator(displayed: .whenNotEditing),
      .reorder(),
      .multiselect(displayed: .whenEditing)
    ]
    
    backgroundConfiguration = MenuBackgroundConfiguration().backgroundConfiguration
  }
  
  override func updateConfiguration(using state: UICellConfigurationState) {
    contentConfiguration = menuContentConfiguration?.updated(for: state).listContentConfiguration
    
    if let backgroundConfiguration = backgroundConfiguration {
      let newBackgroundConfiguration = MenuBackgroundConfiguration(backgroundConfiguration: backgroundConfiguration)
        .updated(for: state)
        .backgroundConfiguration

      self.backgroundConfiguration = newBackgroundConfiguration
    }
    
    separatorLayoutGuide.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20).isActive = true
  }
}
