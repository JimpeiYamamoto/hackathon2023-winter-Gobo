//
//  GetArticleAPI.swift
//  PR-GOBOU
//
//  Created by 上別縄祐也 on 2023/02/16.
//

import Foundation

class GetArticleAPI: ObservableObject{
    @Published var latestArticleList = [ArticleJson]()
    
    let host = "https://hackathon.stg-prtimes.net/api/"
    let token = "b655dffbe1b2c82ca882874670cb110995c6604151e1b781cf5c362563eb4e12"
    
    func getLatestArticleApi(){
        var components: URLComponents = URLComponents(string: host + "releases")!
        components.queryItems = [
            URLQueryItem(name: "per_page", value: "100"),
            URLQueryItem(name: "page", value: "1")
        ]
        
        guard let url = components.url else { return }
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        request.setValue("Accept", forHTTPHeaderField: "application/json")
        request.setValue("Bearer \(token)", forHTTPHeaderField: "Authorization")
        
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
                me.latestArticleList = try decoder.decode([ArticleJson].self, from: data)
                print("success")
                
                print(latestArticleJsonList[0])
                self?.latestArticleList = latestArticleJsonList.map{
                    var article = Article()
                    
                    
//                    var reputation: Reputation?
//
//                    Task.detached {
//                        do {
//                            reputation = try await self!.getPageViewAPI.getPageView(companyId: String($0.company_id!), releaseId: String($0.release_id!))
//                        } catch {
//                            print()
//                        }
//                    }
                    
                    article.pageView = 0
                    article.title = $0.title
                    article.createdAt = $0.created_at
                    article.mainImage = $0.main_image
                    article.companyName = $0.company_name
                    article.url = $0.url
                    return article
                }
                
                self!.latestArticleList.sort{
                    $0.pageView < $1.pageView
                }

            } catch (let error) {
                print("fail to decode")
                print(error)
            }
        
        })
        
    
        task.resume()
        
    }
    
}
