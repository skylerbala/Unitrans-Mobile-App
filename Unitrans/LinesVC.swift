//
//  LinesVCTableViewController.swift
//  Unitrans
//
//  Created by Skyler Bala on 8/21/18.
//  Copyright © 2018 SkylerBala. All rights reserved.
//

import UIKit

protocol LinesDisplayDelegate {
    func updateLinesDisplay(lines: [Line])
}

class LinesVC: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    var tableView: UITableView!
    var lines: [Line]!
    var linesDisplayDelegate: LinesDisplayDelegate!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configTableView()
        setViews()
        
        tableView.reloadData()
    }

    
    
    func configTableView() {
        tableView = UITableView()
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "myCell")
        tableView.dataSource = self
        tableView.delegate = self
    }
    
    func setViews() {
        view.addSubview(tableView)
        
        tableView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            tableView.rightAnchor.constraint(equalTo: view.rightAnchor),
            tableView.leftAnchor.constraint(equalTo: view.leftAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            tableView.topAnchor.constraint(equalTo: view.topAnchor, constant: topbarHeight)
        ])
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return lines.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "myCell", for: indexPath)
        cell.textLabel?.text = lines[indexPath.row].lineTitle
        
        if lines[indexPath.row].isDisplayed {
            cell.accessoryType = .checkmark
        }
        else {
            cell.accessoryType = .none
        }

        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        if let cell = tableView.cellForRow(at: indexPath) {
            if cell.accessoryType == .checkmark {
                cell.accessoryType = .none
                lines[indexPath.row].isDisplayed = false
                linesDisplayDelegate.updateLinesDisplay(lines: self.lines)
            }
            else {
                cell.accessoryType = .checkmark
                lines[indexPath.row].isDisplayed = true
                linesDisplayDelegate.updateLinesDisplay(lines: self.lines)
            }
        }
    }
    
}
