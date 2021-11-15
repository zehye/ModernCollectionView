//
//  ModelConsult.swift
//  MiniProject
//
//  Created by zehye on 2021/11/10.
//

import UIKit
import SwiftyJSON

struct Consult {
    let cid: String
    let compantName: String
    let seq: String
    let status: String
    let title: String
    let type: String
    let uid: String
    let readCnt: String
    
    init(_ json: [String:JSON]?) {
        let json = json ?? [:]
        self.cid = json["cid"]?.string ?? ""
        self.compantName = json["companyName"]?.string ?? ""
        self.seq = json["seq"]?.string ?? ""
        self.status = json["status"]?.string ?? ""
        self.title = json["title"]?.string ?? ""
        self.type = json["type"]?.string ?? ""
        self.uid = json["uid"]?.string ?? ""
        self.readCnt = json["readCnt"]?.string ?? ""
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
        hasher.combine(cid)
        hasher.combine(compantName)
        hasher.combine(seq)
        hasher.combine(status)
        hasher.combine(title)
        hasher.combine(type)
        hasher.combine(uid)
        hasher.combine(readCnt)
    }
}
