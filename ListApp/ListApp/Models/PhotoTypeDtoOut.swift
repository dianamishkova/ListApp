//
//  PhotoTypeDtoOut.swift
//  testAPI
//
//  Created by Диана Мишкова on 19.10.24.
//

import Foundation

struct PhotoTypeDtoOut: Codable, Hashable {
    let id: Int32
    let name: String
    let image: String?
}
