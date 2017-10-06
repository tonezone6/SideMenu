//
//  ContentNavigationVC.swift
//  SBSideMenu
//
//  Created by Alex Stratu on 06/10/2017.
//  Copyright © 2017 UDEV. All rights reserved.
//

import UIKit

protocol ContentNavigationDelegate {
    func didTappedToggleButton()
}

class ContentNavigation: UINavigationController {
    
    var customDelegate: ContentNavigationDelegate?

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.delegate = self
    }
}

extension ContentNavigation: UINavigationControllerDelegate {
    
    func navigationController(_ navigationController: UINavigationController, willShow viewController: UIViewController, animated: Bool) {
        
        // Side menu btn
        let btn = UIBarButtonItem(title: "More", style: .plain, target: self, action: #selector(buttonAction))
        viewController.navigationItem.setLeftBarButton(btn, animated: false)
        
        // Hide back btn text
        let item = UIBarButtonItem(title: " ", style: .plain, target: nil, action: nil)
        viewController.navigationItem.backBarButtonItem = item
        
        // Hide side menu btn in nav stack
        if let index = viewControllers.index(of: viewController), index > 0 {
            viewController.navigationItem.leftBarButtonItem = nil
        }
    }
    
    @objc func buttonAction() {
        customDelegate?.didTappedToggleButton()
    }
}
