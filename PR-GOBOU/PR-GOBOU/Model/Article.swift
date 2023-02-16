//
//  Article.swift
//  PR-GOBOU
//
//  Created by 上別縄祐也 on 2023/02/16.
//

import Foundation

struct Article: Codable {
    let companyName: String?
    let companyId: Int?
    let releaseId: Int?
    let title: String?
    let subtitle: String?
    let url: String?
    let leadParagraph: Int?
    let body: String?
    let mainImage: String?
    let mainImageFastly: String?
    let mainCategoryId: Int?
    let mainCategoryName: String?
    let subCategoryId: Int?
    let subCategoryName: String?
    let prType: String?
    let createdAt: String?
}
