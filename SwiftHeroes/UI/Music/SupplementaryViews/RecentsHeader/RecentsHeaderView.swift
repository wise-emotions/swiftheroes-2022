//
// Apple Music
//

import UIKit

final class RecentsHeaderView: UICollectionReusableView {
  
  var title: String? {
    willSet {
      titleLabel.text = newValue
    }
  }
  
  // MARK: - UI Elements
  
  private let titleLabel = UILabel()
  
  // MARK: - Init
  
  override init(frame: CGRect) {
    super.init(frame: frame)
    
    setup()
    style()
    layout()
  }
  
  required init?(coder: NSCoder) {
    return nil
  }
  
  // MARK: - SSUL
  
  func setup() {
    addSubview(titleLabel)
  }
  
  func style() {
    Self.styleTitleLabel(titleLabel)
  }
  
  func layout() {
    titleLabel.translatesAutoresizingMaskIntoConstraints = false
    
    let titleLabelConstraints = [
      titleLabel.topAnchor.constraint(equalTo: topAnchor),
      titleLabel.leadingAnchor.constraint(equalTo: leadingAnchor),
      titleLabel.trailingAnchor.constraint(equalTo: trailingAnchor),
      titleLabel.bottomAnchor.constraint(equalTo: bottomAnchor)
    ]
    
    NSLayoutConstraint.activate(titleLabelConstraints)
  }
}

extension RecentsHeaderView {
  static func styleTitleLabel(_ label: UILabel) {
    label.adjustsFontForContentSizeCategory = true
    
    let font = UIFont.preferredFont(forTextStyle: .title2)
    
    guard let boldFontDescriptor = font.fontDescriptor.withSymbolicTraits(.traitBold)else {
      label.font = font
      return
    }
    
    label.font = UIFont(descriptor: boldFontDescriptor, size: font.fontDescriptor.pointSize)
  }
}
