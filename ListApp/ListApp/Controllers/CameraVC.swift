//
//  CameraVC.swift
//  ListApp
//
//  Created by Диана Мишкова on 20.10.24.
//

import UIKit

class CameraVC: UIImagePickerController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {

    var typeId: Int32 = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()      
    }
    
    func configure() {
        sourceType = .camera
        allowsEditing = true
        delegate = self
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        
        picker.dismiss(animated: true)

        guard let image = info[.editedImage] as? UIImage else {            
            return
        }
        guard let imageData = image.jpegData(compressionQuality: 0.8) else {
            return
        }
        let photoToPost = Photo(typeId: typeId, name: "MishkovaDV", imageData: imageData)
        postItem(photo: photoToPost)
    }
    
    
    private func postItem(photo: Photo) {
        NetworkManager.shared.postItem(photo: photo) { result in
            switch result {
            case .success(let item):
                print(item.id)
            case .failure(let error):
                print(error.rawValue)
            }
        }
    }

}
