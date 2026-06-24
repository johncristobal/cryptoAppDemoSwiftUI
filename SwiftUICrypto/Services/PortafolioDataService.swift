//
//  PortafolioDataService.swift
//  SwiftUICrypto
//
//  Created by JOHN CRIS on 24/06/26.
//

import Foundation
import CoreData
import Combine

class PortafolioDataService {
    
    let container: NSPersistentContainer
    let containerName = "PortafolioContainer"
    let entityName = "PortafolioEntity"
    
    @Published var portafolio: [PortafolioEntity] = []

    init() {
        container = NSPersistentContainer(name: containerName)
        container.loadPersistentStores { (description, error) in
            if let error = error {
                fatalError("Error loading Core Data: \(error.localizedDescription)")
            }
        }
        
        getPortafolio()
    }

    // MARK: - PUBLIC
    func updatePortafolio(coin: CoinModel, amount: Double) {
        if let entity = portafolio.first(where: { $0.coinID == coin.id }) {
            if amount > 0 {
                update(entity: entity, amount: amount)
            } else {
                remove(entity: entity)
            }
        } else {
            add(coin: coin, amount: amount)
        }
    }
    
    // MARK: - PRIVATE
    private func getPortafolio() {
        let request = NSFetchRequest<PortafolioEntity>(entityName: entityName)
        do {
            portafolio = try container.viewContext.fetch(request)
        } catch let error {
            fatalError("Error request Core Data: \(error.localizedDescription)")
        }
    }
    
    private func add(coin: CoinModel, amount: Double) {
        let entity = PortafolioEntity(context: container.viewContext)
        entity.coinID = coin.id
        entity.amout = amount
        
        applyChanges()
    }
    
    private func update(entity: PortafolioEntity, amount: Double) {
        entity.amout = amount
        applyChanges()
    }
    
    private func remove(entity: PortafolioEntity) {
        container.viewContext.delete(entity)
        applyChanges()
    }
    
    private func save() {
        do {
            try container.viewContext.save()
        } catch {
            fatalError("Error saving Core Data: \(error.localizedDescription)")
        }
    }
    
    private func applyChanges() {
        save()
        getPortafolio()
    }
}
