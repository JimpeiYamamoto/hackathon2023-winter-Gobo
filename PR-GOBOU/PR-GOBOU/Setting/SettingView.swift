//
//  FollowCompanyView.swift
//  PR-GOBOU
//
//  Created by 水代謝システム工学研究室 on 2023/02/16.
//

import SwiftUI


struct SettingView: View {
    
    @ObservedObject private var getCompanyAPI:GetCompanyAPI = GetCompanyAPI()
    @State private var companies:[Company] = []
    @State private var isFollows: [Int:Bool] = [:]
    @ObservedObject private var getRegionAPI:GetRegionAPI = GetRegionAPI()
    @State private var regions: [Region] = []
    @State private var myRegion: String = "未設定"
    
    @Environment(\.dismiss) var dismiss
    
    init() {
        getCompanyAPI.getCompanyApi()
        getRegionAPI.getRegionApi()
    }
    
    var body: some View {
        List {
            Section("居住地") {
                NavigationLink {
                    SelectRegionView()
                } label: {
                    Text(myRegion)
                }

            }
            Section("フォロー企業") {
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
        .navigationBarBackButtonHidden(true)
        .toolbar {
            ToolbarItem(placement: .navigationBarLeading) {
                Button(action: {
                    dismiss()
                }) {
                    HStack {
                        Image(systemName: "chevron.backward")
                            .font(.system(size: 17, weight: .medium))
                        Text("戻る")
                    }
                    .foregroundColor(.white)
                }
            }
        }
        .onAppear(perform: {
            self.regions = getRegionAPI.regionList
            self.myRegion = searchMyRegion()
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
    
    private func searchMyRegion() -> String {
        guard let saveId = UserDefaults.standard.object(forKey: "regionId") as? Int ?? nil else { return "未設定" }
        for region in self.regions {
            if saveId == region.id {
                guard let name = region.name else { return "未設定"}
                return name
            }
        }
        return "未設定"
    }
}

struct FollowCompanyView_Previews: PreviewProvider {
    static var previews: some View {
        SettingView()
    }
}
