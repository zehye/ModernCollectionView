//
//  ModelCompany.swift
//  MiniProject
//
//  Created by zehye on 2021/11/10.
//

import UIKit
import SwiftyJSON

struct Company {
    var addrEtc: String?
    var addrJibun: String?
    var addrRoad: String?
    var companyName: String?
    var authedYn: String?
    var introPath: UIImage? = nil
    let hid: String?
    
    init(_ json: [String: JSON]?) {
        let json = json ?? [:]
//        print(json)
        self.addrEtc = json["addrEtc"]?.string ?? ""
        self.addrJibun = json["addrJibun"]?.string ?? ""
        self.addrRoad = json["addrRoad"]?.string ?? ""
        self.companyName = json["companyName"]?.string ?? ""
        self.authedYn = json["authedYn"]?.string ?? ""
        if let url = URL(string: json["introPath"]?.stringValue ?? ""),
           let image = try? Data(contentsOf: url) {
            self.introPath = UIImage(data: image)
        }
        self.hid = json["hid"]?.string ?? ""
    }
    
    init(_ json: JSON?) {
        self.init(json?.dictionaryValue)
    }
    
    static func list(_ json: [JSON]?) -> [Company] {
        guard let json = json else { return [Company]() }
        return json.map({ (element) -> Company in
            return Company(element)
        })
    }
}

extension Company: Hashable {
    func hash(into hasher: inout Hasher) {
        hasher.combine(addrEtc)
        hasher.combine(addrJibun)
        hasher.combine(addrRoad)
        hasher.combine(companyName)
        hasher.combine(hid)
        hasher.combine(authedYn)
        hasher.combine(introPath)
    }
}
