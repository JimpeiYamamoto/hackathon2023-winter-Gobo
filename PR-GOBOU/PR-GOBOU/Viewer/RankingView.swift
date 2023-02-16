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
    
    let titles:[String] = [
        "[April Dream] 4月1日を夢の日に。1100社超が「夢」の発信に参加表明",
        "船の自動運転技術開発スタートアップ 株式会社エイトノット、ICCサミット FUKUOKA 2023「Honda Xcelerator カタパルト」にて優勝。"
    ]
    let images: [String] = [
        "https://prcdn.freetls.fastly.net/release_image/112/1167/112-1167-3219ae855548b936461c3ec288263aed-722x378.png?format=jpeg&auto=webp&quality=85&width=1950&height=1350&fit=bounds",
        "https://prcdn.freetls.fastly.net/release_image/77033/15/77033-15-405fd3089474e9bd98f08d664cac6bcf-3900x2600.jpg?format=jpeg&auto=webp&quality=85%2C65&width=1950&height=1350&fit=bounds"
    ]
    let companyNames:[String] = ["株式会社PR TIMES", "株式会社エイトノット"]
    let ranks:[Int] = [1, 2]
    let dates:[String] = ["2021-04-01 00:00", "2023-02-16 16:00"]

    var body: some View {
        VStack {
            Spacer()
            Text("ランキング")
            Spacer()
            List {
                ForEach(Array(titles.enumerated()), id: \.element) { index, element in
                    RankRowView(
                        title: titles[index],
                        companyName: companyNames[index],
                        imgUrl: images[index],
                        rank: ranks[index],
                        date: dates[index]
                    )
                    .frame(height: UIScreen.main.bounds.height/9)
                }
            }
        }
    }
        
}

struct SwiftUIView2_Previews: PreviewProvider {
    static var previews: some View {
        RankingView()
    }
}
