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
                ViewerView().tabItem{
                    Group{
                        Image(systemName: "house")
                        Text("Viewer")
                    }
                }.tag(0)
                WriterView()
                    .tabItem{
                    Group{
                        Image(systemName: "book")
                        Text("Writer")
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
