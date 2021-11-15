//
//  ModelExpert.swift
//  MiniProject
//
//  Created by zehye on 2021/11/10.
//

import UIKit
import SwiftyJSON

struct Expert {
    let age: Int?
    var expertType: String = ""
    var expertTypeName: String = ""
    var career: String = ""
    var ability: String = ""
    var authState: String = ""
    var memberType: String = ""
    var name: String = ""
    var profilePath: String = ""
    var uid: String = ""
    
    init(_ json: [String:JSON]?) {
        let json = json ?? [:]
        self.age = json["age"]?.int
        self.expertType = json["expertType"]?.string ?? ""
        self.expertTypeName = json["expertTypeName"]?.string ?? ""
        self.career = json["career"]?.string ?? ""
        self.ability = json["ability"]?.string ?? ""
        self.authState = json["authState"]?.string ?? ""
        self.memberType = json["memberType"]?.string ?? ""
        self.name = json["name"]?.string ?? ""
        self.profilePath = json["profilePath"]?.string ?? ""
        self.uid = json["uid"]?.string ?? ""
    }
    
    init(_ json: JSON?) {
        self.init(json?.dictionaryValue)
    }
    
    static func list(_ json: [JSON]?) -> [Expert] {
        guard let json = json else { return [Expert]() }
        return json.map({ (element) -> Expert in
            return Expert(element)
        })
    }
}
