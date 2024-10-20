//
//  DataError.swift
//  testAPI
//
//  Created by Диана Мишкова on 19.10.24.
//

import Foundation

enum DataError: String, Error {
    case invalidURL = "Invalid url"
    case networkError = "Network error"
    case invalidResponse = "Invalid response"
    case invalidData = "Invalid data"
    case parsingError = "Parsing error"
}
