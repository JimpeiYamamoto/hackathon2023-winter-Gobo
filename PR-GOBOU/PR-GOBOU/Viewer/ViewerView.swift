//
//  HomeView.swift
//  PR-GOBOU
//
//  Created by 上別縄祐也 on 2023/02/16.
//

import SwiftUI

struct ViewerView: View {
    @State var selection = 0
    let tabList = ["ホーム", "ランキング", "地域"]
    var body: some View {
        VStack {
                    Picker("", selection: $selection) {
                        Text(tabList[0]).tag(0)
                        Text(tabList[1]).tag(1)
                        Text(tabList[2]).tag(2)
                    }.pickerStyle(SegmentedPickerStyle())
                    
                    TabView(selection: $selection) {
                        HomeView()
                            .tag(0)
                        RankingView()
                            .tag(1)
                        RegionView()
                            .tag(2)
                    }
                    .tabViewStyle(PageTabViewStyle(indexDisplayMode: .never))
                }
    }
}

struct ViewerView_Previews: PreviewProvider {
    static var previews: some View {
        ViewerView()
    }
}
