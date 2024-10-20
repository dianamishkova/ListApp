//
//  PagePhotoTypeDtoOut.swift
//  testAPI
//
//  Created by Диана Мишкова on 19.10.24.
//

import Foundation

struct PagePhotoTypeDtoOut: Codable {
    let content: [PhotoTypeDtoOut]
    let page: Int32
    let pageSize: Int32
    let totalElements: Int64
    let totalPages: Int32
}
