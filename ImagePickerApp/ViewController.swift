//
//  ViewController.swift
//  ImagePickerApp
//
//  Created by AndyLin on 2022/8/10.
//

import UIKit

class ViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {

    @IBOutlet weak var takePhotoButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }

    @IBAction func optionAction(_ sender: Any) {
        let controller = UIAlertController(title: "", message: "選擇照片的方式?", preferredStyle: .actionSheet)
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
           controller.addAction(action)
        }
        let cancelAction = UIAlertAction(title: "取消", style: .cancel, handler: nil)
        controller.addAction(cancelAction)
        present(controller, animated: true, completion: nil)
    }
    
    
    func selectPhoto() {
       let controller = UIImagePickerController()
       controller.sourceType = .photoLibrary
       controller.delegate = self
    }

    
    func takePhoto() {
       let controller = UIImagePickerController()
        controller.sourceType = .camera
       controller.delegate = self
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
       let image = info[.originalImage] as? UIImage
    }
}

