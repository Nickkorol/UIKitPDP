//
//  ClosingSwipeViewController.swift
//  UIKitPDP
//
//  Created by Nikita Korolev on 09.04.2020.
//  Copyright © 2020 Никита Королев. All rights reserved.
//

import UIKit

class ClosingSwipeViewController: UIViewController {
    @IBOutlet weak var tableView: UITableView!
    
    var viewModel: ClosingSwipeViewModel!
    var elements = [String]()

    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.title = "Closing swipe"
    }

    @IBAction func addButtonTapped(_ sender: UIBarButtonItem) {
        viewModel.addNote()
    }
}

extension ClosingSwipeViewController: ClosingSwipeViewInput {
    func configure(elements: [String]) {
        self.elements = elements
        tableView.reloadData()
    }
}

extension ClosingSwipeViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return elements.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "closingSwipeCell", for: indexPath)
        cell.textLabel?.text = elements[indexPath.row]
        return cell
    }
}
