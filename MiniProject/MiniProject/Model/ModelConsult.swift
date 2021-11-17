//
//  ModelConsult.swift
//  MiniProject
//
//  Created by zehye on 2021/11/10.
//

import UIKit
import SwiftyJSON

struct Consult {
    let cid: String?
    let seq: String?
    let title: String?
    let uid: String?
    let readCnt: Int?
    let content: String?
    var regDate: Date?
    var profileImg: UIImage? = nil
    var name: String?
    var expertTypeName: String?
    var companyName: String?
    
    init(_ json: [String:JSON]?) {
        let json = json ?? [:]
        self.cid = json["cid"]?.string ?? ""
        self.seq = json["seq"]?.string ?? ""
        self.title = json["title"]?.string ?? ""
        self.uid = json["uid"]?.string ?? ""
        self.readCnt = json["readCnt"]?.int ?? 0
        self.content = json["lastAnswer"]?["content"].string ?? ""
        if let url = URL(string: json["lastAnswer"]?["profileImg"].stringValue ?? ""),
           let image = try? Data(contentsOf: url) {
            self.profileImg = UIImage(data: image)
        }
        self.name = json["lastAnswer"]?["name"].string ?? ""
        self.expertTypeName = json["lastAnswer"]?["expertTypeName"].string ?? ""
        self.companyName = json["lastAnswer"]?["companyName"].string ?? ""
        self.regDate = Date(timeIntervalSince1970: (json["regDate"]!.doubleValue/1000))
    }
    
    init(_ json: JSON?) {
        self.init(json?.dictionaryValue)
    }
    
    static func list(_ json: [JSON]?) -> [Consult] {
        guard let json = json else { return [Consult]() }
        return json.map({ (element) -> Consult in
            return Consult(element)
        })
    }
}

extension Consult: Hashable {
    func hash(into hasher: inout Hasher) {
        hasher.combine(seq)
    }
}
