//
//  ServiceItemCell.swift
//  SwiftHeroes
//
//  Created by Gaetano Matonti on 04/03/22.
//

import UIKit

final class ServiceItemCell: UICollectionViewCell {
  
  // MARK: - Constants
  
  private let assetSize = CGSize(width: 24, height: 24)
  
  // MARK: - Stored Properties
  
  var title: String? = nil {
    willSet {
      titleLabel.text = newValue
    }
  }
  
  var subtitle: String? = nil {
    willSet {
      subtitleLabel.text = newValue
    }
  }
  
  var symbolName: String? = nil {
    willSet {
      newValue.flatMap {
        iconImageView.image = UIImage(systemName: $0)?.withRenderingMode(.alwaysTemplate)
      }
    }
  }
  
  // MARK: - UI Elements
  
  private let iconImageView = UIImageView()
  
  private let titleLabel = UILabel()
  
  private let subtitleLabel = UILabel()
    
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
  
  private func setup() {
    addSubview(iconImageView)
    addSubview(titleLabel)
    addSubview(subtitleLabel)
  }
  
  private func style() {
    iconImageView.contentMode = .scaleAspectFit
    iconImageView.layer.cornerCurve = .continuous
    iconImageView.layer.cornerRadius = 4
    
    titleLabel.font = .preferredFont(forTextStyle: .subheadline)
    
    subtitleLabel.font = .preferredFont(forTextStyle: .subheadline)
    subtitleLabel.textColor = .secondaryLabel
    subtitleLabel.numberOfLines = .zero
  }
  
  private func layout() {
    iconImageView.translatesAutoresizingMaskIntoConstraints = false
    
    let iconImageViewConstraints = [
      iconImageView.topAnchor.constraint(equalTo: topAnchor),
      iconImageView.leadingAnchor.constraint(equalTo: leadingAnchor),
      iconImageView.widthAnchor.constraint(equalToConstant: assetSize.width),
      iconImageView.heightAnchor.constraint(equalToConstant: assetSize.height)
    ]
    
    NSLayoutConstraint.activate(iconImageViewConstraints)
    
    titleLabel.translatesAutoresizingMaskIntoConstraints = false
    
    let titleLabelConstraints = [
      titleLabel.topAnchor.constraint(equalTo: topAnchor),
      titleLabel.leadingAnchor.constraint(equalTo: iconImageView.trailingAnchor, constant: 16),
      titleLabel.trailingAnchor.constraint(equalTo: trailingAnchor)
    ]
    
    NSLayoutConstraint.activate(titleLabelConstraints)
    
    subtitleLabel.translatesAutoresizingMaskIntoConstraints = false
    
    let subtitleLabelConstraints = [
      subtitleLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 4),
      subtitleLabel.leadingAnchor.constraint(equalTo: titleLabel.leadingAnchor),
      subtitleLabel.trailingAnchor.constraint(equalTo: titleLabel.trailingAnchor),
      subtitleLabel.bottomAnchor.constraint(equalTo: bottomAnchor)
    ]
    
    NSLayoutConstraint.activate(subtitleLabelConstraints)
  }
}
