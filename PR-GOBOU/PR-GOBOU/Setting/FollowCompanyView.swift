//
//  FollowCompanyView.swift
//  PR-GOBOU
//
//  Created by 水代謝システム工学研究室 on 2023/02/16.
//

import SwiftUI

struct FollowCompanyView: View {

    let companyIds: [Int] = [
        1,
        2,
    ]
    let companyNames: [String] = [
        "株式会社PR TIMES",
        "株式会社エイトノット"
    ]
    
    @State private var isCheckeds: [Bool] = [false, false]
    
    var body: some View {
        List {
            ForEach(Array(companyIds.enumerated()), id: \.element) { index, _ in
                HStack {
                    Button {
                        isCheckeds[index] = !isCheckeds[index]
                        UIImpactFeedbackGenerator(style: .medium)
                            .impactOccurred()
                        saveFollowCompanyIds()
                    } label: {
                        if isCheckeds[index] {
                            Image(systemName: "checkmark.square.fill")
                                .foregroundColor(.blue)
                        } else {
                            Image(systemName: "square")
                        }
                    }
                    Text(companyNames[index])
                }
            }
        }
        .onAppear(perform: {
            loadFollowCompanyIds()
        })
        .listStyle(.plain)
        .navigationTitle(Text("フォローする企業を選択してください"))
        .navigationBarItems(
            leading:NavigationLink(
                destination: {EmptyView()},
                label: {Text("完了")}
            )
        )
    }
    
    private func saveFollowCompanyIds() {
        var saveIds:[Int] = []
        
        for (index, companyId) in self.companyIds.enumerated() {
            if isCheckeds[index] {
                saveIds.append(companyId)
            }
        }
        UserDefaults.standard.set(saveIds, forKey: "followCompanyIds")
    }
    
    private func loadFollowCompanyIds() {
        let saveIds = UserDefaults.standard.array(forKey: "followCompanyIds") as? [Int] ?? []
        for (index, companyId) in companyIds.enumerated() {
            if saveIds.contains(companyId) {
                self.isCheckeds[index] = true
            } else {
                self.isCheckeds[index] = false
            }
        }
    }
}

struct FollowCompanyView_Previews: PreviewProvider {
    static var previews: some View {
        FollowCompanyView()
    }
}
