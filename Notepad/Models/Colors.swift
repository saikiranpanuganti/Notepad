//
//  Colors.swift
//  Notepad
//
//  Created by SaiKiran Panuganti on 18/07/21.
//

import UIKit

class Colors {
    static let shared: Colors = Colors()
    
    private init() {  }
    
    var redColor = #colorLiteral(red: 0.9450980392, green: 0.2431372549, blue: 0.05098039216, alpha: 1) //F13E0D
    var lightGrey = #colorLiteral(red: 0.1215686275, green: 0.1215686275, blue: 0.1294117647, alpha: 1) //1F1F21
    var searchText = #colorLiteral(red: 0.5960784314, green: 0.5960784314, blue: 0.631372549, alpha: 1) //9898A1
    var white = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1) //FFFFFF
    var folder = #colorLiteral(red: 0.2392156863, green: 0.3058823529, blue: 0.3450980392, alpha: 1) //3D4E58
}
