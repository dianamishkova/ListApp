//
//  NetworkigService.swift
//  testAPI
//
//  Created by Диана Мишкова on 19.10.24.
//

import Foundation

typealias getItemsListAPIResponse = (Swift.Result<PagePhotoTypeDtoOut, DataError>) -> Void
typealias getItemAPIResponse = (Swift.Result<PhotoDtoOut, DataError>) -> Void

protocol NetworkManagerProtocol {
    func getItems(page: Int, completion: @escaping getItemsListAPIResponse)
    func postItem(photo: Photo, completion: @escaping getItemAPIResponse)
}
