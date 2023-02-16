//
//  SwiftUIView2.swift
//  PR-GOBOU
//
//  Created by 上別縄祐也 on 2023/02/16.
//

import SwiftUI

struct RankRowView: View {
    
    let title: String
    let companyName: String
    let imgUrl: String
    let rank: Int
    let date: String

    var body: some View {
        HStack(alignment: .top) {
            Text(String(rank))
                .font(.title2)
                .padding(.top, 10)
                .padding(.trailing, 15)
            
            VStack(alignment: .leading) {
                HStack {
                    Text(title)
                        .padding(.top, 10)
                        .font(.body)
                    Spacer()
                    AsyncImage(url: URL(string: imgUrl)) { image in
                        image.resizable()
                            .scaledToFit()
                            .frame(width: UIScreen.main.bounds.width / 4)
                            .padding(.top, 10)
                        
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
}

struct RankingView: View {
    @ObservedObject var getArticleAPI: GetArticleAPI = GetArticleAPI()
    
    init() {
        getArticleAPI.getLatestArticleApi()
    }

    var body: some View {

        List {
            ForEach(0..<getArticleAPI.latestArticleList.count, id: \.self) { index in
                RankRowView(
                    title: getArticleAPI.latestArticleList[index].title!,
                    companyName: getArticleAPI.latestArticleList[index].companyName!,
                    imgUrl: getArticleAPI.latestArticleList[index].mainImage!,
                    rank: index + 1,
                    date: getArticleAPI.latestArticleList[index].createdAt!
                )
                .frame(height: UIScreen.main.bounds.height/9)
            }
        }
        .listStyle(.plain)
    }
}

struct SwiftUIView2_Previews: PreviewProvider {
    static var previews: some View {
        RankingView()
    }
}
