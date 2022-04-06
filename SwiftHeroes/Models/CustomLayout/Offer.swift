//
//  Offer.swift
//  SwiftHeroes
//
//  Created by Gaetano Matonti on 07/03/22.
//

struct Offer: Identifiable {
  let id: Int
  let title: String
}

extension Offer: Hashable {
  func hash(into hasher: inout Hasher) {
    hasher.combine(id)
  }
}
