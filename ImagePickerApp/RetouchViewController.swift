//
//  RetouchViewController.swift
//  ImagePickerApp
//
//  Created by AndyLin on 2022/8/11.
//

import UIKit

enum Mode {
    case rotateMirror, crop, colorControl, photoEffect, textEdit
}
//顏色模式
enum ColorControlMode {
    case brightness, contrast, saturation
}

// 目前的操作模式
var currentMode: Mode = .rotateMirror
// 目前的顏色控制模式
var currentColorControlMode: ColorControlMode = .brightness

class RetouchViewController: UIViewController {
    
    // 要編輯的圖片
    var editImage: UIImage
    
    var editImageView: EditImageUIView?
    
    // 初始化
    init?(coder: NSCoder, editImage: UIImage) {
        self.editImage = editImage
        super.init(coder: coder)
    }
    
    // 初始化失敗時
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.retouchViewInit()
        // Do any additional setup after loading the view.
    }
    
    // RetouchView 畫面初始設定
    func retouchViewInit(){
        //取得螢幕長寬
        let screenW = UIScreen.main.bounds.width
        let screenH = UIScreen.main.bounds.height
        // 將圖片加入到 View 中
        editImageView = EditImageUIView(frame: CGRect(x: 0, y: (screenH-screenW)/2, width: screenW, height: screenW), editImage: editImage)!
        view.addSubview(editImageView!)
        
        self.refreshViews()
        
        
    }
    
    @objc func refreshViews() {
        //setModeIcon()
        //setColorControlSub()
        //setTextEditSub()
    }
    
    @IBAction func rotateRight(_ sender: Any) {
        editImageView?.rotate(isPositiveDegree: true)
    }
    
    @IBAction func rotateLeft(_ sender: Any) {
        editImageView?.rotate(isPositiveDegree: false)
    }
    
    @IBAction func mirror(_ sender: Any) {
        editImageView?.mirror()
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
