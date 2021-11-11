//
//  ModelCompany.swift
//  MiniProject
//
//  Created by zehye on 2021/11/10.
//

import UIKit

/*
 {
   "companyName" : "Almighty_도곡양재차엔박",
   "addrJibun" : "서울특별시 강남구 도곡동 514-2 유니북스빌딩",
   "introPath" : "https:\/\/img.doctalk.co.kr\/dev\/company\/image\/20210803\/4DryAmQe-cNfs-4jxp-9abO-73c6gcqyJcY8.jpeg.png",
   "addrRoad" : "서울특별시 강남구 논현로 164(도곡동)",
   "hid" : "hid-1nZaV9Bz-eoVu-59cx-bxfb-2dqGRaYx7Jj2",
   "addrEtc" : "10층",
   "authedYn" : "Y"
 }
*/

struct Company: Decodable {
    let addrEtc: String
    let addrJibun: String
    let addrRoad: String
    let companyName: String
    let authedYn: String
    let introPath: String
    
    let hid = UUID()
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

extension Array where Element == Company {
    static var companyJson: Self {
        try! Bundle.decodeJSONFromMainResources(filename: "short")
    }
}

