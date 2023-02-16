//
//  FollowCompanyView.swift
//  PR-GOBOU
//
//  Created by 水代謝システム工学研究室 on 2023/02/16.
//

import SwiftUI


struct FollowCompanyView: View {
    
    @ObservedObject private var getCompanyAPI:GetCompanyAPI = GetCompanyAPI()
    @State private var companies:[Company] = []
    @State private var isFollows: [Int:Bool] = [:]
    
    @Environment(\.presentationMode) var presentationMode
    
    init() {
        getCompanyAPI.getCompanyApi()
    }
    
    var body: some View {
        VStack(alignment: .leading) {
            Text("フォローする企業を選択してください")
                .font(.headline)
                .padding(.leading)
                .padding(.vertical)
            Spacer()
            List {
                ForEach(companies, id:\.self.company_id) { company in
                    HStack {
                        Button {
                            guard let id = company.company_id else { return }
                            if isFollows[id] != nil {
                                isFollows[id]?.toggle()
                            }
                            UIImpactFeedbackGenerator(style: .medium)
                                .impactOccurred()
                            saveFollowCompanyIds()
                        } label: {
                            if isFollows[company.company_id ?? 0] ?? false {
                                Image(systemName: "checkmark.square.fill")
                                    .foregroundColor(.blue)
                            } else {
                                Image(systemName: "square")
                            }
                        }
                        Text(company.company_name ?? "")
                    }
                }
            }
        }
        .onAppear(perform: {
            self.companies = getCompanyAPI.companyList
            loadFollowCompanyIds()
        })
        .listStyle(.plain)
    }
    
    private func saveFollowCompanyIds() {
        var saveIds:[Int] = []
        for company in self.companies{
            guard let id = company.company_id else { return }
            if self.isFollows[id] == true {
                saveIds.append(company.company_id!)
            }
        }
        UserDefaults.standard.set(saveIds, forKey: "followCompanyIds")
    }
    
    private func loadFollowCompanyIds() {
        let saveIds = UserDefaults.standard.array(forKey: "followCompanyIds") as? [Int] ?? []
        for company in self.companies{
            guard let id = company.company_id else { return }
            self.isFollows[id] = saveIds.contains(company.company_id!)
        }
    }
}

struct FollowCompanyView_Previews: PreviewProvider {
    static var previews: some View {
        FollowCompanyView()
    }
}
