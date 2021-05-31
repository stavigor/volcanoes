//
//  Decoder.swift
//  Greatest Volcanoes
//
//  Created by Игорь Растегаев on 26.01.2021.
//

import Foundation
import Alamofire

protocol JSONManagerDelegate {
    func didUpdateData(_ JSONManager: JSONManager, data: [[String]])
}

struct JSONManager {
    
    var delegate: JSONManagerDelegate?

    func getData(with url: String) {
        AF.request(url).response { response in
            if let data = response.data {
                if let decodedData = self.parseJSON(data) {
                    self.delegate?.didUpdateData(self, data: decodedData)
                }
            }
        }
    }


    func parseJSON(_ data: Data) -> [[String]]? {
        let decoder = JSONDecoder()
        do {
            let decodedData = try decoder.decode(JSONData.self, from: data)
            return decodedData.array
        } catch {
            return nil
        }
    }
    
//    func getData(forName name: String) -> [[String]]? {
//        do {
//            if let bundlePath = Bundle.main.path(forResource: name, ofType: "json"),
//                let jsonData = try String(contentsOfFile: bundlePath).data(using: .utf8) {
//                let decoder = JSONDecoder()
//                let decodedData = try decoder.decode(JSONData.self, from: jsonData)
//                return decodedData.array
//            }
//        } catch {
//            print(error)
//
//        }
//        return nil
//    }
    
}
