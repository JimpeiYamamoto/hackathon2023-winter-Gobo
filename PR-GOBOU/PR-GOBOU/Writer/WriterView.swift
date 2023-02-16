//
//  RankingView.swift
//  PR-GOBOU
//
//  Created by 上別縄祐也 on 2023/02/16.
//

import SwiftUI
import OpenAISwift

struct WriterView: View {

    @State private var keywords:[String] = ["","","","","","", ""]
    @State private var generatedSentence:String = ""

    var body: some View {
        ScrollView {
            
            VStack(alignment: .leading) {
                Text("Q1. 何をリリースしますか？")
                    .padding(.horizontal)
                    .padding(.top)
                KeywordTextFieldView(inputText: $keywords[0], placeholder: "キーワード[必須]")
                    .padding(.horizontal)
                    .padding(.bottom)
                Text("Q2. リリースの日付はいつですか？")
                    .padding(.horizontal)
                KeywordTextFieldView(inputText: $keywords[2], placeholder: "例:○月△日[必須]")
                    .padding(.horizontal)
                    .padding(.bottom)
                Text("Q3. 特徴を教えてください")
                    .padding(.horizontal)
                Keyword4Rows(
                    keyword1: $keywords[3],
                    keyword2: $keywords[4],
                    keyword3: $keywords[5],
                    keyword4: $keywords[6]
                )
                
            }
            Button {
                send()
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
                VStack(alignment: .leading) {
                    Text("提案")
                        .font(.headline)
                        .underline()
                    TextEditor(text: $generatedSentence)
                        .frame(height: 400)
                        .frame(width: UIScreen.main.bounds.width/10*9)
                        .border(Color.black, width: 1)
                        .disabled(true)
                }
            }
        }
    }
    
    func send() {
        let client = OpenAISwift(authToken: "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")

        var inputText = "以下の単語を使って注目を集められるプレスリリースを考案してください。"
        for keyword in self.keywords {
            let word = "「" + keyword + "」"
            if keyword != "" {
                inputText += word
            }
        }

        client.sendCompletion(with: inputText, maxTokens: 100, completionHandler: { result in
            switch result {
            case .success(let model):
                DispatchQueue.main.async {
                    let output = model.choices.first?.text ?? ""
                    self.generatedSentence = output
                }
            case .failure:
                print("呼ばれた？")
                break
            }
        })
    }
}

struct Keyword4Rows: View {
    
    @Binding var keyword1:String
    @Binding var keyword2:String
    @Binding var keyword3:String
    @Binding var keyword4:String
    
    var body: some View {
        KeywordTextFieldView(inputText: $keyword1, placeholder: "キーワード①[必須]")
            .padding(.horizontal)
        KeywordTextFieldView(inputText: $keyword2, placeholder: "キーワード②[必須]")
            .padding(.horizontal)
            .padding(.vertical)
        KeywordTextFieldView(inputText: $keyword3, placeholder: "キーワード③")
            .padding(.horizontal)
        KeywordTextFieldView(inputText: $keyword4, placeholder: "キーワード④")
            .padding(.horizontal)
                .padding(.vertical)
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
