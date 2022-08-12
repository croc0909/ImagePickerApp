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
    
    @IBOutlet weak var cancelButton: UIButton!
    @IBOutlet weak var saveButton: UIButton!
    @IBOutlet weak var leftButton: UIButton!
    @IBOutlet weak var rightButton: UIButton!
    @IBOutlet weak var mirrorButton: UIButton!
    @IBOutlet weak var rotateModeButton: UIButton!
    @IBOutlet weak var cropModeButton: UIButton!
    
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
        
        cancelButton.layer.cornerRadius = 10
        saveButton.layer.cornerRadius = 10
        leftButton.layer.cornerRadius = 10
        rightButton.layer.cornerRadius = 10
        mirrorButton.layer.cornerRadius = 10
        rotateModeButton.layer.cornerRadius = 10
        cropModeButton.layer.cornerRadius = 10
    }
    
    @objc func refreshViews() {
        //setModeIcon()
        //setColorControlSub()
        //setTextEditSub()
    }
    
    func setModeIcon() {
        /*
        // icon 淡色
        modeStackView.subviews.forEach {
            ($0 as! UIButton).alpha = 0.3
        }
         */
        /*
        // 收回次功能
        setSubFeatureViewConstraint(tragetConstraint: rotateMirrorBottom, value: -56)
        setSubFeatureViewConstraint(tragetConstraint: colorControlBottom, value: -140)
        setSubFeatureViewOrigin(targetView: effectScrollView, value: 800)
        setSubFeatureViewConstraint(tragetConstraint: textFieldBottom, value: -104)
         */
        /*
        // 取消文字編輯
        if let textField = editImageView!.textField {
            textField.isEnabled = false
        }
        */
        
        if currentMode == .rotateMirror {
            /*
            setIconActive(stackView: modeStackView, index: 0)
            setSubFeatureViewConstraint(tragetConstraint: rotateMirrorBottom, value: 0)
             */
        } else if currentMode == .crop {
            /*
             setIconActive(stackView: modeStackView, index: 1)
             */
        } else if currentMode == .colorControl {
            /*
             setIconActive(stackView: modeStackView, index: 2)
            setSubFeatureViewConstraint(tragetConstraint: colorControlBottom, value: 0)
            setColorControlSub()
             */
        } else if currentMode == .photoEffect {
            /*
             setIconActive(stackView: modeStackView, index: 3)
            setSubFeatureViewOrigin(targetView: effectScrollView, value: 694)
             */
        } else if currentMode == .textEdit {
            /*
             setIconActive(stackView: modeStackView, index: 4)
            setSubFeatureViewConstraint(tragetConstraint: textFieldBottom, value: 0)
            setTextEditSub()
            if let textField = editImageView!.textField {
                textField.isEnabled = true
            }
             */
        }
    }
    
    @IBAction func saveAction(_ sender: Any) {
        let renderer = UIGraphicsImageRenderer(size: editImageView!.bounds.size)
        let image = renderer.image(actions: { (context) in
            editImageView!.drawHierarchy(in: editImageView!.bounds, afterScreenUpdates: true)
        })
        imageCollection.append(image)
        navigationController?.popToRootViewController(animated: true)
        print("imageCollection \(imageCollection.count)")
    }
    
    @IBAction func cancelAction(_ sender: Any) {
        editImageView?.editInitialize()
    }
    
    
    // 向右旋轉 Action
    @IBAction func rotateRight(_ sender: Any) {
        editImageView?.rotate(isPositiveDegree: true)
    }
    // 向左旋轉 Action
    @IBAction func rotateLeft(_ sender: Any) {
        editImageView?.rotate(isPositiveDegree: false)
    }
    // 鏡像 Action
    @IBAction func mirror(_ sender: Any) {
        editImageView?.mirror()
    }
    
    // 圖片 旋轉模式
    @IBAction func setRotateMirrorMode(_ sender: Any) {
        guard currentMode != .rotateMirror else {
            return
        }
        currentMode = .rotateMirror
        //setModeIcon()
    }
    
    // 圖片 裁切模式
    @IBAction func setCropMode(_ sender: Any) {
        guard currentMode != .crop else {
            return
        }
        currentMode = .crop
        //setModeIcon()
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
