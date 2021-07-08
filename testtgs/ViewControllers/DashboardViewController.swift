//
//  DashboardViewController.swift
//  testtgs
//
//  Created by Manuel Landaverde on 7/7/21.
//

import UIKit
import Alamofire

class DashboardViewController: UIViewController {
    
    @IBOutlet weak var welcomeLabel: UILabel!
    @IBOutlet weak var tableView: UITableView!
    
    var dataModel: LoginModel! = nil
    var products: [ProductsModel] = [ProductsModel]()
    
    private var productCellIdentifier: String = "productRowCell"
    
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
    
    // MARK: - Private
    
    private func setupUI() {
        tableView.register(UINib(nibName: "ProductTableViewCell", bundle: nil), forCellReuseIdentifier: productCellIdentifier)
        tableView.delegate = self
        tableView.dataSource = self
        
        if let model = dataModel {
            loadProductsWith(store_id: String(format: "\(model.store_id ?? 0)"))
            welcomeLabel.text = String(format: "Bienvenido \(model.nombre ?? "") \(model.apellido ?? "")")
        }
    }
    
    private func loadProductsWith(store_id: String) {
        let parameters: [String: String] = ["store_id": store_id]
        
        AF.request(Static.shared.productsURL, method: .post,  parameters: parameters, encoding: JSONEncoding.default)
                    .responseJSON { response in
                        
                        switch response.result {
                                    case .success(_):
                                        do {
                                            let productsData = try JSONDecoder().decode([ProductsModel].self, from: response.data!)
                                            self.parseProductsData(products: productsData)
                                            
                                        } catch (let errorCatch) {
                                            print("Error: \(errorCatch.localizedDescription)")
                                        }
                                        
                                    case .failure(let error):
                                        print(error)
                                    }
                }
    }
    
    // MARK: - Helpers
    
    func parseProductsData(products: [ProductsModel]) {
        self.products = products
        self.tableView.reloadData()
    }
    
}

// MARK: - UITableViewDelegate && UITableViewDataSource

extension DashboardViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        print("COUNT: \(self.products.count)")
        return self.products.count
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: productCellIdentifier, for: indexPath as IndexPath) as! ProductTableViewCell
        
        let product = self.products[indexPath.row]
        
        cell.productName.text = product.name
        cell.descriptionLabel.text = product.description
        cell.priceLabel.text = product.price
        cell.categoryLabel.text = product.category
        
        return cell
    }
    
}
