//
//  SettingView.swift
//  PR-GOBOU
//
//  Created by 水代謝システム工学研究室 on 2023/02/16.
//

import SwiftUI

struct SettingView: View {

    var body: some View {
        List {
            Section(
                header: Text("設定")
            ){
                NavigationLink(destination: SelectRegionView(), label: { Text("居住地") })
                NavigationLink(destination: FollowCompanyView(), label: { Text("フォロー企業") })
            }
        }
        .listStyle(.plain)
    }
}

struct SettingView_Previews: PreviewProvider {
    static var previews: some View {
        SettingView()
    }
}
