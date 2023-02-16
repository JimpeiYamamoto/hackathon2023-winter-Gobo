//
//  ArticleView.swift
//  PR-GOBOU
//
//  Created by Tomohiro Kawakami on 2023/02/17.
//

import SwiftUI
import RichText

struct ArticleView: View {
    @State var html = "【開催概要】<br />\r\n名称：対日理解促進交流プログラム　JENESYS2022　日カンボジアパラスポーツ交流<br />\r\nテーマ&nbsp;&nbsp; ：パラスポーツ<br />\r\n日時&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ：2023年2月15日（水）〜2月21日（火）<br />\r\n日程（予定）：<br />\r\n2月15日（水）&nbsp; 来日<br />\r\n　　　　　　&nbsp; &nbsp;【視察】　東京タワー<br />\r\n2月16日（木）【テーマ関連視察】日本オリンピックミュージアム<br />\r\n&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; 【テーマ関連講義】日本パラスポーツ協会<br />\r\n2月17日（金）【日本文化体験】抹茶体験<br />\r\n2月18日（土）【交流】<br />\r\n&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; 日本女子車いすバスケットボールチーム・九州ドルフィンとの合同練習・試合<br />\r\n2月19日（日）【視察】うみたまご・海地獄<br />\r\n&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; 【ワークショップ】<br />\r\n2月20日（月）【報告会】訪日中の成果、帰国後の活動計画を報告<br />\r\n2月21日（火）&nbsp; 帰国<br />\r\n対象&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ：カンボジア女子車いすバスケットボール選手・関係者　20名<br />\r\n言語&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ：クメール語、日本語<br />\r\n実施方法：対面招へい<br />\r\n実施団体：一般財団法人 日本国際協力センター(JICE)\r\n<p id=\"p-iframe-image-39960-1\"><span class=\"no-edit center\" contenteditable=\"false\" id=\"iframe-image-area-39960-1\" style=\"margin-left: 34px; margin-right: 34px;\" xx=\"prtimes\"><img alt=\"\" class=\"editor-image center\" data-caption=\"iframe-image-caption-39960-1\" data-nheight=\"720\" data-nwidth=\"1280\" data-width=\"100\" id=\"iframe-image-39960-1\" src=\"/api/file.php?t=origin&amp;f=d74396-266-cad3b2d3dc49735ac39e-0.jpg&amp;s3=74396-266-301b441789140d7812c4be02a5d8a099-1280x720.jpg\" style=\"width: 650px; height: auto; opacity: 1;\" title=\"\" xx=\"prtimes\" /></span></p>\r\n【対日理解促進交流プログラムJENESYS事業概要】<br/>\r\n<br/>\r\n「対日理解促進交流プログラム」は、日本政府が推進する国際交流事業で、日本とアジア大洋州、北米、欧州、中南米の各国・地域との間で、対外発信力を有し将来を担う人材を招へい・派遣、又はオンライン交流を行います。このうちアジア大洋州地域を対象とした交流事業がJENESYSです。人的交流を通じて、政治、経済、社会、文化、歴史、外交政策等に関する対日理解の促進を図るとともに、親日派・知日派を発掘し、日本の外交姿勢や魅力等について参加者自ら積極的に発信してもらうことで対外発信を強化し、日本の外交基盤を拡充することを目的としています。<br />\r\n<br />\r\n&nbsp;【本件に関するお問い合わせ先】<br />\r\n一般財団法人日本国際協力センター(JICE)　国際交流部<br />\r\nお問い合わせフォーム：https://www.jice.org/contact/index.html"
    
    
    var body: some View {
        ScrollView{
            
            VStack(alignment: .center) {
                Spacer()
                Text("カンボジア女子車いすバスケットボールナショナルチームが来日し、パラスポーツ交流を行います")
                    .font(.title3)
                    .bold()
                    .frame(width: UIScreen.main.bounds.width * 0.95)
                Spacer()
                Text("外務省が推進する国際交流事業対日理解促進交流プログラム「JENESYS2022」の一環として、カンボジア女子車いすバスケットボール選手と関係者20名が来日し、日本のパラスポーツの現状を学びます。")
                    .font(.subheadline)
                    .frame(width: UIScreen.main.bounds.width * 0.9)
                Spacer()
                HStack(alignment: .top) {
                    Text("一般財団法人　日本国際協力センター")
                        .font(.caption)
                    Spacer()
                    Text("2023-02-13-10-31")
                        .font(.caption)
                }
                .frame(width: UIScreen.main.bounds.width * 0.9)
                Spacer()
                
                AsyncImage(url: URL(string: "https://prcdn.freetls.fastly.net/release_image/74396/266/74396-266-301b441789140d7812c4be02a5d8a099-1280x720.jpg?format=jpeg&auto=webp&quality=85%2C75&width=1950&height=1350&fit=bounds")) { image in
                    image.resizable()
                        .scaledToFit()
                        .frame(width: UIScreen.main.bounds.width * 0.9)
                        .padding(.top, 10)
                } placeholder: {
                    ProgressView()
                }.frame(width: UIScreen.main.bounds.width)
                RichText(html: html)
                    .lineHeight(170)
                    .colorScheme(.auto)
                    .imageRadius(12)
                    .fontType(.system)
                    .foregroundColor(light: Color.primary, dark: Color.primary)
                    .linkColor(light: Color.blue, dark: Color.blue)
                    .colorPreference(forceColor: .onlyLinks)
                    .linkOpenType(.SFSafariView())
                    .customCSS("")
                    .placeholder {
                        Text("loading")
                    }
                    .transition(.easeOut)
                    .frame(width: UIScreen.main.bounds.width * 0.95)
            }
            
        }
    }
}

struct ArticleView_Previews: PreviewProvider {
    static var previews: some View {
        ArticleView()
    }
}
