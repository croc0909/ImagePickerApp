//
//  ViewController.swift
//  ImagePickerApp
//
//  Created by AndyLin on 2022/8/10.
//

import UIKit
import PhotosUI

class ViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate, PHPickerViewControllerDelegate {

    @IBOutlet var imageViews: [UIImageView]!
    
    @IBOutlet weak var takePhotoButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }

    @IBAction func optionAction(_ sender: Any) {
        var configuration = PHPickerConfiguration()
        // 設定選擇的檔案類型為圖片
        configuration.filter = .images
        // 設定可選擇的圖片數量
        configuration.selectionLimit = 1
        let picker = PHPickerViewController(configuration: configuration)
        picker.delegate = self
        present(picker, animated: true)
        
        /*
        let alertController = UIAlertController(title: "", message: "選擇照片的方式?", preferredStyle: .actionSheet)
        let names = ["相簿", "拍照"]
        for name in names {
           let action = UIAlertAction(title: name, style: .default) { action in
              //print(action.title)
            if(action.title! ==  "相簿")
               {
                self.selectPhoto()
            }else if(action.title! ==  "拍照")
               {
                self.takePhoto()
            }
           }
            alertController.addAction(action)
        }
        let cancelAction = UIAlertAction(title: "取消", style: .cancel, handler: nil)
        alertController.addAction(cancelAction)
        present(alertController, animated: true, completion: nil)
         */
    }
    
    func picker(_ picker: PHPickerViewController, didFinishPicking results: [PHPickerResult]) {
        
        picker.dismiss(animated: true)

        let itemProviders = results.map(\.itemProvider)
        
        // 選取多張寫法
        for (i, itemProvider) in itemProviders.enumerated() where itemProvider.canLoadObject(ofClass: UIImage.self) {
           let previousImage = self.imageViews[i].image
           itemProvider.loadObject(ofClass: UIImage.self) {[weak self] (image, error) in
           DispatchQueue.main.async {
                guard let self = self, let image = image as? UIImage, self.imageViews[i].image == previousImage else { return }
                    self.imageViews[i].image = image
                   }
               }
           }
        /*
        // 選取單張寫法
        if let itemProvider = itemProviders.first,itemProvider.canLoadObject(ofClass: UIImage.self) {
            let previousImage = self.imageViews.first?.image
            itemProvider.loadObject(ofClass: UIImage.self) {[weak self] (image, error) in
            DispatchQueue.main.async {
                guard let self = self, let image = image as? UIImage, self.imageViews.first?.image == previousImage else { return }
                self.imageViews.first?.image = image
              }
            }
        }
         */
        
    }
    
 
    /*
    func selectPhoto() {
       let controller = UIImagePickerController()
       controller.sourceType = .photoLibrary
       controller.delegate = self
        //使用 present 顯示 controller
        present(controller, animated: true, completion: nil)
    }

    
    func takePhoto() {
       let controller = UIImagePickerController()
       controller.sourceType = .camera
       controller.delegate = self
        //使用 present 顯示 controller
        present(controller, animated: true, completion: nil)
        
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        
        print("select photo")
        photoImageView.image = info[.originalImage] as? UIImage
        //將 Controller 關閉
        dismiss(animated: true, completion: nil)
    }
    */
}

