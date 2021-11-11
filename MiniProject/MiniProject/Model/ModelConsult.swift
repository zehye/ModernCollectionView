//
//  ModelConsult.swift
//  MiniProject
//
//  Created by zehye on 2021/11/10.
//

import UIKit

/*
 {
   "tagList" : [
     {
       "tagName" : "감기",
       "tagKey" : 188
     }
   ],
   "regDate" : 1635472394000,
   "readCnt" : 22,
   "tagNameList" : "감기",
   "lastAnswerHospital" : {
     "addrJibun" : "서울특별시 강남구 역삼동 832-3 강남역 쉐르빌",
     "lon" : 127.03092100000001,
     "addrRoad" : "서울특별시 강남구 강남대로 328(역삼동)",
     "hospitalName" : "닥톡 병원112",
     "addrDong" : null,
     "distance" : 1.3558975717315671,
     "lat" : 37.492426999999999
   },

   "uid" : "uid_9d3566b61ea08c3b53a67442beb47e261bcadcd460caa0eee7ae01581964",
   "title" : "ㅋㅋㅋ55",
   "status" : "Y",
   "type" : "Q",
   "displayRegDate" : "2021.10.29",
   "answerCnt" : 1,
   "lastAnswer" : {
     "seq" : 529603,
     "displayRegDate" : "2021.11.02",
     "companyName" : "닥톡 병원112",
     "video" : {
       "width" : null,
       "youtubeId" : null,
       "thumbnail" : "",
       "filePath" : "https:\/\/docfriends.s3.ap-northeast-2.amazonaws.com\/dev\/health_consult\/video\/20211105\/2ujPfQd6-7nJW-51Pf-anNf-1cSE1YkjUcqM.mp4?X-Amz-Algorithm=AWS4-HMAC-SHA256&X-Amz-Date=20211110T052356Z&X-Amz-SignedHeaders=host&X-Amz-Expires=599&X-Amz-Credential=AKIAJHIAZX4VSANQUSUA%2F20211110%2Fap-northeast-2%2Fs3%2Faws4_request&X-Amz-Signature=40055aa044b2f055d1136dac0c6d911e9354218be968ad77c1401d162d269651",
       "youtubeState" : "invalid",
       "height" : null,
       "fileName" : "KakaoTalk_20210319_142641602.mp4"
     },
     "mediaType" : "AUDIO",
     "userName" : "의사2",
     "regDate" : 1635853988000,
     "expertType" : "ORIENTAL",
     "content" : "안녕하세요, 닥톡-네이버 지식iN 상담한의사 의사2입니다.\n 박통 네이버 지식인 상담 안의사 김병주입니다.\n 혈압이 불안정하면서\n 비속대는 부통 어지럼증에 대해서 문의를 드셨네요.\n 일상생활에서는 정상인데 병원에서만 혈압이 올라가는 경우는\n \n\n",
     "profileImg" : "https:\/\/img.doctalk.co.kr\/dev\/user\/image\/20211105\/4eWvJG3Z-4ll1-4RIj-9GpD-1eASTK9x6qLP.jpg.png",
     "image" : null,
     "expertTypeName" : "한의사",
     "likeCnt" : 37
   },
   "lon" : 127.0421424,
   "notReadAnswerCnt" : 0,
   "seq" : 529588,
   "cid" : "cid_22c002e1c2a17d6a8a47cc219d99213a7f0a50adf8449a47ba6c27026783"
 }
*/

struct Consult: Decodable {
    let cid: String
    let compantName: String
    let regDate: Date
    let seq: String
    let status: String
    let title: String
    let type: String
    let uid: String
    let readCnt: String
}

extension Consult: Hashable {
    func hash(into hasher: inout Hasher) {
        hasher.combine(cid)
        hasher.combine(compantName)
        hasher.combine(regDate)
        hasher.combine(seq)
        hasher.combine(status)
        hasher.combine(title)
        hasher.combine(type)
        hasher.combine(uid)
        hasher.combine(readCnt)
    }
}

extension Array where Element == Consult {
    static var consultJson: Self {
        try! Bundle.decodeJSONFromMainResources(filename: "consult")
    }
}
/*
 class ModelConsult: Codable {
     var answerCnt: Int = 0
     var cid: String = ""
     var companyCode: String = ""
     var companyName: String = ""
     var editorType: String = ""
 //    var lastAnswer: ConsultAnswerInfoDTO?
     var lat: Double?
     var lon: Double?
     var medicalDep: String = ""
     var medicalDepName: String = ""
     var myAnswerCnt: Int = 0
     var notReadAnswerCnt: Int = 0
     var readCnt: Int = 0
     var regDate: Double?
     var seq: Int = 0
     var status: String = ""
 //    var tagList = [TagResponseDTO]()
     var textContent: String = ""
     var title: String = ""
     var type: String = ""
     var uid: String = ""
 //    var lastAnswerHospital: ConsultAnswerHospitalDTO?
 }
*/

