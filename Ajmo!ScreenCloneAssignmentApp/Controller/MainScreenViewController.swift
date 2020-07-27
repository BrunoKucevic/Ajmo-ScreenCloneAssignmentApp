//
//  MainScreenViewController.swift
//  Ajmo!ScreenCloneAssignmentApp
//
//  Created by Bruno Kucevic on 22/07/2020.
//  Copyright © 2020 Bruno Kucevic. All rights reserved.
//

import UIKit
import RealmSwift

class MainScreenViewController: UIViewController, StoryBoarded, UITableViewDelegate, UITableViewDataSource {
    
    
    @IBOutlet var table: UITableView!
    
    weak var coordinator : MainScreenCoordinator?
    var apiResults = AppDataHandler()
    var modelArray = [DataGettable]()
    var pageNumber : Int = 1
    var entityArray : Results<Item>?
    override func viewDidLoad() {
        super.viewDidLoad()
        
        table.register(CollectionTableViewCell.nib(), forCellReuseIdentifier: CollectionTableViewCell.identifier)
        
        table.delegate = self
        table.dataSource = self
        entityArray = RealmService.shared.realm.objects(Item.self)
        apiResults.getData(pageNumber: String(pageNumber)) { (models) in
            DispatchQueue.main.async {
                models.forEach { (model) in
                    self.modelArray.append(model)
                    RealmService.shared.saveItemEntity(model)
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
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        coordinator?.goToDetails(modelArray[indexPath.row])
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        //view
        let view = UIView()
        view.backgroundColor = .clear
        //label
        let label = UILabel()
        label.text = "What's up"
        label.textColor = .black
        label.font = UIFont(name: "Helvetica Neue", size: 20)
        view.addSubview(label)
        //button
        let btn = UIButton()
        btn.backgroundColor = .clear
        btn.setTitle("All news", for: .normal)
        btn.titleLabel?.font = UIFont(name: "Helvetica Neue", size: 11)
        btn.setTitleColor(.black, for: .normal)
        btn.addTarget(self, action: #selector(self.btnClicked), for: .touchUpInside)
        view.addSubview(btn)
        //constraints
        label.anchor(top: view.topAnchor, leading: view.leadingAnchor, bottom: view.bottomAnchor, trailing: nil, padding: .init(top: 12, left: 20, bottom: 12, right: 0))
        btn.anchor(top: view.topAnchor, leading: nil, bottom: view.bottomAnchor, trailing: view.trailingAnchor, padding: .init(top: 12, left: 0, bottom: 12, right: 20), size: .init(width: 50, height: 0))
        
        return view
        
        
    }
    
    @objc func btnClicked(){
        coordinator?.goToList(modelArray)
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 50.0
    }
}

