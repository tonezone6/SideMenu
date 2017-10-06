//
//  ViewController.swift
//  SBSideMenu
//
//  Created by Alex Stratu on 06/10/2017.
//  Copyright © 2017 UDEV. All rights reserved.
//

import UIKit

class ContainerVC: UIViewController {
    
    @IBOutlet weak var sideMenuContainer: UIView!
    @IBOutlet weak var sideMenuLeadingConstraint: NSLayoutConstraint!
    
    private var isSideMenuOpen = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setSideMenuDelegates()
    }
}

extension ContainerVC: SideMenuSelectionItemDelegate {
    
    /*
     VC setup here! */
    
    func didSelectMenuItem(index: Int) {
        guard let contentNavigation = self.childViewControllers[1] as? ContentNavigation else {
            return
        }
        var vc: UIViewController!
        switch index {
        case 0:
            vc = storyboard?.instantiateViewController(withIdentifier: "FirstVC")
            vc.navigationItem.title = "First"
        case 1:
            vc = storyboard?.instantiateViewController(withIdentifier: "SecondVC")
            vc.navigationItem.title = "Second"
        case 2:
            vc = storyboard?.instantiateViewController(withIdentifier: "ThirdVC")
            vc.navigationItem.title = "Third"
        default: ()
        }
        toggleSideMenu()
        contentNavigation.viewControllers = [vc]
    }
}

extension ContainerVC: ContentNavigationDelegate {
    
    //// Toggle event
    
    func didTappedToggleButton() {
        toggleSideMenu()
    }
}

extension ContainerVC {
    
    //// Private
    
    private func setSideMenuDelegates() {
        if let sideMenuVC = self.childViewControllers[0] as? SideMenuVC {
            sideMenuVC.customDelegate = self
            
        }
        if let contentNavigation = self.childViewControllers[1] as? ContentNavigation {
            contentNavigation.customDelegate = self
        }
    }
    
    @objc private func toggleSideMenu() {
        if isSideMenuOpen {
            sideMenuLeadingConstraint.constant = -sideMenuContainer.bounds.width
        } else {
            sideMenuLeadingConstraint.constant = 0
        }
        UIView.animate(withDuration: 0.25) {
            self.view.layoutIfNeeded()
        }
        isSideMenuOpen = !isSideMenuOpen
    }
}
