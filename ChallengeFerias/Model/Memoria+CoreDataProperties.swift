//
//  Memoria+CoreDataProperties.swift
//  ChallengeFerias
//
//  Created by Juliana Vigato Pavan on 01/08/19.
//  Copyright © 2019 Juliana Vigato Pavan. All rights reserved.
//
//

import Foundation
import CoreData


extension Memoria {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Memoria> {
        return NSFetchRequest<Memoria>(entityName: "Memoria")
    }

    @NSManaged public var atitude: String?
    @NSManaged public var pensamentos: String?
    @NSManaged public var resultado: String?
    @NSManaged public var situacao: String?
    @NSManaged public var titulo: String?
    @NSManaged public var data: NSDate?
    @NSManaged public var tem: NSOrderedSet?

}

// MARK: Generated accessors for tem
extension Memoria {

    @objc(insertObject:inTemAtIndex:)
    @NSManaged public func insertIntoTem(_ value: Sentimento, at idx: Int)

    @objc(removeObjectFromTemAtIndex:)
    @NSManaged public func removeFromTem(at idx: Int)

    @objc(insertTem:atIndexes:)
    @NSManaged public func insertIntoTem(_ values: [Sentimento], at indexes: NSIndexSet)

    @objc(removeTemAtIndexes:)
    @NSManaged public func removeFromTem(at indexes: NSIndexSet)

    @objc(replaceObjectInTemAtIndex:withObject:)
    @NSManaged public func replaceTem(at idx: Int, with value: Sentimento)

    @objc(replaceTemAtIndexes:withTem:)
    @NSManaged public func replaceTem(at indexes: NSIndexSet, with values: [Sentimento])

    @objc(addTemObject:)
    @NSManaged public func addToTem(_ value: Sentimento)

    @objc(removeTemObject:)
    @NSManaged public func removeFromTem(_ value: Sentimento)

    @objc(addTem:)
    @NSManaged public func addToTem(_ values: NSOrderedSet)

    @objc(removeTem:)
    @NSManaged public func removeFromTem(_ values: NSOrderedSet)

}
