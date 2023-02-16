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
        UITabBar.appearance().unselectedItemTintColor = .gray
        
    }

    var body: some View {
            ZStack(alignment: .top) {
                NavigationView {
                    VStack{
                        TabView(selection: $tabIndex){
                            ViewerView().tabItem{
                                Group{
                                    Image(systemName: "book")
                                    Text("Viewer")
                                }
                            }.tag(0)
                            WriterView()
                                .tabItem{
                                    Group{
                                        Image(systemName: "square.and.pencil")
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
                .accentColor(Color(UIColor(red: 44/255, green: 68/255, blue: 110/255, alpha: 1)))
                Image("PRTimes_Logo")
                    .padding(.top, 8)
            }
            .padding(.top, 0.1)
            .background(Color(UIColor(red: 44/255, green: 68/255, blue: 110/255, alpha: 1)).ignoresSafeArea(edges: .top))

    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
