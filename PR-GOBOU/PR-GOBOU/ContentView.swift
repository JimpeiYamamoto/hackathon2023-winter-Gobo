//
//  ContentView.swift
//  PR-GOBOU
//
//  Created by 上別縄祐也 on 2023/02/16.
//

import SwiftUI

struct ContentView: View {
    @State var tabIndex:Int = 0

    //    init() {
    //        UINavigationBar.appearance().backgroundColor = UIColor.blue
    //        UINavigationBar.appearance().statusBar = UIColor.blue
    //    }

    init(){
        //ナビゲーションバーの背景色の設定
        UINavigationBar.appearance().backgroundColor = UIColor(red: 44/255, green: 68/255, blue: 110/255, alpha: 1)
    }

    var body: some View {
        ZStack(alignment: .top) {
            NavigationView {
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
                    }
                }
                .navigationBarItems(
                    leading: NavigationLink(
                        destination: SettingView(),
                        label: {
                            Image(systemName: "person.fill")
                                .foregroundColor(.white)
                        }
                    ),
                    trailing: NavigationLink(
                        destination: EmptyView(),
                        label: {
                            Image(systemName: "magnifyingglass")
                                .foregroundColor(.white)
                            
                        })
                )
            }
            .accentColor(.white)
            Image("PRTimes_Logo")
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
