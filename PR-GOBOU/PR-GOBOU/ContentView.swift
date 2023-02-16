//
//  ContentView.swift
//  PR-GOBOU
//
//  Created by 上別縄祐也 on 2023/02/16.
//

import SwiftUI

struct ContentView: View {
    @State var tabIndex:Int = 0
    var body: some View {
        VStack{
            TabView(selection: $tabIndex){
                HomeView().tabItem{
                    Group{
                        Image(systemName: "house")
                        Text("Home")
                    }
                }.tag(0)
                RankingView()
                    .tabItem{
                    Group{
                        Image(systemName: "book")
                        Text("Ranking")
                    }
                }.tag(1)
            }.padding(.bottom)
    }.edgesIgnoringSafeArea(.all)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
