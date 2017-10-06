//
//  ViewController.swift
//  SBSideMenu
//
//  Created by Alex Stratu on 06/10/2017.
//  Copyright © 2017 UDEV. All rights reserved.
//

import UIKit

class SideMenuContainerVC: UIViewController {
    
    @IBOutlet weak var sideMenuContainer: UIView!
    @IBOutlet weak var sideMenuLeadingConstraint: NSLayoutConstraint!
    
    private var isSideMenuOpen = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setSideMenuDelegates()
    }
}

extension SideMenuContainerVC: SideMenuSelectionDelegate {
    
    //// Navigation setup here!
    
    func didSelectMenuItem(index: Int) {
        guard let contentNavigation = self.childViewControllers[1] as? SideMenuContentNavigation else {
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

extension SideMenuContainerVC: ContentNavigationDelegate {
    
    //// Toggle event
    
    func didTappedToggleButton() {
        toggleSideMenu()
    }
}

extension SideMenuContainerVC {
    
    //// Private
    
    private var sideMenuVC: SideMenuVC? {
        return childViewControllers[0] as? SideMenuVC
    }
    
    private var sideMenuContentNavigation: SideMenuContentNavigation? {
        return childViewControllers[1] as? SideMenuContentNavigation
    }
    
    private func setSideMenuDelegates() {
        guard let sideMenu = self.sideMenuVC, let contentNav = self.sideMenuContentNavigation else {
            return
        }
        sideMenu.customDelegate = self
        contentNav.customDelegate = self
    }
    
    @objc private func toggleSideMenu() {
        guard let contentNav = self.sideMenuContentNavigation, let rootView = contentNav.viewControllers.first?.view else { return }
        if isSideMenuOpen {
            sideMenuLeadingConstraint.constant = -sideMenuContainer.bounds.width
            rootView.isUserInteractionEnabled = true
        } else {
            sideMenuLeadingConstraint.constant = 0
            rootView.isUserInteractionEnabled = false
        }
        UIView.animate(withDuration: 0.25) {
            self.view.layoutIfNeeded()
        }
        isSideMenuOpen = !isSideMenuOpen
    }
}
