//
//  Category.swift
//  SwiftHeroes
//
//  Created by Gaetano Matonti on 07/03/22.
//

struct Category: Identifiable {
  
  // MARK: - Stored Properties
  
  let id: Int
  let title: String
  let subtitle: String
  let services: [Service.ID]
  var isExpanded: Bool = false
      
  // MARK: - Functions
  
  mutating func setExpansion(_ isExpanded: Bool) {
    self.isExpanded = isExpanded
  }
}

extension Category: Hashable {
  func hash(into hasher: inout Hasher) {
    hasher.combine(id)
  }
}
