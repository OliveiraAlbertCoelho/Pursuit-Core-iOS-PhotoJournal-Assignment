//
//  AddVC.swift
//  Photo-Journal-Project
//
//  Created by albert coelho oliveira on 10/3/19.
//  Copyright © 2019 albert coelho oliveira. All rights reserved.
//

import UIKit

class AddVC: UIViewController {
    var editPicture: Photo?
    var type = ""
    var userIndex = Int()
    var placeholderText = "What's on your mind?"
    var photoPicked = false
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
    func checkEditPicture(){
        if editPicture != nil{
            loadEditInfo()
            type = "Edit"
            saveButtonOut.isEnabled = true
        }
        else {
            type = "Save"
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        buttonCheckStatus()
        checkEditPicture()
        userText.delegate = self
        setUpImagePicker()
    }
    func loadEditInfo(){
        userText.text = editPicture?.userPost
        userImage.image = UIImage(data: editPicture!.image)
    }
    
    @IBAction func saveButton(_ sender: UIButton) {
        guard let imageData = self.userImage.image?.jpegData(compressionQuality: 0.5)
            else {return}
        let date = Date().description
        let photoData = Photo(userPost: userText.text, date: date, image: imageData)
        if type == "Save"{
            try?
                ImagePersistence.manager.saveImage(info: photoData)
        } else {
            try?
                ImagePersistence.manager.editImage(Int: userIndex, newElement: photoData)
        }
        dismiss(animated: true, completion: nil)
    }
    
    func buttonCheckStatus(){
        if type == "Edit"{return}
        if !userText.text.isEmpty && userText.text != placeholderText && photoPicked{
            saveButtonOut.isEnabled = true
        }else{
            saveButtonOut.isEnabled = false
            }
        }
    @IBAction func cameraAction(_ sender: UIBarButtonItem) {
        imagePickerViewController.sourceType = .camera
        imagePickerViewController.allowsEditing = true
        imagePickerViewController.delegate = self
        present(imagePickerViewController, animated: true)
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
        photoPicked = true
        buttonCheckStatus()
        dismiss(animated: true)
    }
}
extension AddVC: UITextViewDelegate{
    func textViewDidChange(_ textView: UITextView) {
        buttonCheckStatus()
    }
    func textViewDidBeginEditing(_ textView: UITextView) {
        if textView.text == placeholderText{
            textView.text = ""
        }
    }
}

