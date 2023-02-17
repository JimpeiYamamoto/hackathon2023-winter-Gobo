//
//  MovieArticleView.swift
//  PR-GOBOU
//
//  Created by Tomohiro Kawakami on 2023/02/17.
//

import SwiftUI

struct MovieArticleView: View {
    @Environment(\.dismiss) private var dismiss
    var url: String
    var body: some View {
        VStack(alignment: .leading, spacing: 0){
            Button(action: { dismiss() }) {
                HStack {
                    Image(systemName: "chevron.left")
                    Text("戻る")
                }
                .padding(EdgeInsets(top: 0, leading: 8, bottom: 0, trailing: 0))
            }
            .frame(width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height / 20, alignment: .leading)
            .foregroundColor(.white)
            .background(Color(UIColor(red: 42/255, green: 76/255, blue: 121/255, alpha: 1)))
            WebView(url: url)
        }

    }
}

struct MovieArticleView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
