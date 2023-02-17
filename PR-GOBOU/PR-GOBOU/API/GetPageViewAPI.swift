//
//  GetPageViewAPI.swift
//  PR-GOBOU
//
//  Created by 上別縄祐也 on 2023/02/16.
//

import Foundation

class GetPageViewAPI: ObservableObject{
    
    let host = "https://hackathon.stg-prtimes.net/api/"
    let token = "b655dffbe1b2c82ca882874670cb110995c6604151e1b781cf5c362563eb4e12"
    
   
    func getPageView(companyId: String, releaseId: String) async throws -> Reputation {
        var components: URLComponents = URLComponents(string: host + "companies/" + companyId + "/releases/" + releaseId + "/statistics" )!
        components.queryItems = []
        
        let url = components.url!
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        request.setValue("Accept", forHTTPHeaderField: "application/json")
        request.setValue("Bearer \(token)", forHTTPHeaderField: "Authorization")
        

        var reputation: Reputation?
        let decoder = JSONDecoder()
        let (data, urlResponse) = try await URLSession.shared.data(from: url, delegate: nil)
        
        guard let httpStatus = urlResponse as? HTTPURLResponse else {
            throw NSError()
        }
        
        switch httpStatus.statusCode {
            case 200 ..< 400:
                guard let response = String(data: data, encoding: .utf8) else {
                    throw NSError()
                }
                reputation = try decoder.decode(Reputation.self, from: data)
                print("success")
        
                return reputation!
            case 400... :
                throw NSError()
            default:
                fatalError()
                break
        }
        
    }
    
}

