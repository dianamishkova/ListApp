//
//  Photo.swift
//  ListApp
//
//  Created by Диана Мишкова on 19.10.24.
//

import UIKit

struct Photo: Encodable {
    let typeId: Int32
    let name: String
    let imageData: Data
    let filename: String = UUID().uuidString
}
