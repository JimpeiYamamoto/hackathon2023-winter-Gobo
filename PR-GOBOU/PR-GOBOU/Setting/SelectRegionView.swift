//
//  SelectRegionView.swift
//  PR-GOBOU
//
//  Created by 水代謝システム工学研究室 on 2023/02/16.
//

import SwiftUI

struct SelectRegionView: View {

    @ObservedObject var getRegionAPI:GetRegionAPI = GetRegionAPI()
    @State var regions: [Region] = []
    @Environment(\.presentationMode) var presentationMode
    @State var userRegionId: Int? = nil
    
    init() {
        getRegionAPI.getRegionApi()
    }

    var body: some View {
        VStack(alignment: .leading) {
            Text("あなたの居住地を選択してください")
                .font(.headline)
                .padding(.leading)
                .padding(.top)
            List {
                ForEach(self.regions, id: \.self.id) { region in
                    Button {
                        saveRegionId(id: region.id)
                        presentationMode.wrappedValue.dismiss()
                    } label: {
                        HStack {
                            Text(region.name ?? "")
                                .padding(.leading)
                            Spacer()
                            if region.id == self.userRegionId {
                                Image(systemName: "checkmark")
                                    .padding(.trailing)
                                    .foregroundColor(.blue)
                            }
                        }
                    }
                }
            }
            .listStyle(.plain)
        }
        .onAppear {
            self.regions = getRegionAPI.regionList
            self.userRegionId = UserDefaults.standard.integer(forKey: "regionId")
        }
    }
    
    func saveRegionId(id: Int?) {
        UserDefaults.standard.set(id, forKey: "regionId")
    }
}

struct SelectRegionView_Previews: PreviewProvider {
    static var previews: some View {
        SelectRegionView()
    }
}
