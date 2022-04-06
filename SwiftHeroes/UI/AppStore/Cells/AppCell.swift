//
//  AppCell.swift
//  SwiftHeroes
//
//  Created by Gaetano Matonti on 09/03/22.
//

import UIKit

final class AppCell: UICollectionViewCell {
  
  // MARK: - Constants
  
  static private let iconSize = CGSize(width: 64, height: 64)
  
  // MARK: - Stored Properties
  
  var title: String? {
    willSet {
      titleLabel.text = newValue
    }
  }
  
  var caption: String? {
    willSet {
      captionLabel.text = newValue
    }
  }
  
  // MARK: - UI Elements
  
  private let iconImageView = UIImageView()
  
  private let titleLabel = UILabel()
  
  private let captionLabel = UILabel()
  
  private let textStackView = UIStackView()
  
  private let getButton = UIButton()
  
  private let contentStackView = UIStackView()
  
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
  
  // MARK: - SSL
  
  func setup() {
    contentView.addSubview(contentStackView)
    
    contentStackView.addArrangedSubview(iconImageView)
    contentStackView.addArrangedSubview(textStackView)
    contentStackView.addArrangedSubview(getButton)
    
    textStackView.addArrangedSubview(titleLabel)
    textStackView.addArrangedSubview(captionLabel)
  }
  
  func style() {
    Self.styleContentStackView(contentStackView, traitCollection: traitCollection)
    Self.styleTextStack(textStackView)
    Self.styleIconImageView(iconImageView)
    Self.styleTitleLabel(titleLabel)
    Self.styleCaptionLabel(captionLabel)
    Self.styleButton(getButton)
  }
  
  override func traitCollectionDidChange(_ previousTraitCollection: UITraitCollection?) {
    style()
  }

  override func layoutSubviews() {
    super.layoutSubviews()
    
    contentStackView.frame = bounds
    contentStackView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
  }
      
  private func layout() {
    iconImageView.translatesAutoresizingMaskIntoConstraints = false
    
    let iconImageViewConstraints = [
      iconImageView.widthAnchor.constraint(equalToConstant: Self.iconSize.width),
      iconImageView.heightAnchor.constraint(equalToConstant: Self.iconSize.height),
    ]
    
    NSLayoutConstraint.activate(iconImageViewConstraints)
  }
}

// MARK: - Styling Functions

extension AppCell {
  static func styleContentStackView(_ stackView: UIStackView, traitCollection: UITraitCollection) {
    stackView.axis = traitCollection.preferredContentSizeCategory.isAccessibilityCategory ? .vertical : .horizontal
    stackView.alignment = traitCollection.preferredContentSizeCategory.isAccessibilityCategory ? .leading : .center
    stackView.spacing = 12
  }
  
  static func styleIconImageView(_ imageView: UIImageView) {
    imageView.backgroundColor = .systemBlue
    imageView.layer.cornerCurve = .continuous
    imageView.layer.cornerRadius = 14
    imageView.layer.borderColor = UIColor.separator.cgColor
    imageView.layer.borderWidth = 1
  }
  
  static func styleTextStack(_ stackView: UIStackView) {
    stackView.axis = .vertical
    stackView.alignment = .fill
    stackView.distribution = .fill
    stackView.spacing = 4
  }
  
  static func styleTitleLabel(_ label: UILabel) {
    label.font = .preferredFont(forTextStyle: .body)
    label.adjustsFontForContentSizeCategory = true
    label.numberOfLines = 2
  }
  
  static func styleCaptionLabel(_ label: UILabel) {
    label.font = .preferredFont(forTextStyle: .caption1)
    label.textColor = .secondaryLabel
    label.adjustsFontForContentSizeCategory = true
  }
  
  static func styleButton(_ button: UIButton) {
    var buttonConfiguration = UIButton.Configuration.bordered()
    
    var attributes = AttributeContainer()
    attributes.font = UIFontMetrics(forTextStyle: .subheadline)
      .scaledFont(for: .systemFont(ofSize: 15, weight: .bold), maximumPointSize: 25)

    buttonConfiguration.attributedTitle = AttributedString("GET", attributes: attributes)
    buttonConfiguration.buttonSize = .small
    buttonConfiguration.cornerStyle = .capsule
    buttonConfiguration.contentInsets = NSDirectionalEdgeInsets(top: 4, leading: 16, bottom: 4, trailing: 16)
    
    button.configuration = buttonConfiguration
    button.maximumContentSizeCategory = .extraExtraExtraLarge
    button.setContentHuggingPriority(.required, for: .horizontal)
    button.setContentHuggingPriority(.required, for: .vertical)
  }
}
