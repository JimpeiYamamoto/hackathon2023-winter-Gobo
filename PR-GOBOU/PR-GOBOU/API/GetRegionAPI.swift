//
//  GetRegionAPI.swift
//  PR-GOBOU
//
//  Created by 上別縄祐也 on 2023/02/16.
//

import Foundation


class GetRegionAPI: ObservableObject{
    @Published var regionList = [Region]()
    
    let host = "https://hackathon.stg-prtimes.net/api/"
    let token = "b655dffbe1b2c82ca882874670cb110995c6604151e1b781cf5c362563eb4e12"
   
    func getRegionApi(){
        var components: URLComponents = URLComponents(string: host + "prefectures")!
        components.queryItems = []
        
        guard let url = components.url else { return }
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        request.setValue("Accept", forHTTPHeaderField: "application/json")
        request.setValue("Bearer \(token)", forHTTPHeaderField: "Authorization")
        
        sessionTask(request: request)
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
                    me.regionList = try decoder.decode([Region].self, from: data)
                    print("success")
                } catch (let error) {
                    print("fail to decode")
                    print(error)
                }
        })
        task.resume()
    }
    
}
