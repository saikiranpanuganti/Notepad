//
//  SplashViewController.swift
//  Notepad
//
//  Created by SaiKiran Panuganti on 18/07/21.
//

import UIKit

class SplashViewController: UIViewController {
    var splashModel: SplashModel = SplashModel()

    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        splashModel.getFolders()
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
        DispatchQueue.main.async { [weak self] in
            guard let strongSelf = self else { return }
            if let controller = Controller.folders.getViewController() as? FoldersViewController {
                controller.foldersModel.folders = strongSelf.splashModel.folders
                strongSelf.navigationController?.viewControllers = [controller]
                strongSelf.navigationController?.popToRootViewController(animated: true)
            }
        }
    }
}
