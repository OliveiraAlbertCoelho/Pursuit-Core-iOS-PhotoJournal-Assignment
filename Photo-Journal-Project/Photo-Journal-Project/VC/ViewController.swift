//
//  ViewController.swift
//  Photo-Journal-Project
//
//  Created by albert coelho oliveira on 10/3/19.
//  Copyright © 2019 albert coelho oliveira. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    var photos = [Photo](){
        didSet{
            photoCollection.reloadData()
        }
    }
    @IBOutlet weak var photoCollection: UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        photoCollection.delegate = self
        photoCollection.dataSource = self
       loadUserData()
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        loadUserData()
    }
  private func loadUserData(){
        do {
            photos = try ImagePersistence.manager.getImage()
        }catch{
            print(error)
        }
    }
}
extension ViewController: UICollectionViewDelegate, UICollectionViewDataSource{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return photos.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = photoCollection.dequeueReusableCell(withReuseIdentifier: "photoCell", for: indexPath) as! PhotoViewCell
        let data = photos[indexPath.row]
        cell.labelName.text = data.userPost
        cell.dateText.text = data.date
        cell.delegate = self
        cell.buttonOut.tag = indexPath.row
        cell.photoCell.image = UIImage(data: data.image)
        return cell
    }
}
extension ViewController: ButtonFunction{
    func showActionSheet(tag: Int) {
        let optionsMenu = UIAlertController.init(title: "Options", message: "Pick an Option", preferredStyle: .actionSheet)
        let deleteAction = UIAlertAction.init(title: "Delete", style: .destructive) { (action) in
            do{
            try ImagePersistence.manager.deleteImage(Int: tag)
                self.loadUserData()
            }catch{
                print(error)
            }
        }
        let editAction = UIAlertAction.init(title: "Edit", style: .default) { (action) in
            let pic =  self.photos[tag]
            let storyBoard = UIStoryboard.init(name: "Main", bundle: nil)
            let editVC = storyBoard.instantiateViewController(identifier: "AddVC") as! AddVC
            editVC.editPicture = pic
            editVC.userIndex = tag
            editVC.modalPresentationStyle = .currentContext
            self.present(editVC, animated: true, completion: nil)
        }
        let cancelAction = UIAlertAction.init(title: "Cancel", style: .cancel, handler: nil)
        optionsMenu.addAction(deleteAction)
        optionsMenu.addAction(editAction)
        optionsMenu.addAction(cancelAction)
        present(optionsMenu, animated: true, completion: nil)
    }
}
