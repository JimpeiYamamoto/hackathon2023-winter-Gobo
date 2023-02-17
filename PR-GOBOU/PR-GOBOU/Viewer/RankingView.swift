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
                .padding(.top, 7)
                .padding(.trailing, 15)
            
            VStack(alignment: .leading) {
                HStack {
                    Text(title)
                        .padding(.top, 7)
                        .font(.body)
                    Spacer()
                    AsyncImage(url: URL(string: imgUrl)) { image in
                        image.resizable()
                            .scaledToFit()
                            .frame(width: UIScreen.main.bounds.width / 4)
                            .padding(.top, 7)
                        
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
    @ObservedObject var getRankingArticleAPI: GetRankingArticleAPI = GetRankingArticleAPI()
    
    init() {
        getRankingArticleAPI.getRankingArticle()
    }

    var body: some View {

        List {
            ForEach(0..<getRankingArticleAPI.ArticleList.count, id: \.self) { index in
                RankRowView(
                    title: getRankingArticleAPI.ArticleList[index].title!,
                    companyName: getRankingArticleAPI.ArticleList[index].company_name!,
                    imgUrl: getRankingArticleAPI.ArticleList[index].main_image!,
                    rank: index + 1,
                    date: getRankingArticleAPI.ArticleList[index].created_at!
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
