//
//  RegionView.swift
//  PR-GOBOU
//
//  Created by 上別縄祐也 on 2023/02/16.
//

import SwiftUI

struct RegionRowView: View {
    
    let title: String
    let companyName: String
    let imgUrl: String
    let date: String
    
    var body: some View {
        VStack(alignment: .leading) {
            HStack {
                Text(title)
                    .padding(.top, 5)
                    .font(.body)
                Spacer()
                AsyncImage(url: URL(string: imgUrl)) { image in
                    image.resizable()
                        .scaledToFit()
                        .frame(width: UIScreen.main.bounds.width / 4)
                        .padding(.top, 5)
                    
                } placeholder: {
                    ProgressView()
                }
            }
            Spacer()
            HStack {
                Text(companyName)
                    .font(.caption)
                    .foregroundColor(Color.gray)
                Text(date)
                    .font(.caption)
                    .foregroundColor(Color.gray)
            }
        }
        
    }
}

struct RegionView: View {
    @ObservedObject var getArticleAPI: GetArticleAPI = GetArticleAPI()
    
    init() {
        getArticleAPI.getLatestArticleApi()
    }
    
    var body: some View {
        
        List {
            Section(header: Text("大阪府のニュース")
                .foregroundColor(Color.black)) {
                    ForEach(0..<getArticleAPI.latestArticleList.count, id: \.self) { index in
                        RegionRowView(
                            title: getArticleAPI.latestArticleList[index].title!,
                            companyName: getArticleAPI.latestArticleList[index].companyName!,
                            imgUrl: getArticleAPI.latestArticleList[index].mainImage!,
                            date: getArticleAPI.latestArticleList[index].createdAt!
                        )
                        .frame(height: UIScreen.main.bounds.height/12)
                    }
                }
        }
        .listStyle(.plain)
    }
}

struct RegionView_Previews: PreviewProvider {
    static var previews: some View {
        RegionView()
    }
}
