//
//  RankingView.swift
//  PR-GOBOU
//
//  Created by 上別縄祐也 on 2023/02/16.
//

import SwiftUI

struct WriterView: View {

    @State private var keywords:[String] = ["","","","","","","",""]
    @State private var generatedSentence:String = "~~~~~~生成された記事~~~~~~~"

    var body: some View {
        ScrollView {
            VStack {
                HStack {
                    KeywordTextFieldView(inputText: $keywords[0], placeholder: "キーワード①[必須]")
                        .padding()
                        .padding(.leading)
                    KeywordTextFieldView(inputText: $keywords[1], placeholder: "キーワード②[必須]")
                        .padding()
                        .padding(.trailing)
                }
                HStack {
                    KeywordTextFieldView(inputText: $keywords[2], placeholder: "キーワード③[必須]")
                        .padding()
                        .padding(.leading)
                    KeywordTextFieldView(inputText: $keywords[3], placeholder: "キーワード④[必須]")
                        .padding()
                        .padding(.trailing)
                }
                HStack {
                    KeywordTextFieldView(inputText: $keywords[4], placeholder: "キーワード⑤")
                        .padding()
                        .padding(.leading)
                    KeywordTextFieldView(inputText: $keywords[5], placeholder: "キーワード⑥")
                        .padding()
                        .padding(.trailing)
                }
                HStack {
                    KeywordTextFieldView(inputText: $keywords[6], placeholder: "キーワード⑦")
                        .padding()
                        .padding(.leading)
                    KeywordTextFieldView(inputText: $keywords[7], placeholder: "キーワード⑧")
                        .padding()
                        .padding(.trailing)
                }
                .padding(.bottom)
                
                Button {
                    // ChatGPTのAPIを叩く
                } label: {
                    Text("プレスリリース案の生成".uppercased())
                        .font(.headline)
                        .foregroundColor(.white)
                        .padding()
                        .padding(.horizontal, 20)
                        .background(
                            Color.blue
                                .cornerRadius(10)
                                .shadow(radius: 10)
                                .frame(width: UIScreen.main.bounds.width/10 * 9)
                        )
                        .frame(width: UIScreen.main.bounds.width/10 * 9)
                }
                .padding(.bottom)
                
                if generatedSentence.count != 0 {
                    TextEditor(text: $generatedSentence)
                        .frame(height: 300)
                        .frame(width: UIScreen.main.bounds.width/10*9)
                }
            }
        }
    }
}

struct KeywordTextFieldView: View {
    
    @Binding var inputText:String
    let placeholder:String

    var body: some View {
        TextField(placeholder, text: $inputText)
            .overlay(
                RoundedRectangle(cornerSize: CGSize(width: 8.0, height: 8.0))
                    .stroke(.gray, lineWidth: 1.0)
                    .padding(-10.0)
            )
    }
}

struct WriterView_Previews: PreviewProvider {
    static var previews: some View {
        WriterView()
    }
}
