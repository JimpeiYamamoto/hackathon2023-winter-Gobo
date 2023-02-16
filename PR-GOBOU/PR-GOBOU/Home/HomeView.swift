//
//  HomeView.swift
//  PR-GOBOU
//
//  Created by 上別縄祐也 on 2023/02/16.
//

import SwiftUI

struct HomeView: View {
    @State var tabIndex = 0
    let tabList = ["ホーム", "ランキング"]
    var body: some View {
        VStack {
            HStack {
                Spacer()
                Button(action: {
                    tabIndex = 0
                }, label: {
                    Text(tabList[0])
                        .fontWeight((tabIndex == 0) ? .semibold : nil)
                        .frame(width: 100, height: 30)
                        .foregroundColor((tabIndex == 0) ? Color(.black) : Color(.lightGray))
                        .cornerRadius(24)
                    
                })
                Spacer()
                Button(action: {
                    tabIndex = 1
                }, label: {
                    Text(tabList[1])
                        .fontWeight((tabIndex == 1) ? .semibold : nil)
                        .frame(width: 100, height: 30)
                        .foregroundColor((tabIndex == 1) ? Color(.black) : Color(.lightGray))
                        .cornerRadius(24)
                    
                })
                Spacer()
            }
            
            if tabIndex == 0 {
                View1()
            } else if tabIndex == 1 {
                View2()
            }
            Spacer()
        }
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
    }
}
