//
//  FollowView.swift
//  PR-GOBOU
//
//  Created by Tomohiro Kawakami on 2023/02/17.
//

import SwiftUI

struct FollowRowView: View {

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

struct FollowView: View {
    var getCompanyArticleAPI: GetCompanyArticleAPI?

    var body: some View {

            List {
                Section(header: Text("フォロー")
                    .foregroundColor(Color.black)) {
                        ForEach(0..<getCompanyArticleAPI!.companyArticleList.count, id: \.self) { index in
                            ZStack{
                                NavigationLink(destination: ArticleView(url: getCompanyArticleAPI!.companyArticleList[index].url!)) { EmptyView() }
                                    .opacity(0)
                                RegionRowView(
                                    title: getCompanyArticleAPI!.companyArticleList[index].title!,
                                    companyName: getCompanyArticleAPI!.companyArticleList[index].company_name!,
                                    imgUrl: getCompanyArticleAPI!.companyArticleList[index].main_image!,
                                    date: getCompanyArticleAPI!.companyArticleList[index].created_at!
                                )
                            }
                            .frame(height: UIScreen.main.bounds.height/12)
                        }
                    }
            }
            .listStyle(.plain)
    }
}

struct FollowView_Previews: PreviewProvider {
    static var previews: some View {
        FollowView()
    }
}
