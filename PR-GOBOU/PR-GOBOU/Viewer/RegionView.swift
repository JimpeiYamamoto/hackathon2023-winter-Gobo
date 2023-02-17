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
    @ObservedObject var getRegionArticleAPI: GetRegionArticleAPI = GetRegionArticleAPI()
    
    init() {
        if UserDefaults.standard.object(forKey: "regionId") != nil {
            let regionId: Int = UserDefaults.standard.object(forKey: "regionId") as! Int
            getRegionArticleAPI.getRegionArticleApi(id: String(regionId))
        }
    }
    
    var body: some View {
        if UserDefaults.standard.object(forKey: "regionId") != nil {
            List {
                Section(header: Text(loadRegionName())
                    .foregroundColor(Color.black)) {
                        ForEach(0..<getRegionArticleAPI.regionArticleList.count, id: \.self) { index in
                            RegionRowView(
                                title: getRegionArticleAPI.regionArticleList[index].title!,
                                companyName: getRegionArticleAPI.regionArticleList[index].company_name!,
                                imgUrl: getRegionArticleAPI.regionArticleList[index].main_image!,
                                date: getRegionArticleAPI.regionArticleList[index].created_at!
                            )
                            .frame(height: UIScreen.main.bounds.height/12)
                        }
                    }
            }
            .listStyle(.plain)
        } else {
            VStack(alignment: .center) {
                    Text("現在、地域が設定されていません")
                        .frame(width:UIScreen.main.bounds.width)
                        .font(.caption)
                        .foregroundColor(.gray)
                    Text("右上の設定ボタンからお住まいの地域を選択できます")
                        .font(.caption)
                        .foregroundColor(.gray)

            }
        }
    }
    
    func loadRegionName() -> String{
       guard let name = UserDefaults.standard.string(forKey: "region") else { return "居住地が未設定です"}
        return name + "発のプレスリリース"
        
    }
}

struct RegionView_Previews: PreviewProvider {
    static var previews: some View {
        RegionView()
    }
}
