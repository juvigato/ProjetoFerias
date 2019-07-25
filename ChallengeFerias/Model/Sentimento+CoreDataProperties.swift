//
//  Sentimento+CoreDataProperties.swift
//  ChallengeFerias
//
//  Created by Juliana Vigato Pavan on 25/07/19.
//  Copyright © 2019 Juliana Vigato Pavan. All rights reserved.
//
//

import Foundation
import CoreData


extension Sentimento {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Sentimento> {
        return NSFetchRequest<Sentimento>(entityName: "Sentimento")
    }

    @NSManaged public var nome: String?

}
