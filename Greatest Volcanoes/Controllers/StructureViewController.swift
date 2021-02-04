//
//  InfoViewController.swift
//  Greatest Volcanoes
//
//  Created by Игорь Растегаев on 25.01.2021.
//

import UIKit

class StructureViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    
    let dataArray = [
        ["Craters and calderas", "Formation of craters: Krakatoa", "Crater Lake, Oregon, USA", "Living with volcanoes"],
        ["Many volcanoes contain a depression. Small depressions (i.e. less than 1 km across) are called craters whereas those over 1 km across are called calderas. Most craters result from the explosive activity by which the volcanic vent is cleared. However, most calderas result from subsidence produced by the removal of large volumes of the underlying magma. Many present-day craters and calderas are filled with water, and are know as crater lakes.", "The Krakatoa volcano in Indonesia erupted violently in 1883. Prior to the stupendous eruption, the Krakatoa island group consisted of one large and two smaller volcanic islands lying around and within a prehistoric caldera. The 1883 eruption resulted in the removal of two of the three volcanic cones which made up Krakatoa Island and the area between the three remaining remnant islands was filled by the sea to a depth of 250 m. The eruptions began in May of 1883 with small explosions and built up in activity. The largest eruption (among the largest ever witnessed by people) occurred between 26 - 27 August 1883 and could be heard from a distance of 1000 km away. Tsunamis over 40 m in height killed 36 000 people on the islands of Java and Sumatra. The clouds of ash expelled were so dense that Jakarta (some 160 km away) was in total darkness by midday 27 August 1883. The eruption cloud rose to a height of over 80 km and fell over an area of 800 000 km2. Large (i.e. over 0.5 m across) fragments fell over an area of 100 km2. Because of the large volume of ash sent the atmosphere by this eruption, the entire world experienced unusually cold weather for the next few years, as the ash helped to black out the sun's rays. Probably over 20 km3 of rock were ejected in this eruption, most of it being dacitic pumice from the exploding magma, as well as rock fragments from the former old volcanic cones which were blasted in the eruption.", "Crater Lake in Oregon, USA, is a large caldera some 10 km across and more than 1.2 km deep which formed about 7000 years ago after the collapse of a pre-existing andesitic cone known as Mount Mazama. The pyroclastic (chunks of igneous rock ejected from a volcano) deposits from this eruption are spread over a wide area of Oregon and neighbouring states. The deposits of airborne pumice and basaltic scoria had a volume of about 75 km3, of which some 30 km3 represents formerly liquid magma. The volcano collapsed as the vast amounts of magma erupted from the underlying chamber. Water filled the caldera over time, leading to the present crater lake. The Wizard Islands within this lake are probably younger cones.", "Spectacular eruptions from volcanoes have fascinated humans ever since people first walked on the Earth. In fact, some of the earliest known hominids (Australopithecus afarensis) used lava fields as protective refuges from wild animals. Today, over 400 million people on Earth live within reach of volcanic eruptions, with many of them either dwelling or growing crops on the flanks of dormant and active volcanoes."]]
    
    let transiton = SlideInTransition()
    var topView: UIView?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        tableView.dataSource = self
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        if Core.shared.isNewUser() {
            // show onboarding
            if #available(iOS 13.0, *) {
                let vc = UIStoryboard(name: "Onboarding", bundle: nil).instantiateViewController(identifier: "welcome")
                vc.modalPresentationStyle = .fullScreen
                present(vc, animated: true)
            } else {
                // Fallback on earlier versions
            }
        }
    }
    

}



//MARK: - UITableViewDataSource

extension StructureViewController: UITableViewDataSource {

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataArray[0].count + 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.row == 0 {
            let cell = tableView.dequeueReusableCell(withIdentifier: "HeaderCell", for: indexPath) as! TableViewCell
            cell.cellImage.image = UIImage(named: "structure")
            cell.titleLabel.text = "Structure of Volcanoes"
            return cell
        } else {
            let cell = tableView.dequeueReusableCell(withIdentifier: "PrototypeCell", for: indexPath) as! TableViewCell
            cell.titleLabel.text = dataArray[0][indexPath.row - 1]
            cell.subtitleLabel.text = dataArray[1][indexPath.row - 1]
            return cell
        }
    }

}

//MARK: - SideMenu

extension StructureViewController {

    @IBAction func didTapMenu(_ sender: UIBarButtonItem) {
        guard let menuViewController = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "MenuViewController") as? MenuViewController else { return }
        menuViewController.didTapMenuType = { menuType in
            self.transitionToNew(menuType)
        }
        menuViewController.modalPresentationStyle = .overCurrentContext
        menuViewController.transitioningDelegate = self
        present(menuViewController, animated: true)
    }

    func transitionToNew(_ menuType: MenuType) {
        let title = String(describing: menuType).capitalized
        self.title = title

        topView?.removeFromSuperview()
        switch menuType {
        case .structure:
            guard let childVC = self.storyboard?.instantiateViewController(withIdentifier: "structure") else { return }
            view.addSubview(childVC.view)
            self.topView = childVC.view
            addChild(childVC)
            self.title = "Structure of Volcanoes"
        case .volcanoes:
            let childVC = UIStoryboard(name: "Volcanoes", bundle: nil).instantiateViewController(withIdentifier: "volcanoes")
            view.addSubview(childVC.view)
            self.topView = childVC.view
            addChild(childVC)
            self.title = "Volcanoes"
        case .eruptions:
            let childVC = UIStoryboard(name: "Eruptions", bundle: nil).instantiateViewController(withIdentifier: "eruptions")
            view.addSubview(childVC.view)
            self.topView = childVC.view
            addChild(childVC)
            self.title = "Greatest Eruptions"
        case .video:
            let childVC = UIStoryboard(name: "Video", bundle: nil).instantiateViewController(withIdentifier: "video")
            view.addSubview(childVC.view)
            self.topView = childVC.view
            addChild(childVC)
            self.title = "Video"
        case .map:
            let childVC = UIStoryboard(name: "Map", bundle: nil).instantiateViewController(withIdentifier: "map")
            view.addSubview(childVC.view)
            self.topView = childVC.view
            addChild(childVC)
            self.title = "Map"
        case .settings:
            let childVC = UIStoryboard(name: "Settings", bundle: nil).instantiateViewController(withIdentifier: "Settings")
            view.addSubview(childVC.view)
            self.topView = childVC.view
            addChild(childVC)

        }
    }

}

//MARK: - UIViewControllerTransitioningDelegate

extension StructureViewController: UIViewControllerTransitioningDelegate {
    
    func animationController(forPresented presented: UIViewController, presenting: UIViewController, source: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        transiton.isPresenting = true
        return transiton
    }

    func animationController(forDismissed dismissed: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        transiton.isPresenting = false
        return transiton
    }
}


//MARK: - Core

class Core {
    
    static let shared = Core()
    
    func isNewUser() -> Bool {
        return !UserDefaults.standard.bool(forKey: "isNewUser")
    }
    
    ///
    func setIsNotNewUser() {
        UserDefaults.standard.set(true, forKey: "isNewUser")
    }
}
