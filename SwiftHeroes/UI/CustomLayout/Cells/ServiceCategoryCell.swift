//
//  ServiceCategoryCell.swift
//  SwiftHeroes
//
//  Created by Gaetano Matonti on 04/03/22.
//

import UIKit

final class ServiceCategoryCell: UICollectionViewCell {
  
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
  
  var isExpanded: Bool = false {
    didSet {
      style()
    }
  }
  
  // MARK: - UI Elements
  
  private let titleLabel = UILabel()
  
  private let subtitleLabel = UILabel()
  
  private let accessory = UIImageView()
  
  // MARK: - Computed Properties
  
  private var accessoryImage: UIImage? {
    UIImage(systemName: isExpanded ? "chevron.up" : "chevron.down")
  }
  
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
    addSubview(titleLabel)
    addSubview(subtitleLabel)
    addSubview(accessory)
  }
  
  private func style() {
    titleLabel.font = .preferredFont(forTextStyle: .headline)
    subtitleLabel.textColor = .secondaryLabel
    subtitleLabel.font = .preferredFont(forTextStyle: .subheadline)
    subtitleLabel.numberOfLines = .zero
    
    accessory.image = accessoryImage?.withRenderingMode(.alwaysTemplate)
    accessory.contentMode = .scaleAspectFit
    accessory.tintColor = tintColor
  }
  
  private func layout() {
    accessory.translatesAutoresizingMaskIntoConstraints = false
    
    let accessoryConstraints = [
      accessory.trailingAnchor.constraint(equalTo: trailingAnchor),
      accessory.centerYAnchor.constraint(equalTo: centerYAnchor),
      accessory.widthAnchor.constraint(equalToConstant: assetSize.width),
      accessory.heightAnchor.constraint(equalToConstant: assetSize.height)
    ]
    
    NSLayoutConstraint.activate(accessoryConstraints)
    
    titleLabel.translatesAutoresizingMaskIntoConstraints = false
    
    let titleLabelConstraints = [
      titleLabel.topAnchor.constraint(equalTo: topAnchor),
      titleLabel.leadingAnchor.constraint(equalTo: leadingAnchor),
      titleLabel.trailingAnchor.constraint(equalTo: accessory.leadingAnchor, constant: -16)
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
