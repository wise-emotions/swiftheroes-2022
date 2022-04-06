//
// Apple Music
//

import UIKit

final class AlbumCell: UICollectionViewCell {
  
  // MARK: - Stored Properties
  
  var title: String? {
    willSet {
      titleLabel.text = newValue
    }
  }
  
  var subtitle: String? {
    willSet {
      subtitleLabel.text = newValue
    }
  }
  
  var image: UIImage? {
    willSet {
      imageView.image = newValue
    }
  }
  
  // MARK: - UI Elements
  
  private let imageView = UIImageView()
  
  private let titleLabel = UILabel()
  
  private let subtitleLabel = UILabel()
  
  // MARK: - Init
  
  override init(frame: CGRect) {
    super.init(frame: .zero)
    
    setup()
    style()
    layout()
  }
  
  required init?(coder: NSCoder) {
    return nil
  }
  
  // MARK: - SSUL
  
  func setup() {
    contentView.addSubview(imageView)
    contentView.addSubview(titleLabel)
    contentView.addSubview(subtitleLabel)
  }
  
  func style() {
    titleLabel.font = .preferredFont(forTextStyle: .subheadline)
    titleLabel.adjustsFontForContentSizeCategory = true
    
    subtitleLabel.font = .preferredFont(forTextStyle: .subheadline)
    subtitleLabel.textColor = .secondaryLabel
    subtitleLabel.adjustsFontForContentSizeCategory = true
    
    imageView.backgroundColor = .systemFill
    imageView.contentMode = .scaleAspectFit
    imageView.clipsToBounds = true
    imageView.layer.cornerCurve = .continuous
    imageView.layer.cornerRadius = 4
    imageView.layer.borderColor = UIColor.separator.cgColor
    imageView.layer.borderWidth = 0.5
  }
  
  func layout() {
    imageView.translatesAutoresizingMaskIntoConstraints = false
    
    let imageConstraints = [
      imageView.topAnchor.constraint(equalTo: contentView.topAnchor),
      imageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
      imageView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
      imageView.heightAnchor.constraint(equalTo: imageView.widthAnchor)
    ]
    
    titleLabel.translatesAutoresizingMaskIntoConstraints = false
    
    let titleLabelContraints = [
      titleLabel.topAnchor.constraint(equalTo: imageView.bottomAnchor, constant: 6),
      titleLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
      titleLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor)
    ]
    
    subtitleLabel.translatesAutoresizingMaskIntoConstraints = false
    
    let subtitleLabelContraints = [
      subtitleLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 2),
      subtitleLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
      subtitleLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
      subtitleLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor)
    ]
    
    NSLayoutConstraint.activate(imageConstraints)
    NSLayoutConstraint.activate(titleLabelContraints)
    NSLayoutConstraint.activate(subtitleLabelContraints)
  }
}
