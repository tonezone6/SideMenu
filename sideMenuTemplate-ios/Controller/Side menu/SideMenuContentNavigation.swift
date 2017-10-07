//
//  ContentNavigationVC.swift
//  SBSideMenu
//
//  Created by Alex Stratu on 06/10/2017.
//  Copyright © 2017 UDEV. All rights reserved.
//

import UIKit

protocol SideMenuNavigationDelegate {
    func didTappedToggleButton()
}

class SideMenuContentNavigation: UINavigationController {
    
    var customDelegate: SideMenuNavigationDelegate?

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.removeBarShadow()
        self.delegate = self
    }
}

extension SideMenuContentNavigation: UINavigationControllerDelegate {
    
    //// Navigation stack controller setup
    
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
        
        // Set vc navigation item title based on storyboard value
        if let title = viewController.title {
            viewController.navigationItem.title = title
        }
    }
    
    @objc func buttonAction() {
        customDelegate?.didTappedToggleButton()
    }
    
    private func removeBarShadow() {
        navigationBar.setBackgroundImage(UIImage(), for: .default)
        navigationBar.shadowImage = UIImage()
    }
}
