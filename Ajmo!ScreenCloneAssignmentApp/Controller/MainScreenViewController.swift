//
//  MainScreenViewController.swift
//  Ajmo!ScreenCloneAssignmentApp
//
//  Created by Bruno Kucevic on 22/07/2020.
//  Copyright © 2020 Bruno Kucevic. All rights reserved.
//

import UIKit

class MainScreenViewController: UIViewController, StoryBoarded, UITableViewDelegate, UITableViewDataSource {

    
    @IBOutlet var table: UITableView!
    
    weak var coordinator : MainScreenCoordinator?
    var apiResults = AppDataHandler()
    var modelArray = [Data]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        table.register(CollectionTableViewCell.nib(), forCellReuseIdentifier: CollectionTableViewCell.identifier)
        table.delegate = self
        table.dataSource = self
        
        apiResults.getData { (models) in
            DispatchQueue.main.async {
                models.forEach { (model) in
                    self.modelArray.append(model)
                }
                self.table.reloadData()
            }
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = table.dequeueReusableCell(withIdentifier: CollectionTableViewCell.identifier, for: indexPath) as! CollectionTableViewCell
        cell.configure(for: modelArray)
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 450.0
    }

}
