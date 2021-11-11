//
//  Bundle+Extension.swift
//  MiniProject
//
//  Created by zehye on 2021/11/11.
//

import Foundation

extension Bundle {
    
    static func decodeJSONFromMainResources<D: Decodable>(filename: String) throws -> D  {
        guard let url = main.url(forResource: filename, withExtension: "json") else {
            throw NSError(domain: "", code: 0, userInfo: [NSLocalizedDescriptionKey: "File not found in main bundle"])
        }
        
        let data = try Data(contentsOf: url)
        let decoded = try JSONDecoder().decode(D.self, from: data)
        return decoded
    }
    
}
