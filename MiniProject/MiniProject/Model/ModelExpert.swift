//
//  ModelExpert.swift
//  MiniProject
//
//  Created by zehye on 2021/11/10.
//

import UIKit
import SwiftyJSON

struct Expert {
    var expertTypeName: String?
    var authState: String?
    var name: String?
    var profilePath: UIImage? = nil
    var uid: String?
    var tagList = [String]()
    
    init(_ json: [String:JSON]?) {
        let json = json ?? [:]
        self.expertTypeName = json["expertInfo"]?["expertTypeName"].string ?? ""
        self.authState = json["expertInfo"]?["authState"].string ?? ""
        self.name = json["expertInfo"]?["name"].string ?? ""
        if let url = URL(string: json["expertInfo"]?["profilePath"].stringValue ?? ""),
           let image = try? Data(contentsOf: url) {
            self.profilePath = UIImage(data: image)
        }
        self.uid = json["expertInfo"]?["uid"].string ?? ""
        self.tagList = json["expertInfo"]?["tagList"].arrayValue.map({$0["name"].stringValue}) ?? []
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

extension Expert: Hashable {
    func hash(into hasher: inout Hasher) {
        hasher.combine(uid)
    }
}
