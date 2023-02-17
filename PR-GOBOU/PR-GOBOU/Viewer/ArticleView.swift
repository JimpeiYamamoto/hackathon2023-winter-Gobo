//
//  ArticleView.swift
//  PR-GOBOU
//
//  Created by Tomohiro Kawakami on 2023/02/17.
//

import SwiftUI

struct ArticleView: View {
    var url: String = "https://prtimes.jp/main/html/rd/p/000001201.000000112.html"
    var body: some View {
        WebView(url: url)
    }
}

struct ArticleView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
