//
//  ServiceGroupBackground.swift
//  SwiftHeroes
//
//  Created by Gaetano Matonti on 04/03/22.
//

import UIKit

final class ServiceGroupBackground: UICollectionReusableView {
  override init(frame: CGRect) {
    super.init(frame: frame)
    
    style()
  }
  
  required init?(coder: NSCoder) {
    return nil
  }
  
  func style() {
    backgroundColor = .secondarySystemGroupedBackground
    
    layer.cornerCurve = .continuous
    layer.cornerRadius = 12
    
    layer.shadowColor = UIColor.black.cgColor
    layer.shadowOffset = CGSize(width: 0, height: 6)
    layer.shadowOpacity = 0.08
    layer.shadowRadius = 20
  }
}
