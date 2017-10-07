//
//  SideMenuVCTableViewController.swift
//  SBSideMenu
//
//  Created by Alex Stratu on 06/10/2017.
//  Copyright © 2017 UDEV. All rights reserved.
//

import UIKit

class SideMenuCell: UITableViewCell {
    
    //// Side menu custom cell
    
    @IBOutlet weak var menuItemLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.selectionStyle = .none
    }
    
    func setCell(menuItem: String) {
        menuItemLabel.text = menuItem
    }
}

protocol SideMenuDelegate {
    /*
     Inform side menu container VC about menu item selection */
    func didSelectMenuItem(index: Int)
}

class SideMenuVC: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!

    var items = ["First", "Second", "Third"]
    var customDelegate: SideMenuDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.delegate = self
        tableView.dataSource = self
    }
}

extension SideMenuVC: UITableViewDataSource {
    
    //// Table view data source
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return items.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "SideMenuCell") as! SideMenuCell
        cell.setCell(menuItem: items[indexPath.row])
        return cell
    }
}

extension SideMenuVC: UITableViewDelegate {
    
    //// Table view delegate
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 44
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        customDelegate?.didSelectMenuItem(index: indexPath.row)
    }
}
