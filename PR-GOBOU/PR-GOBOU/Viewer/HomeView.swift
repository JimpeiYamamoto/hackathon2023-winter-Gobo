//
//  SwiftUIView1.swift
//  PR-GOBOU
//
//  Created by 上別縄祐也 on 2023/02/16.
//

import SwiftUI

struct NormalRowView: View {

    let title: String
    let companyName: String
    let imgUrl: String
    let date: String

    var body: some View {
        VStack(alignment: .leading) {
            HStack {
                Text(title)
                    .font(.body)
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

struct ThumbnailView: View {
    let title: String
    let companyName: String
    let imgUrl: String
    let date: String

    var body: some View {
        AsyncImage(url: URL(string: imgUrl)) { image in
            image.resizable()
                .scaledToFit()
                .cornerRadius(4)
        } placeholder: {
            ProgressView()
        }
    }
}

struct HomeView: View {
    let titles:[String] = [
        "04 Limited SazabysとBiSHが「音楽と行こう」へ参加決定",
        "【DESTREE】パリ発のファッションブランド「デストレー」関西初のポップアップストアを阪急うめだ本店にて開催中",
        "[April Dream] 4月1日を夢の日に。1100社超が「夢」の発信に参加表明",
        "船の自動運転技術開発スタートアップ 株式会社エイトノット、ICCサミット FUKUOKA 2023「Honda Xcelerator カタパルト」にて優勝。"
    ]
    let images: [String] = [
        "https://prcdn.freetls.fastly.net/release_image/81361/26/81361-26-be13540c101977a814604e6aae834712-598x337.jpg?format=jpeg&auto=webp&quality=85&width=1950&height=1350&fit=bounds",
        "https://prcdn.freetls.fastly.net/release_image/68828/48/68828-48-33717cc854370965b96263d75a4b48e9-3900x2600.jpg?format=jpeg&auto=webp&quality=85%2C65&width=1950&height=1350&fit=bounds",
        "https://prcdn.freetls.fastly.net/release_image/112/1167/112-1167-3219ae855548b936461c3ec288263aed-722x378.png?format=jpeg&auto=webp&quality=85&width=1950&height=1350&fit=bounds",
        "https://prcdn.freetls.fastly.net/release_image/77033/15/77033-15-405fd3089474e9bd98f08d664cac6bcf-3900x2600.jpg?format=jpeg&auto=webp&quality=85%2C65&width=1950&height=1350&fit=bounds"
    ]
    let companyNames:[String] = [
        "au 5G エンタメPR 事務局",
        "株式会社グルッポタナカ",
        "株式会社PR TIMES",
        "株式会社エイトノット"
    ]
    let dates:[String] = [
        "2023-02-16 21:22",
        "2023-02-16 20:26",
        "2021-04-01 00:00",
        "2023-02-16 16:00"
    ]

    var body: some View {
        List {
            Section(header: Text("あなたにおすすめ")
                .foregroundColor(Color.black)) {
                ScrollView(.horizontal) {
                    HStack {ForEach(Array(titles.enumerated()), id: \.element) { index, element in
                        ThumbnailView(
                            title: titles[index],
                            companyName: companyNames[index],
                            imgUrl: images[index],

                            date: dates[index]
                        )
                        .frame(height: UIScreen.main.bounds.height/9)
                    }
                    }

                }
                .frame(height: UIScreen.main.bounds.height/8)
                .tabViewStyle(PageTabViewStyle(indexDisplayMode: .always))
            }

            Section(header: Text("フォロー")
                .foregroundColor(Color.black)) {
                ForEach(Array(titles.enumerated()), id: \.element) { index, element in
                    NormalRowView(
                        title: titles[index],
                        companyName: companyNames[index],
                        imgUrl: images[index],
                        date: dates[index]
                    )
                    .frame(height: UIScreen.main.bounds.height/11)
                }
            }

            Section(header: Text("新着")
                .foregroundColor(Color.black)) {
                ForEach(Array(titles.enumerated()), id: \.element) { index, element in
                    NormalRowView(
                        title: titles[index],
                        companyName: companyNames[index],
                        imgUrl: images[index],
                        date: dates[index]
                    )
                    .frame(height: UIScreen.main.bounds.height/12)
                }
            }
        }
        .listStyle(.inset)
    }
}

struct SwiftUIView1_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
    }
}
