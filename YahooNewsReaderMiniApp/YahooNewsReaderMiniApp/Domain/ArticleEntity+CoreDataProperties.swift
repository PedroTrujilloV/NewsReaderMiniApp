//
//  ArticleEntity+CoreDataProperties.swift
//  YahooNewsReaderMiniApp
//
//  Created by XcodeDevelopment on 4/21/24.
//
//

import Foundation
import CoreData


extension ArticleEntity {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<ArticleEntity> {
        return NSFetchRequest<ArticleEntity>(entityName: "ArticleEntity")
    }

    @NSManaged public var content: String?
    @NSManaged public var id: String
    @NSManaged public var type: String

}

extension ArticleEntity : Identifiable {

}
