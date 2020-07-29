//
//  MainScreenViewController.swift
//  Ajmo!ScreenCloneAssignmentApp
//
//  Created by Bruno Kucevic on 22/07/2020.
//  Copyright © 2020 Bruno Kucevic. All rights reserved.
//

import UIKit
import RealmSwift

class MainScreenViewController: UIViewController, StoryBoarded {
    
    @IBOutlet var table: UITableView!
    
    weak var coordinator : MainScreenCoordinator?
    var apiResults = AppDataHandler()
    var modelArray = [DataGettable]()
    var pageNumber : Int = 1
    var entityArray : Results<Item>?
    var finishedLoading : Bool = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        table.register(CollectionTableViewCell.nib(), forCellReuseIdentifier: CollectionTableViewCell.identifier)
        apiResults.delegate = self
        table.delegate = self
        table.dataSource = self
        entityArray = RealmService.shared.realm.objects(Item.self)
        apiResults.getData(pageNumber: String(pageNumber)) { (models, loaded) in
            DispatchQueue.main.async {
                models.forEach { (model) in
                    self.modelArray.append(model)
                    RealmService.shared.saveItemEntity(model)
                    if loaded{
                        self.checkForModelCount()
                    }
                }
                self.table.reloadData()
            }
        }
    } 
}

// MARK: - MainScreenViewController: UITableViewDelegate, APIErrorDelegate
extension MainScreenViewController: UITableViewDelegate, APIErrorDelegate{
    
    func getError(error: String) {
        DispatchQueue.main.async {
            self.checkForModelCount()
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 450.0
    }
    
    func checkForModelCount(){
        if self.modelArray.count == 0 {
            self.showNoDataAlert()
        }
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        
        let view = UIView()
        view.backgroundColor = .clear
        
        let label = UILabel()
        label.text = "What's up"
        label.textColor = .black
        label.font = UIFont(name: "Helvetica Neue", size: 20)
        view.addSubview(label)
        
        let btn = UIButton()
        btn.backgroundColor = .clear
        btn.setTitle("All news", for: .normal)
        btn.titleLabel?.font = UIFont(name: "Helvetica Neue", size: 11)
        btn.setTitleColor(.black, for: .normal)
        btn.addTarget(self, action: #selector(self.btnClicked), for: .touchUpInside)
        view.addSubview(btn)
        
        label.anchor(top: view.topAnchor, leading: view.leadingAnchor, bottom: view.bottomAnchor, trailing: nil, padding: .init(top: 12, left: 20, bottom: 12, right: 0))
        btn.anchor(top: view.topAnchor, leading: nil, bottom: view.bottomAnchor, trailing: view.trailingAnchor, padding: .init(top: 12, left: 0, bottom: 12, right: 20), size: .init(width: 50, height: 0))
        
        return view
    }
    
    @objc func btnClicked(){
        if modelArray.count != 0{
            coordinator?.goToList(modelArray)
        }else{
            if let entity = entityArray{
                if entity.count != 0 {
                    coordinator?.goToList(entity.reversed())
                }else{
                    self.showAlertController(title: "Error", message: "Nothing to show here due to bad or no internet connection and empty database")
                }
            }
        }
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 50.0
    }
}

// MARK: - MainScreenViewController: UITableViewDataSource, ReusableCellDelegate
extension MainScreenViewController: UITableViewDataSource, ReusableCellDelegate{
    
    func raiseAlert() {
        self.showNoDataAlert()
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = table.dequeueReusableCell(withIdentifier: CollectionTableViewCell.identifier, for: indexPath) as! CollectionTableViewCell
        cell.delegate = self
        
        if modelArray.count != 0{
            cell.configure(for: modelArray)
        }
        else{
            if let entity = entityArray{
                if entity.count != 0 {
                    cell.configure(for: entity.reversed())
                }
            }
        }
        return cell
    }
    
    func cellClicked(_ indexPath: IndexPath) {
        if modelArray.count != 0 {
            coordinator?.goToDetails(modelArray[indexPath.row])
        }else{
            if let entity = entityArray {
                coordinator?.goToDetails(entity.reversed()[indexPath.row])
            }
        }
    }
}
