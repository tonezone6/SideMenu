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
        
        sideMenuVC.customDelegate = self
        sideMenuContentNavigation.customDelegate = self
    }
}

extension SideMenuContainerVC: SideMenuDelegate {
    
    func didSelectMenuItem(index: Int) {
        var vc: UIViewController!
        /*
         These are test vc.
         Setup your content view controllers and manage side menu selection below: */
        switch index {
        case 0: vc = storyboard?.instantiateViewController(withIdentifier: "FirstVC")
        case 1: vc = storyboard?.instantiateViewController(withIdentifier: "SecondVC")
        case 2: vc = storyboard?.instantiateViewController(withIdentifier: "ThirdVC")
        default: ()
        }
        toggleSideMenu()
        sideMenuContentNavigation.viewControllers = [vc]
    }
}

extension SideMenuContainerVC: SideMenuNavigationDelegate {
    
    //// Toggle event
    
    func didTappedToggleButton() {
        toggleSideMenu()
    }
}

extension SideMenuContainerVC {
    
    //// Private
    
    private var sideMenuVC: SideMenuVC {
        return childViewControllers[0] as! SideMenuVC
    }
    private var sideMenuContentNavigation: SideMenuContentNavigation {
        return childViewControllers[1] as! SideMenuContentNavigation
    }
    
    @objc private func toggleSideMenu() {
        guard let rootView = sideMenuContentNavigation.viewControllers.first?.view else { return }
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
