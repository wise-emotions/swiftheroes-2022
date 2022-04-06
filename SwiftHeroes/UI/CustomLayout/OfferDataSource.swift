//
//  OfferDataSource.swift
//  SwiftHeroes
//
//  Created by Gaetano Matonti on 04/03/22.
//

import UIKit

enum OfferSection: Hashable {
  case offers
  case services(_ identifier: Category.ID)
}

enum OfferItem: Hashable {
  case offer(_ identifier: Offer.ID)
  case category(_ identifier: Category.ID)
  case service(_ identifier: Service.ID)
}

fileprivate var storage = OfferDataSource.Storage()

final class OfferDataSource: UICollectionViewDiffableDataSource<OfferSection, OfferItem> {
  
  // MARK: - Init
  
  convenience init(collectionView: UICollectionView) {
    let offerRegistration = UICollectionView.CellRegistration<OfferCell, Offer> { cell, _, item in }
    
    let categoryRegistration = UICollectionView.CellRegistration<ServiceCategoryCell, Category> { cell, indexPath, category in
      cell.title = category.title
      cell.subtitle = category.subtitle
      cell.isExpanded = category.isExpanded
    }
    
    let serviceItemRegistration = UICollectionView.CellRegistration<ServiceItemCell, Service> { cell, _, service in
      cell.title = service.title
      cell.subtitle = service.subtitle
      cell.symbolName = service.symbolName
    }
    
    self.init(collectionView: collectionView) { collectionView, indexPath, item in
      switch item {
      case let .offer(identifier):
        return collectionView.dequeueConfiguredReusableCell(
          using: offerRegistration,
          for: indexPath,
          item: storage.offer(for: identifier)
        )
        
      case let .category(identifier):
        return collectionView.dequeueConfiguredReusableCell(
          using: categoryRegistration,
          for: indexPath,
          item: storage.category(for: identifier)
        )
        
      case let .service(identifier):
        return collectionView.dequeueConfiguredReusableCell(
          using: serviceItemRegistration,
          for: indexPath,
          item: storage.service(for: identifier)
        )
      }
    }
  }
  
  func applyInitialSnapshot() {
    appendOffers()
    appendCategories()
  }
  
  func toggleCategoryExpansion(for identifier: Category.ID) {
    let sectionIdentifier: OfferSection = .services(identifier)
    let parentItemIdentifier: OfferItem = .category(identifier)

    var sectionSnapshot = snapshot(for: sectionIdentifier)
    
    if sectionSnapshot.isExpanded(parentItemIdentifier) {
      sectionSnapshot.collapse([parentItemIdentifier])
    } else {
      sectionSnapshot.expand([parentItemIdentifier])
    }
    
    apply(sectionSnapshot, to: sectionIdentifier)

    var snapshot = snapshot()
    storage.setExpansion(for: identifier, isExpanded: sectionSnapshot.isExpanded(parentItemIdentifier))
    snapshot.reconfigureItems([parentItemIdentifier])
    
    apply(snapshot, animatingDifferences: false)
  }

  private func appendOffers() {
    var sectionSnapshot = snapshot(for: .offers)
    
    let offerItems: [OfferItem] = storage.offers.map { .offer($0.id) }
    sectionSnapshot.append(offerItems)
    
    apply(sectionSnapshot, to: .offers)
  }
  
  private func appendCategories() {
    storage.categories.forEach { category in
      applyCategorySnapshot(for: category)
    }
  }
  
  private func applyCategorySnapshot(for category: Category) {
    let sectionIdentifier: OfferSection = .services(category.id)
    let parentItemIdentifier: OfferItem = .category(category.id)
    
    var sectionSnapshot = snapshot(for: sectionIdentifier)
    sectionSnapshot.append([parentItemIdentifier])
    
    let childrenItemIdentifiers: [OfferItem] = category.services.map { .service($0) }
    sectionSnapshot.append(childrenItemIdentifiers, to: parentItemIdentifier)
    
    apply(sectionSnapshot, to: sectionIdentifier)
  }
}

extension OfferDataSource {
  struct Storage {
    let offers = [
      Offer(id: 0, title: "Offer 1"),
      Offer(id: 1, title: "Offer 2")
    ]

    var categories = [
      Category(
        id: 0,
        title: "Pedaggio e soste",
        subtitle: "Viaggi e parcheggi senza pensieri",
        services: [0, 1]
      ),
      Category(
        id: 1,
        title: "Il tuo veicolo",
        subtitle: "Prenditene cura e gestisci le scadenze",
        services: [3, 4]
      ),
      Category(
        id: 2,
        title: "La tua mobilità",
        subtitle: "Spostati in modo sostenibile e conveniente",
        services: [5, 6, 7]
      )
    ]
    
    let services = [
      Service(
        id: 0,
        title: "Autostrada",
        subtitle: "Viaggi con il dispositivo Telepass senza fermarti al casello.",
        symbolName: "car.2"
      ),
      Service(
        id: 1,
        title: "Parcheggi Convenzionati",
        subtitle: "Accedi ai parcheggi pagando con il tuo dispositivo Telepass.",
        symbolName: "parkingsign.circle"
      ),
      Service(
        id: 3,
        title: "Carburante",
        subtitle: "Fai rifornimento con l’App nei distributori convenzionati.",
        symbolName: "fuelpump"
      ),
      Service(
        id: 4,
        title: "Ricarica Elettrica",
        subtitle: "Ricarichi il tuo veicolo elettrico nella stazione più vicina a te.",
        symbolName: "bolt.car"
      ),
      Service(
        id: 5,
        title: "Taxi",
        subtitle: "Chiami il taxi più vicino a te e paghi la corsa in un tap.",
        symbolName: "figure.wave"
      ),
      Service(
        id: 6,
        title: "Mobilità Condivisa",
        subtitle: "Noleggi e ti sposti con monopattino, bicicletta e scooter.",
        symbolName: "scooter"
      ),
      Service(
        id: 7,
        title: "Treni",
        subtitle: "Acquisti i biglietti Trenitalia senza usare carte o contanti.",
        symbolName: "tram"
      )
    ]
  }
}

extension OfferDataSource.Storage {
  func offer(for identifier: Offer.ID) -> Offer? {
    offers.first { $0.id == identifier }
  }
  
  func category(for identifier: Category.ID) -> Category? {
    categories.first { $0.id == identifier }
  }
  
  func service(for identifier: Service.ID) -> Service? {
    services.first { $0.id == identifier }
  }
  
  mutating func setExpansion(for identifier: Category.ID, isExpanded: Bool) {
    guard
      let category = category(for: identifier),
      let categoryIndex = categories.firstIndex(of: category)
    else {
      return
    }
    
    categories[categoryIndex].setExpansion(isExpanded)
  }
}
