//
//  EruptionViewController.swift
//  Greatest Volcanoes
//
//  Created by Игорь Растегаев on 27.01.2021.
//

import UIKit

class EruptionViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    
    var jsonManager = JSONManager()
    var dataArray: [[String]] = []

    override func viewDidLoad() {
        super.viewDidLoad()
        
        jsonManager.delegate = self
        jsonManager.getData(with: "https://stavigor.github.io/GVeruptions.json")

        tableView.dataSource = self
    }
    

}

//MARK: - JSONManagerDelegate

extension EruptionViewController: JSONManagerDelegate {
    
    func didUpdateData(_ jsonManager: JSONManager, data: [[String]]) {
        DispatchQueue.main.async {
            self.dataArray = data
            self.tableView.reloadData()
        }
    }
    
}

//MARK: - UITableViewDataSource

extension EruptionViewController: UITableViewDataSource {

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "HeaderCell", for: indexPath) as! TableViewCell
        cell.setImage(dataArray[indexPath.row][0])
        cell.titleLabel.text = dataArray[indexPath.row][1]
        cell.subtitleLabel.text = dataArray[indexPath.row][2]
        return cell
    }

}
 

