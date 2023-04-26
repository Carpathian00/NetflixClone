//
//  ViewAllViewController.swift
//  NetflixClone
//
//  Created by Adlan Nourindiaz on 25/04/23.
//

import UIKit

class ViewAllViewController: UIViewController {
    
    var selectedSection: Int?
    private var viewAllVM: ViewAllViewModel?
    private var items = [Item]()
    
    private lazy var viewAllTable: UITableView = {
        let table = UITableView()
        table.translatesAutoresizingMaskIntoConstraints = false
        table.register(UINib(nibName: "ViewAllTableCell", bundle: nil), forCellReuseIdentifier: ViewAllTableCell.identifier)
        return table
    }()
    
    
    
    override func loadView() {
        super.loadView()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupTable()
        setupData()
    }
    
    private func setupTable() {
        view.addSubview(viewAllTable)
        
        NSLayoutConstraint.activate([
            viewAllTable.topAnchor.constraint(equalTo: view.topAnchor),
            viewAllTable.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            viewAllTable.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            viewAllTable.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
        
        viewAllTable.delegate = self
        viewAllTable.dataSource = self
        
    }
    
    private func setupData() {
        guard let selectedSection = self.selectedSection else { return }
        self.viewAllVM = ViewAllViewModel(selectedSection: selectedSection)
        self.viewAllVM?.getData()
        self.viewAllVM?.bindItemData = { result in
            guard let resultItems = result else { return }
                self.items.append(contentsOf: resultItems)
            DispatchQueue.main.async {
                
                self.viewAllTable.reloadData()
            }
        }
    }
    
    func configure(section: Int) {
        self.selectedSection = section
    }
    
}

extension ViewAllViewController: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = viewAllTable.dequeueReusableCell(withIdentifier: ViewAllTableCell.identifier, for: indexPath) as? ViewAllTableCell else { return UITableViewCell() }
        cell.configure(itemModel: self.items[indexPath.row])
        return cell
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let position = scrollView.contentOffset.y

        
        if position > (viewAllTable.contentSize.height - 100 - scrollView.frame.size.height) {
            print("fetch")
            self.viewAllVM?.getData()
            self.viewAllVM?.bindItemData = { result in
                guard let resultItems = result else { return }
                    self.items.append(contentsOf: resultItems)
                DispatchQueue.main.async {
                    
                    self.viewAllTable.reloadData()
                }
            }
        }
    }
}
