//
//  LoginController+handlers.swift
//  RealTimeChatApp
//
//  Created by 123 on 13.07.17.
//  Copyright © 2017 taras team. All rights reserved.
//

import UIKit
import FirebaseAuth
import FirebaseDatabase
import FirebaseStorage

extension LoginController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    func handleSelectProfileImageView() {
        let piker = UIImagePickerController()
        piker.delegate = self
        piker.allowsEditing = true
        present(piker, animated: true, completion: nil)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        
        var selectedImageFromPiker: UIImage?
        
        if let editedImage = info["UIImagePickerControllerEditedImage"] as? UIImage {
            selectedImageFromPiker = editedImage
            
        } else if let originalImage = info["UIImagePickerControllerOriginalImage"] as? UIImage{
            selectedImageFromPiker = originalImage
        }
        
        if let selectedImage = selectedImageFromPiker {
            profileImageView.image = selectedImage
        }
        dismiss(animated: true, completion: nil)
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        print(123)
        dismiss(animated: true, completion: nil)
        
    }
    
    func handleRegister() {
        guard let name = nameTextField.text else { return }
        guard let email = emailTextField.text else { return }
        guard let password = passwordTextField.text else { return }
        FIRAuth.auth()?.createUser(withEmail: email, password: password, completion: { (user, error) in
            if error != nil {
                print(error)
                return
            }
            
            guard let uid = user?.uid else { return }
            
            let imageName = UUID().uuidString
            
            if let uploadData = UIImagePNGRepresentation(self.profileImageView.image!) {
                
                FIRStorage.storage().reference().child("profileImages").child(imageName.appending(".png")).put(uploadData, metadata: nil, completion: { (metadata, error) in
                    if error != nil {
                        print(error)
                        return
                    }
                    
                    guard let imageUrl = metadata?.downloadURL()?.absoluteString else { return }
                    
                    let values = ["name": name, "email": email, "profileImageUrl": imageUrl]
                    
                    self.registerUserIntoDatabase(uid: uid, values: values)
                })
                
            }
        })
    }
    
    private func registerUserIntoDatabase(uid: String, values: [String: Any]) {
    FIRDatabase.database().reference().child("users").child(uid).updateChildValues(values, withCompletionBlock: { (error, ref) in
            if error != nil {
                print(error)
            }
            print(" user created")
            
            self.dismiss(animated: true, completion: nil)
        })
    }
}
