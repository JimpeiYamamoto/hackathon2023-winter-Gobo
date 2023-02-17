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
    @ObservedObject var getArticleAPI: GetArticleAPI = GetArticleAPI()
    @ObservedObject var getRecommendVideoAPI: GetRecomendVideoAPI = GetRecomendVideoAPI()
    @ObservedObject var getCompanyArticleAPI: GetCompanyArticleAPI = GetCompanyArticleAPI()
    
    @State var isShowCompanyFollowView = false
    @State private var show: Bool = false
    
    init() {
        getArticleAPI.getLatestArticleApi()
        getRecommendVideoAPI.getRecommendVideoApi()
        
        if UserDefaults.standard.object(forKey: "followCompanyIds") != nil {
            let followCompanyIds: [Int] = UserDefaults.standard.object(forKey: "followCompanyIds") as! [Int]
            
            getCompanyArticleAPI.getCompanyArticleApi(ids: followCompanyIds)
        }
    }

    var body: some View {
        List {
            Section(header: Text("あなたにおすすめ")
                .foregroundColor(Color.black)) {
                    ScrollView(.horizontal) {
                        HStack {
                            ForEach(0..<getRecommendVideoAPI.recomendVideoList.count, id: \.self) { index in
                                Button(action: { self.show.toggle() }) {
                                    ThumbnailView(
                                        title: getRecommendVideoAPI.recomendVideoList[index].title!,
                                        companyName: getRecommendVideoAPI.recomendVideoList[index].company_name!,
                                        imgUrl: getRecommendVideoAPI.recomendVideoList[index].main_image!,
                                        date: getRecommendVideoAPI.recomendVideoList[index].created_at!
                                    )
                                }
                                .sheet(isPresented: self.$show) {
                                    MovieArticleView(url: getRecommendVideoAPI.recomendVideoList[index].url!)
                                }
                                .frame(height: UIScreen.main.bounds.height/9)
                                //NavigationLink(destination: ArticleView()) {}
                            }
                        }
                    }
                    .frame(height: UIScreen.main.bounds.height/8)
                    .tabViewStyle(PageTabViewStyle(indexDisplayMode: .always))
                }
            Section(header: Text("フォロー")
                .foregroundColor(Color.black), footer: Text("もっと見る...")
                .font(.caption)
                .padding(EdgeInsets(top: 0, leading: 0, bottom: 0, trailing: 8))
                .foregroundColor(Color.gray).frame(width: UIScreen.main.bounds.width, alignment: .trailing)
            ) {
                if UserDefaults.standard.object(forKey: "followCompanyIds") != nil && getCompanyArticleAPI.companyArticleList.count != 0{
                    ForEach(0..<min(getCompanyArticleAPI.companyArticleList.count, 4), id: \.self) { index in
                        ZStack {
                            NavigationLink(destination: ArticleView(url: getCompanyArticleAPI.companyArticleList[index].url!)) { EmptyView() }
                                .opacity(0)
                            NormalRowView(
                                title: getCompanyArticleAPI.companyArticleList[index].title!,
                                companyName: getCompanyArticleAPI.companyArticleList[index].company_name!,
                                imgUrl: getCompanyArticleAPI.companyArticleList[index].main_image!,
                                date: getCompanyArticleAPI.companyArticleList[index].created_at!
                            )
                        }
                        .frame(height: UIScreen.main.bounds.height/11)
                    }
                }
                else if getCompanyArticleAPI.companyArticleList.count == 0 {
                    VStack(alignment: .center) {
                        Text("ああああああああああああああああああああああああああああああああ")
                            .foregroundColor(.clear)
                        Text("現在、フォロー中の企業のリリースはありません")
                            .frame(width:UIScreen.main.bounds.width)
                            .font(.caption)
                            .foregroundColor(.gray)
                        Text("右上の設定ボタンから他の企業をフォローできます")
                            .font(.caption)
                            .foregroundColor(.gray)
                        Text("ああああああああああああああああああああああああああああああああ")
                            .foregroundColor(.clear)
                    }
                    .frame(height: UIScreen.main.bounds.height/15)
                }
                else {
                    VStack(alignment: .center) {
                        Text("ああああああああああああああああああああああああああああああああ")
                            .foregroundColor(.clear)
                        Text("現在、フォローしている企業はありません")
                            .frame(width:UIScreen.main.bounds.width)
                            .font(.caption)
                            .foregroundColor(.gray)
                        Text("右上の設定ボタンから企業をフォローできます")
                            .font(.caption)
                            .foregroundColor(.gray)
                        Text("ああああああああああああああああああああああああああああああああ")
                            .foregroundColor(.clear)
                    }
                    .frame(height: UIScreen.main.bounds.height/15)
                }
            }
            
            Section(header: Text("新着")
                .foregroundColor(Color.black)) {
                    ForEach(0..<getArticleAPI.latestArticleList.count, id: \.self) { index in
                        ZStack {
                            NavigationLink(destination: ArticleView(url: getArticleAPI.latestArticleList[index].url!)) { EmptyView() }
                                .opacity(0)
                            NormalRowView(
                                title: getArticleAPI.latestArticleList[index].title!,
                                companyName: getArticleAPI.latestArticleList[index].company_name!,
                                imgUrl: getArticleAPI.latestArticleList[index].main_image!,
                                date: getArticleAPI.latestArticleList[index].created_at!
                            )
                        }
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
