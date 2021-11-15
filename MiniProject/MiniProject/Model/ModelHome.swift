//
//  ModelCell.swift
//  MiniProject
//
//  Created by zehye on 2021/11/10.
//

import UIKit
import SwiftyJSON

struct Home {
    
    var companyList: [Company]
    var consultList: [Consult]
    var companyPosition: Int?
    var expertPosition: Int?
    var expertList: [Expert]

    init(_ json: JSON) {
        self.init(json.dictionaryValue)
    }

    init(_ json: [String:JSON]) {
        self.companyList = Company.list(json["companyInfoList"]?.array)
        self.companyPosition = json["companyPosition"]?.int
        self.consultList = Consult.list(json["consultInfoList"]?.array)
        self.expertList = Expert.list(json["expertInfoList"]?.array)
        self.expertPosition = json["expertPosition"]?.int
    }
}
