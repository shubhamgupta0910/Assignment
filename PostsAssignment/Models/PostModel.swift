//
//  PostModel.swift
//  PostsAssignment
//
//  Created by Shubham Gupta on 04/09/24.
//

import Foundation
import RealmSwift

class PostModel: Object, Codable {
    @objc dynamic var userId: Int = 0
    @objc dynamic var id: Int = 0
    @objc dynamic var title: String = ""
    @objc dynamic var body: String = ""
    @objc dynamic var favourite: Bool = false
    
    override static func primaryKey() -> String? {
        return "id"
    }
    
    // Implement this to map between JSON keys and your properties
    private enum CodingKeys: String, CodingKey {
        case userId, id, title, body
    }
    
}
