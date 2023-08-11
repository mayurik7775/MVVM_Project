//
//  ProductListViewController.swift
//  MVVM_Project
//
//  Created by Mac on 11/08/23.
//

import UIKit

class ProductListViewController: UIViewController {

    @IBOutlet weak var productTabelView: UITableView!
    
    private var viewModel = ProductViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configuration()
    }

}
extension ProductListViewController{
    
    func configuration(){
        productTabelView.register(UINib(nibName: "ProductCell", bundle: nil), forCellReuseIdentifier: "ProductCell")
        initViewModel()
        observeEvent()
    }
    
    func initViewModel(){
        viewModel.fetchProducts()
    }
    
    func observeEvent(){
        viewModel.eventHandler =  { [ weak self] event in
           guard let self = self else { return }
            
            switch event{
            case .loading: break
                print("Product loading.....")
            case .stopLoading: break
                print("Stop loading....")
            case .dataLoaded:
                print("Data loading....")
                DispatchQueue.main.async {
                    self.productTabelView.reloadData()
                }
            case .error(let error):
                print(error)
            }
        }
    }
}
extension ProductListViewController: UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        viewModel.products.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "ProductCell" ) as? ProductCell else {
            return UITableViewCell()
        }
        let product = viewModel.products[indexPath.row]
        cell.product = product
        return cell
    }

    
    
}
