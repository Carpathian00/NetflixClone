//
//  ViewAllViewController.swift
//  NetflixClone
//
//  Created by Adlan Nourindiaz on 25/04/23.
//

import UIKit

class ViewAllViewController: UIViewController {
    
    var selectedSection: Int?
    var homeVCDelegate: HomeViewControllerDelegate?
    private var viewAllVM: ViewAllViewModel?
    private var items = [Item]()
    private var currentPage = 1
    
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
        self.viewAllVM?.getData(currentPage: 1)
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
        return items.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = viewAllTable.dequeueReusableCell(withIdentifier: ViewAllTableCell.identifier, for: indexPath) as? ViewAllTableCell else { return UITableViewCell() }
        cell.configure(itemModel: self.items[indexPath.row])
        return cell
    }
    
    func createSpinnerView() -> UIView {
        let footerView = UIView(frame: CGRect(x: 0, y: 0, width: view.frame.size.width, height: 100))
        
        let spinner = UIActivityIndicatorView()
        spinner.center = footerView.center
        footerView.addSubview(spinner)
        spinner.startAnimating()
        
        return footerView
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        self.viewAllTable.tableFooterView = self.createSpinnerView()

        let lastIndex = self.items.count-1
        if indexPath.row == lastIndex {
            currentPage += 1
            self.viewAllVM?.getData(currentPage: self.currentPage)
            self.viewAllVM?.bindItemData = { result in
                guard let resultItems = result else { return }
                self.items.append(contentsOf: resultItems)
                DispatchQueue.main.asyncAfter(deadline: .now() + 1, execute: {
                    self.viewAllTable.reloadData()
                    self.viewAllTable.tableFooterView = nil
                })
            }
        }
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.homeVCDelegate?.moveToDetailPage(model: self.items[indexPath.row], fromTableHeader: false)
    }
    
}
