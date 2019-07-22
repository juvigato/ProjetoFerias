//
//  Memoria+CoreDataProperties.swift
//  ChallengeFerias
//
//  Created by Juliana Vigato Pavan on 19/07/19.
//  Copyright © 2019 Juliana Vigato Pavan. All rights reserved.
//

import Foundation
import CoreData

extension Memoria{
    
    @nonobjc public class func fetchRequest() -> NSFetchRequest<Memoria> {
        return NSFetchRequest<Memoria>(entityName: "Memoria")
    }
    
    @NSManaged public var situacao: String
}
