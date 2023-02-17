//
//  RankingView.swift
//  PR-GOBOU
//
//  Created by 上別縄祐也 on 2023/02/16.
//

import SwiftUI
import OpenAISwift

struct WriterView: View {

    @State private var companyName:String = ""
    @State private var releaseName:String = ""
    @State private var releaseDate:String = ""
    @State private var keywords:[String] = ["","","",""]
    @State private var generatedSentence:String = ""
    @State private var isFirst:Bool = true
    @State private var isShowIndicator:Bool = false
    
    var body: some View {
        
        ZStack {
            ScrollView {
                VStack(alignment: .leading) {
                    Text("Q1. 会社名")
                        .padding(.horizontal, 5)
                        .padding(.top)
                        .font(.headline)
                        .foregroundColor(Color(UIColor(red: 42/255, green: 76/255, blue: 121/255, alpha: 1)))
                    KeywordTextFieldView(inputText: $companyName, placeholder: "例:株式会社PR TIMES")
                        .padding(.horizontal)
                        .padding(.bottom)
                    Text("Q2. 何をリリースしますか?")
                        .padding(.horizontal, 5)
                        .font(.headline)
                        .foregroundColor(Color(UIColor(red: 42/255, green: 76/255, blue: 121/255, alpha: 1)))
                    KeywordTextFieldView(inputText: $releaseName, placeholder: "キーワード[必須]")
                        .padding(.horizontal)
                        .padding(.bottom)
                    Text("Q2. リリースの日付はいつですか？")
                        .padding(.horizontal, 5)
                        .font(.headline)
                        .foregroundColor(Color(UIColor(red: 42/255, green: 76/255, blue: 121/255, alpha: 1)))
                    KeywordTextFieldView(inputText: $releaseDate, placeholder: "例:○月△日[必須]")
                        .padding(.horizontal)
                        .padding(.bottom)
                    Text("Q4. 特徴を教えてください")
                        .padding(.horizontal, 5)
                        .font(.headline)
                        .foregroundColor(Color(UIColor(red: 42/255, green: 76/255, blue: 121/255, alpha: 1)))
                    Keyword4Rows(
                        keyword1: $keywords[0],
                        keyword2: $keywords[1],
                        keyword3: $keywords[2],
                        keyword4: $keywords[3]
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
                            isButtonDisable() ? Color.gray.cornerRadius(10).frame(width: UIScreen.main.bounds.width/25*24) : Color(UIColor(red: 236/255, green: 153/255, blue: 66/255, alpha: 1)).cornerRadius(10).frame(width: UIScreen.main.bounds.width/25*24)
                        )
                        .frame(width: UIScreen.main.bounds.width/25 * 24)
                }
                .disabled(isButtonDisable())
                .padding(.bottom)
                
                if generatedSentence.count != 0 {
                    VStack {
                        HStack {
                            Text("提案")
                                .font(.headline)
                                .underline()
                                .padding(.leading, 25)
                            Spacer()
                            Button(action: {
                                sharePost(shareText: generatedSentence)
                            }) {
                                Image(systemName: "square.and.arrow.up")
                                    .font(.title2)
                            }
                                .padding(.trailing, 25)
                        }
                        TextEditor(text: $generatedSentence)
                            .frame(height: 1000)
                            .frame(width: UIScreen.main.bounds.width/10*9)
                            .border(Color.black, width: 1)
                            .disabled(true)
                        
                    }
                }
            }
            if isButtonDisable() {
                HUDProgressView(placeHolder: "生成中", isShow: $isShowIndicator)
            }
        }
    }
    
    func isButtonDisable() -> Bool {
        let ret = (isFirst == false) && (generatedSentence.count == 0)
        self.isShowIndicator.toggle()
        return ret
    }
    
    func send() {
        self.isFirst = false
        self.generatedSentence = ""
        let client = OpenAISwift(authToken: "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")

        var inputText = self.releaseDate + "に発表される" + self.companyName + "という会社が" + self.releaseName + "を発表します。" + "以下の単語を使って 注目を集められるプレスリリースを400文字以内で考案してください。"
        for keyword in self.keywords {
            let word = "「" + keyword + "」"
            if keyword != "" {
                inputText += word
            }
        }

        client.sendCompletion(with: inputText, maxTokens: 800, completionHandler: { result in
            switch result {
            case .success(let model):
                DispatchQueue.main.async {
                    let output = model.choices.first?.text ?? ""
                    self.generatedSentence = output
                }
            case .failure:
                break
            }
        })
    }

    func sharePost(shareText: String) {
        let activityItems = [shareText] as [Any]
        let activityVC = UIActivityViewController(activityItems: activityItems, applicationActivities: nil)
        let scenes = UIApplication.shared.connectedScenes
        let windowScene = scenes.first as? UIWindowScene
        let window = windowScene?.windows.first
        let viewController = window!.rootViewController
        viewController?.present(activityVC, animated: true)
    }
}

struct HUDProgressView: View {
    var placeHolder: String
    @Binding var isShow: Bool
    @State var animated = false
    
    var body: some View {
        VStack(spacing: 28) {
            Circle()
                .stroke(AngularGradient(gradient: .init(colors: [Color.primary, Color.primary.opacity(0)]), center: .center))
                .frame(width: 80, height: 80)
                .rotationEffect(.init(degrees: animated ? 360: 0))
            
            Text(placeHolder)
                .fontWeight(.bold)

        }
        .padding(.vertical, 25)
        .padding(.horizontal, 35)
        .background(BlurView())
        .cornerRadius(20)
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(
            Color.primary.opacity(0.35)
                .onTapGesture {
                    withAnimation {
                        isShow.toggle()
                    }
                }
        )
        .onAppear {
            withAnimation(Animation.linear(duration: 1.5).repeatForever(autoreverses: false)) {
                animated.toggle()
            }
        }
    }
}

struct BlurView: UIViewRepresentable {
    func makeUIView(context: Context) -> UIVisualEffectView {
        let view = UIVisualEffectView(effect: UIBlurEffect(style: .systemThinMaterial))
        return view
    }
    
    func updateUIView(_ uiView: UIVisualEffectView, context: Context) {
        
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
