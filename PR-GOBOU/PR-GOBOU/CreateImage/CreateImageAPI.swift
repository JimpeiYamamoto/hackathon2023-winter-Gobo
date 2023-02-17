//
//  CreateImageAPI.swift
//  PR-GOBOU
//
//  Created by 上別縄祐也 on 2023/02/17.
//

import Foundation


class CreateImageAPI: ObservableObject{
    @Published var url = [Url]()
    let host = "http://localhost:8000/items/"
    let token = "b655dffbe1b2c82ca882874670cb110995c6604151e1b781cf5c362563eb4e12"
    
   
    func createImage(keywords: [String]) {
        let string = keywords.joined(separator: " ")
        var components: URLComponents = URLComponents(string: host + string)!
        components.queryItems = []
        
        guard let url = components.url else { return }
        var request = URLRequest(url: url)
//        request.httpMethod = "GET"
//        request.setValue("Accept", forHTTPHeaderField: "application/json")
//        request.setValue("Bearer \(token)", forHTTPHeaderField: "Authorization")
        
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
                self?.url = try decoder.decode([Url].self, from: data)
                print(self?.url.count)
                print("success")
            } catch (let error) {
                print("fail to decode")
                print(error)
            }
        
        })
        
    
        task.resume()
        
    }
    
}
