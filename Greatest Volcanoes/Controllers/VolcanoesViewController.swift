//
//  VolcanoesViewController.swift
//  Greatest Volcanoes
//
//  Created by Игорь Растегаев on 25.01.2021.
//

import UIKit

class VolcanoesViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    
    var jsonManager = JSONManager()
    var dataArray: [[String]] = []
    var index: Int?

    override func viewDidLoad() {
        super.viewDidLoad()

        jsonManager.delegate = self
        jsonManager.getData(with: "https://stavigor.github.io/GVvolcanoes.json")
        
        tableView.dataSource = self
        tableView.delegate = self
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        if let index = self.tableView.indexPathForSelectedRow{
            self.tableView.deselectRow(at: index, animated: true)
        }
    }

}


//MARK: - JSONManagerDelegate

extension VolcanoesViewController: JSONManagerDelegate {
    
    func didUpdateData(_ jsonManager: JSONManager, data: [[String]]) {
        DispatchQueue.main.async {
            self.dataArray = data
            self.tableView.reloadData()
        }
    }
    
}

//MARK: - UITableViewDataSource

extension VolcanoesViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "PrototypeCell", for: indexPath) as! TableViewCell
        cell.titleLabel.text = dataArray[indexPath[1]][0]
        cell.setImage(dataArray[indexPath[1]][3])
        return cell
    }
    
}

//MARK: - UITableViewDelegate

extension VolcanoesViewController: UITableViewDelegate {
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "volcanoesToInfo" {
            let destinationVC = segue.destination as! InfoViewController
            if let index = self.index {
                destinationVC.volcanoDataArray = dataArray[index]
                destinationVC.volcanoName = dataArray[index][0]
            }
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        index = indexPath[1]
        performSegue(withIdentifier: "volcanoesToInfo", sender: self)
    }
    
}
