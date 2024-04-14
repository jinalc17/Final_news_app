//
//  NewsArticle.swift
//  Jinal_Chandibhamar_FE_8961760
//
//  Created by user239775 on 4/10/24.
//

import Foundation

struct NewsArticle: Identifiable {
    let id = UUID()
    let title: String
    let description: String
    let author: String
    let source: String
}

