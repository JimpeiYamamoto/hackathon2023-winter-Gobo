//
//  ContentView.swift
//  PR-GOBOU
//
//  Created by 上別縄祐也 on 2023/02/16.
//

import SwiftUI

struct ContentView: View {
    @State var tabIndex:Int = 0

    init(){
        UINavigationBar.appearance().backgroundColor = UIColor(red: 42/255, green: 76/255, blue: 121/255, alpha: 1)
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
                        trailing: NavigationLink(
                            destination: SettingView(),
                            label: {
                                Image(systemName: "gear")
                                    .foregroundColor(.white)
                            }
                        ).foregroundColor(.white)
                    )
                }
                .accentColor(Color(UIColor(red: 42/255, green: 76/255, blue: 121/255, alpha: 1)))
                Image("prtimes")
                    .padding(.top, 8)
            }
            .padding(.top, 0.1)
            .background(Color(UIColor(red: 42/255, green: 76/255, blue: 121/255, alpha: 1)).ignoresSafeArea(edges: .top))
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
