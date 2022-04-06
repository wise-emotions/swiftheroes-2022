//
//  Service.swift
//  SwiftHeroes
//
//  Created by Gaetano Matonti on 07/03/22.
//

struct Service: Identifiable {
  
  // MARK: - Stored Properties
  
  let id: Int
  let title: String
  let subtitle: String
  let symbolName: String
}

extension Service: Hashable {
  func hash(into hasher: inout Hasher) {
    hasher.combine(id)
  }
}
