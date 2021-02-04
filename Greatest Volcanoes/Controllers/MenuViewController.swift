//
//  MenuViewController.swift
//  Greatest Volcanoes
//
//  Created by Игорь Растегаев on 26.01.2021.
//

import UIKit

enum MenuType: Int {
    case structure
    case volcanoes
    case eruptions
    case video
    case map
    case settings
}

class MenuViewController: UITableViewController {

    var didTapMenuType: ((MenuType) -> Void)?

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    

    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let menuType = MenuType(rawValue: indexPath.row) else { return }
        dismiss(animated: true) { [weak self] in
            print("Dismissing: \(menuType)")
            self?.didTapMenuType?(menuType)
        }
    }
}
