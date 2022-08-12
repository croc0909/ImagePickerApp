//
//  SelectPhotoViewController.swift
//  ImagePickerApp
//
//  Created by AndyLin on 2022/8/11.
//

import UIKit
import PhotosUI

var imageCollection: Array<UIImage> = []

class SelectPhotoViewController: UIViewController ,UICollectionViewDataSource , UICollectionViewDelegate, PHPickerViewControllerDelegate  {
    
    var imageViews: [UIImageView]!
    
    @IBOutlet weak var plusButton: UIButton!
    @IBOutlet weak var imageCollectionView: UICollectionView!
    @IBOutlet weak var collectionLayout: UICollectionViewFlowLayout!
    
    
    @IBAction func plusButtonAction(_ sender: Any) {
        //開啟 PHPickerConfiguration 選擇照片
        var configuration = PHPickerConfiguration()
        // 設定選擇的檔案類型為圖片
        configuration.filter = .images
        // 設定可選擇的圖片數量
        configuration.selectionLimit = 1
        let picker = PHPickerViewController(configuration: configuration)
        picker.delegate = self
        present(picker, animated: true)
    }
    
    
    //回傳 image 數量
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return imageCollection.count
    }
    
    //設定 Cell
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "photoCell", for: indexPath) as! PhotoCell
        cell.photoCellImageView.image = imageCollection[indexPath.row]
        return cell
    }
    

    override func viewDidLoad() {
        super.viewDidLoad()
        //初始化
        self.SelectPhotoViewInit()
        // Do any additional setup after loading the view.
    }
    
    func SelectPhotoViewInit()
    {
        //取得螢幕大小
        let fullScreenSize = UIScreen.main.bounds.size
        
        // collection view 初始化
        // sectionInset: 設定 Section 間距
        collectionLayout.sectionInset = UIEdgeInsets(top:5, left: 5, bottom: 5, right: 5)
        // itemSize: 設定每個 Cell 的大小
        collectionLayout.itemSize = CGSize(width: fullScreenSize.width/3-10, height: fullScreenSize.width/3-10)
        // minmumLineSpacing: Cell 的間距
        collectionLayout.minimumLineSpacing = 5
        // scrollDirection: 滑動的方向
        collectionLayout.scrollDirection = .vertical
        // headerReferenceSize: 設定 Section Header 的大小
        collectionLayout.headerReferenceSize = CGSize(width: fullScreenSize.width, height: 24)
        
        // 按鈕初始化
        plusButton.layer.cornerRadius = plusButton.frame.height/2
        plusButton.layer.shadowOpacity = 0.4
        plusButton.layer.shadowRadius = 8
    }
    
    func picker(_ picker: PHPickerViewController, didFinishPicking results: [PHPickerResult]) {
        picker.dismiss(animated: true)

        let itemProviders = results.map(\.itemProvider)
        /*
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
         */
       
        // 選取單張寫法
        if let itemProvider = itemProviders.first,itemProvider.canLoadObject(ofClass: UIImage.self) {
            //let previousImage = self.imageViews.first?.image
            
            itemProvider.loadObject(ofClass: UIImage.self) {[weak self] (image, error) in
            DispatchQueue.main.async {
                
                guard let self = self, let image = image as? UIImage else { return }
                    //self.imageViews.first?.image = image
                
                //開啟 RetouchViewController 並把圖片傳過去
                if let retouchController = self.storyboard?.instantiateViewController(identifier: "retouchViewController", creator: { coder in
                    RetouchViewController(coder: coder, editImage: image)
                }) {
                    self.show(retouchController, sender: nil)
                }
                self.dismiss(animated: true, completion: nil)
                print("show retouchController")
              }
            }
            
        
        }
         
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
