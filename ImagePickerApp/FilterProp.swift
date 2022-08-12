//
//  FilterProp.swift
//  ImagePickerApp
//
//  Created by AndyLin on 2022/8/12.
//

import Foundation

class FilterProp {
    let type: ColorControlMode
    let defaultValue: Float
    var value: Float
    
    init(type: ColorControlMode,
         defaultValue: Float,
         value: Float) {
        self.type = type
        self.defaultValue = defaultValue
        self.value = value
    }
}
