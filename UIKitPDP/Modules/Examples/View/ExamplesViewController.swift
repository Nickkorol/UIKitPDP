//
//  ExamplesViewController.swift
//  UIKitPDP
//
//  Created by Nikita Korolev on 09.04.2020.
//  Copyright © 2020 Никита Королев. All rights reserved.
//

import UIKit

class ExamplesViewController: UIViewController {
    
    @IBOutlet private var tableView: UITableView!
    var viewModel: ExamplesViewModel!
    private var headers = [String]()

    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel.viewDidLoad()
    }

}

extension ExamplesViewController: ExamplesViewInput {
    func showHeaders(headers: [String]) {
        self.navigationItem.title = "UIKit"
        self.headers = headers
        tableView.reloadData()
    }
}

extension ExamplesViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return headers.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "examplesCell", for: indexPath)
        cell.textLabel?.text = headers[indexPath.row]
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        viewModel.showExample(index: indexPath.row)
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
}
