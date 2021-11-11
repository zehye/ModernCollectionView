//
//  ModelCell.swift
//  MiniProject
//
//  Created by zehye on 2021/11/10.
//

import UIKit

enum Home: String {
    case company
}

extension Home {
    static var jsonwithModel: [(home: Home, company: [Company])] {
        [
            (.company, .companyJson)
        ]
    }
}

/*
 class ModelHome: Codable {
     var companyInfoList = [ModelCompany]()
     var companyPosition: Int?
     var consultList = [ModelConsult]()
     var expertList = [ModelExpert]()
     var expertPosition: Int?
 //    var pageMap = DoctalkPageMapV1DTO()
 }
 */
