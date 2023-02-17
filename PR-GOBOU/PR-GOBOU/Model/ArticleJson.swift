//
//  Article.swift
//  PR-GOBOU
//
//  Created by 上別縄祐也 on 2023/02/16.
//

import Foundation

struct ArticleJson: Codable {
    let company_name: String?
    let company_id: Int?
    let release_id: Int?
    let title: String?
    let subtitle: String?
    let url: String?
    let leadParagraph: Int?
    let body: String?
    let main_image: String?
    let mainImageFastly: String?
    let mainCategoryId: Int?
    let mainCategoryName: String?
    let subCategoryId: Int?
    let subCategoryName: String?
    let prType: String?
    let created_at: String?
}
