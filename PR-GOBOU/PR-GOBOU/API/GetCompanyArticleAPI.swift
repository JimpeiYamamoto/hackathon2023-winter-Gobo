//
//  GetCompantArticleAPI.swift
//  PR-GOBOU
//
//  Created by 上別縄祐也 on 2023/02/16.
//

import Foundation

class GetCompanyArticleAPI: ObservableObject{
    @Published var companyArticleList = [ArticleJson]()
    
    let host = "https://hackathon.stg-prtimes.net/api/"
    let token = "b655dffbe1b2c82ca882874670cb110995c6604151e1b781cf5c362563eb4e12"
   
    func getCompanyArticleApi(ids: [Int]){
        for id in ids {
            var components: URLComponents = URLComponents(string: host + "companies/" + String(id) + "/releases")!
            components.queryItems = [
                URLQueryItem(name: "per_page", value: "4"),
                URLQueryItem(name: "page", value: "1")
            ]
            
            guard let url = components.url else { return }
            var request = URLRequest(url: url)
            request.httpMethod = "GET"
            request.setValue("Accept", forHTTPHeaderField: "application/json")
            request.setValue("Bearer \(token)", forHTTPHeaderField: "Authorization")
            
            sessionTask(request: request)
        }
    }
    
    
    
    private func sessionTask(request: URLRequest ) {
        let decoder = JSONDecoder()
        let session = URLSession(configuration: .default, delegate: nil, delegateQueue: OperationQueue.main)
        let task = session.dataTask(with: request, completionHandler: { [weak self] (data, response, error) in
            session.finishTasksAndInvalidate()
            
            guard let httpStatus = response as? HTTPURLResponse else {
                fatalError()
            }
            guard httpStatus.statusCode == 200 else {
                fatalError()
            }
            
            guard let data = data else {
                print("data is null")
                return
            }
                do {
                    guard let me = self else { return }
                    me.companyArticleList.append(contentsOf: try decoder.decode([ArticleJson].self, from: data)) 
                    print("success")
                } catch (let error) {
                    print("fail to decode")
                    print(error)
                }
        })
        task.resume()
    }
    
}
