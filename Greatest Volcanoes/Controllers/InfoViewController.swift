//
//  InfoViewController.swift
//  Greatest Volcanoes
//
//  Created by Игорь Растегаев on 27.01.2021.
//

import UIKit

class InfoViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    
    var volcanoDataArray: [String]?
    var volcanoName: String?

    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.dataSource = self
    }

}

//MARK: - UITableViewDataSource

extension InfoViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return volcanoDataArray!.count - 3
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath[1] == 0 {
            let cell = tableView.dequeueReusableCell(withIdentifier: "HeaderCell", for: indexPath) as! TableViewCell
            cell.titleLabel.text = volcanoDataArray![indexPath[1]]
            cell.setImage(volcanoDataArray![indexPath[1] + 3])
            return cell
        } else {
            let cell = tableView.dequeueReusableCell(withIdentifier: "PrototypeCell", for: indexPath) as! TableViewCell
            cell.subtitleLabel.text = volcanoDataArray![indexPath[1] + 3]
            return cell
        }
    }
    
}

