// UserEntity.swift
import Foundation
import CoreData

@objc(UserEntity)
public class UserEntity: NSManagedObject {
    @NSManaged public var _id: String?
    @NSManaged public var UserName: String?
    @NSManaged public var email: String?
    @NSManaged public var numeroTel: String?
}
