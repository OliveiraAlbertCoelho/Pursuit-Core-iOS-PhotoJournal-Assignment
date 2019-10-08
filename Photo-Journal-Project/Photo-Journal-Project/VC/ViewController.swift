//
//  ViewController.swift
//  Photo-Journal-Project
//
//  Created by albert coelho oliveira on 10/3/19.
//  Copyright © 2019 albert coelho oliveira. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    var scrollDirec = Int()
    var DarkModeId = Int()
    var photos = [Photo](){
        didSet{
            photoCollection.reloadData()
        }
    }
    
    @IBAction func settingButton(_ sender: UIBarButtonItem) {
        let storyBoard = UIStoryboard.init(name: "Main", bundle: nil)
        let setVC = storyBoard.instantiateViewController(identifier: "settings") as! SettingsVC
        setVC.delegate = self
        setVC.darkDelegate = self
        setVC.darkModeInt = DarkModeId
        setVC.selectedScroll = scrollDirec
        setVC.modalPresentationStyle = .currentContext
        self.present(setVC, animated: true, completion: nil)
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
        if DarkModeId == 1{
            cell.backgroundColor = UIColor.black
            cell.labelName.textColor = UIColor.white
            cell.dateText.textColor = UIColor.white
        }else {
            cell.backgroundColor = UIColor.white
            cell.labelName.textColor = UIColor.black
            cell.dateText.textColor = UIColor.black
        }
        cell.labelName.text = data.userPost
        cell.dateText.text = data.dateFormat
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
        let shareAction = UIAlertAction.init(title: "Share", style: .default) {
            (action) in
            let sharingActivity = UIActivityViewController(activityItems: [self.photos[tag].image, self.photos[tag].userPost], applicationActivities: nil)
            self.present(sharingActivity, animated: true, completion: nil)
        }
        let cancelAction = UIAlertAction.init(title: "Cancel", style: .cancel, handler: nil)
        
        optionsMenu.addAction(editAction)
        optionsMenu.addAction(shareAction)
        optionsMenu.addAction(deleteAction)
        optionsMenu.addAction(cancelAction)
        
        present(optionsMenu, animated: true, completion: nil)
    }
}
extension ViewController: PhotoDelegate{
    func passData(tag: Int) {
        print(tag)
        scrollDirec = tag
        if let layout = photoCollection.collectionViewLayout as? UICollectionViewFlowLayout {
            if tag == 0 {
                layout.scrollDirection = .vertical
            }else { layout.scrollDirection = .horizontal
            }
        }
        photoCollection.reloadData()
    }
}
extension ViewController: darkProtocol{
    func passDarkModeData(tag: Int) {
        DarkModeId = tag
        if tag == 0{
            view.backgroundColor = .white
        }else {
            view.backgroundColor = .black
        }
    }
    
}
