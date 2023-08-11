//
//  ProductCell.swift
//  MVVM_Project
//
//  Created by Mac on 11/08/23.
//

import UIKit

class ProductCell: UITableViewCell {

    @IBOutlet weak var productImageView: UIImageView!
    @IBOutlet weak var productBackGroundView: UIView!
    @IBOutlet weak var productTitleLabel: UILabel!
    @IBOutlet weak var productCatergoryLabel: UILabel!
    @IBOutlet weak var rateButton: UIButton!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var priceLabel: UILabel!
    
    var product: Product? {
        didSet{
            productDetailConfiguration()
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        productBackGroundView.clipsToBounds = false
        productBackGroundView.layer.cornerRadius = 15
        productImageView.layer.cornerRadius = 10
        
        self.productBackGroundView.backgroundColor = .systemGray6
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    func productDetailConfiguration(){
        guard let product = product else {
            return
        }
        productTitleLabel.text = product.title
        productCatergoryLabel.text = product.category
        descriptionLabel.text = product.description
        priceLabel.text = "$\(product.price)"
        rateButton.setTitle("\(product.rating.rate)", for: .normal)
        productImageView.setImage(with: product.image)
    }
}
