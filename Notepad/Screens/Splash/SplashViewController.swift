//
//  SplashViewController.swift
//  Notepad
//
//  Created by SaiKiran Panuganti on 18/07/21.
//

import UIKit

class SplashViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

    }
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        loadFoldersView()
    }
    
    override func viewSafeAreaInsetsDidChange() {
        super.viewSafeAreaInsetsDidChange()
        
        let top = view.safeAreaInsets.top
        topSafeAreaHeight = top
        
        let bottom = view.safeAreaInsets.bottom
        bottomSafeAreaHeight = bottom
    }
    
    func loadFoldersView() {
        DispatchQueue.main.asyncAfter(deadline: .now()+1) {
            let controller = Controller.folders.getViewController()
            self.navigationController?.viewControllers = [controller]
            self.navigationController?.popToRootViewController(animated: true)
        }
    }
}
