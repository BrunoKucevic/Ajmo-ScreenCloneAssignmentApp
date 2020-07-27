//
//  SavedItemsViewController.swift
//  Ajmo!ScreenCloneAssignmentApp
//
//  Created by Bruno Kucevic on 25/07/2020.
//  Copyright © 2020 Bruno Kucevic. All rights reserved.
//

import UIKit

class ItemsListViewController: UIViewController, StoryBoarded, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var table: UITableView!
    weak var coordinator : ItemsListCoordinator?
    var apiResults = AppDataHandler()
    var modelArray = [DataGettable]()
    var pageNumber : Int = 1
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        table.register(ItemListTableViewCell.nib(), forCellReuseIdentifier: ItemListTableViewCell.identifier)
        table.delegate = self
        table.dataSource = self
        table.separatorStyle = UITableViewCell.SeparatorStyle.none
        table.rowHeight = 300
        
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return modelArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = table.dequeueReusableCell(withIdentifier: ItemListTableViewCell.identifier, for: indexPath) as! ItemListTableViewCell
        cell.configure(model: modelArray[indexPath.row])
        return cell
    }
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        
        if indexPath.row == modelArray.count - 1{
            pageNumber = pageNumber + 1
            apiResults.getData(pageNumber: String(pageNumber)) { (models) in
                DispatchQueue.main.async {
                    models.forEach { (model) in
                        self.modelArray.append(model)
                    }
                    self.table.reloadData()
                }
            }
        }
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: false)
    }
    
    
}
