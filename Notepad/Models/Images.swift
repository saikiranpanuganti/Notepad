//
//  Images.swift
//  Notepad
//
//  Created by SaiKiran Panuganti on 18/07/21.
//

import UIKit

class Images {
    static let shared: Images = Images()
    
    private init() {  }
    
    var back = UIImage(systemName: "chevron.backward")
    var plus = UIImage(systemName: "plus")
    var scope = UIImage(systemName: "magnifyingglass")
}
