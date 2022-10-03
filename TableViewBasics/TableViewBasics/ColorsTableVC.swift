//
//  ColorsTableVC.swift
//  TableViewBasics
//
//  Created by Umut Can Ertürk on 3.10.2022.
//

import UIKit
import UIColorHexSwift

class ColorsTableVC: UIViewController {
    var colorsArray = Array<UIColor>()

    override func viewDidLoad() {
        super.viewDidLoad()

      addColors()
    }
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let destinationVC = segue.destination as? ColorDetailVC
        if destinationVC != nil {
            destinationVC!.color = sender as? UIColor
        }
    }
    
    func addColors() {
        for _ in 0..<49 {
            colorsArray.append(UIColor.random())
        }
    }
    
}

extension ColorsTableVC: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return colorsArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: Cells.colorCell) else {
            return UITableViewCell()
        }
        cell.backgroundColor = colorsArray[indexPath.row]
        let colorHEX = cell.backgroundColor?.hexString()
        
        var content = cell.defaultContentConfiguration()

        // Configure content.
        content.text = colorHEX!
        content.secondaryText = colorHEX!
        content.textProperties.color = .white

        // Customize appearance.
        content.imageProperties.tintColor = .purple

        cell.contentConfiguration = content
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let color = colorsArray[indexPath.row]
        performSegue(withIdentifier: Segues.toDetail, sender: color)
        
    }
    
    
}

extension ColorsTableVC {
    enum Segues {
        static let toDetail = "ToColorDetail"
    }
    
    enum Cells {
        static let colorCell = "ColorRow"
    }
}

