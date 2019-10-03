//
//  AddVC.swift
//  Photo-Journal-Project
//
//  Created by albert coelho oliveira on 10/3/19.
//  Copyright © 2019 albert coelho oliveira. All rights reserved.
//

import UIKit

class AddVC: UIViewController {
    
    @IBOutlet weak var saveButtonOut: UIButton!
    @IBOutlet weak var userText: UITextView!
    @IBOutlet weak var userImage: UIImageView!
    private var imagePickerViewController: UIImagePickerController!
    @IBAction func libraryAction(_ sender: UIBarButtonItem) {
imagePickerViewController.sourceType = .photoLibrary
present(imagePickerViewController, animated: true, completion: nil)
    }
    private func setUpImagePicker() {
         imagePickerViewController = UIImagePickerController()
        imagePickerViewController.delegate = self
         
     }
    override func viewDidLoad() {
    super.viewDidLoad()
        userText.delegate = self
    setUpImagePicker()
        buttonCheckStatus()
    }
    
    @IBAction func saveButton(_ sender: UIButton) {
           guard let imageData = self.userImage.image?.jpegData(compressionQuality: 0.5)
                        else {return}
        let date = Date.init().description
        let photoData = Photo(userPost: userText.text, date: date, image: imageData)
                    try?
        ImagePersistence.manager.saveImage(info: photoData)
        print(photoData)
                }
    func buttonCheckStatus(){
        if !userText.text.isEmpty && userImage.image != nil{
            saveButtonOut.isEnabled = true
        } else {
            saveButtonOut.isEnabled = false
               }
    }
    
    @IBAction func cancelButtonAction(_ sender: UIButton) {
        dismiss(animated: true, completion: nil)
    }
    
}
extension AddVC: UIImagePickerControllerDelegate, UINavigationControllerDelegate{
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        if let image = info[.originalImage] as? UIImage{
            userImage.image = image
        }else {print("no image")}
        dismiss(animated: true)
    }
}
        
extension AddVC: UITextViewDelegate{
    func textViewDidChange(_ textView: UITextView) {
    buttonCheckStatus()
    }
}
