//
//  MainCollectionViewCell.swift
//  TestAV
//
//  Created by muslim on 15.01.2021.
//

import UIKit

final class ServiceCell: UICollectionViewCell {
    
    static let leftMargin: CGFloat = 16
    static let rightMargin: CGFloat = 16
    static let serviceImageWidth: CGFloat = 16
    static let checkMarkImageWidth: CGFloat = 20
    static let leftLabelMargin: CGFloat = 10
    static let rightLabelMargin: CGFloat = 16
    

    @IBOutlet private weak var serviceImageView: UIImageView!
    @IBOutlet private weak var checkmarkImageView: UIImageView!
    @IBOutlet private weak var serviceTitleLabel: UILabel!
    @IBOutlet private weak var serviceTextLabel: UILabel!
    @IBOutlet private weak var servicePriceLabel: UILabel!
    

    var cellModel: ServiceCellModel!
    


    func configure(with cellModel: ServiceCellModel) {
        self.cellModel = cellModel
        backgroundColor = .lightGray
        layer.cornerRadius = 8
        serviceTitleLabel.text = cellModel.serviceTitle
        serviceTitleLabel.font = UIFont.boldSystemFont(ofSize: 16)
        serviceTextLabel.text = cellModel.serviceText
        servicePriceLabel.text = cellModel.servicePrice
        servicePriceLabel.font = UIFont.boldSystemFont(ofSize: 14)
        checkmarkImageView.isHidden = !cellModel.isSelected
        if let url = cellModel.serviceImageURL {
            serviceImageView.load(url: url)
        }
        
        
        
        
        
    }

    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
        self.contentView.isUserInteractionEnabled = true
    }
    
    

    
    
}

extension ServiceCell {
    
    static func cellSize(text: String, attributes: [NSAttributedString.Key: Any]) -> CGSize {
        let cellWidth = UIScreen.main.bounds.width - leftMargin - rightMargin
        let maxWidth: CGFloat = cellWidth - leftMargin - serviceImageWidth - leftLabelMargin - rightMargin - checkMarkImageWidth - rightMargin
        let textHeight = text.size(with: attributes, maxWidth: maxWidth).height

        let height: CGFloat = textHeight + 10 + 15 + 15 + 5 + 5 + 10
        return CGSize(width: cellWidth, height: height)
    }
    
}

extension String {
    func size(with attributes: [NSAttributedString.Key: Any], maxWidth: CGFloat) -> CGSize {
        let maxSize = CGSize(width: maxWidth, height: CGFloat.greatestFiniteMagnitude)
        return self.boundingRect(with: maxSize,
                                 options: .usesLineFragmentOrigin,
                                 attributes: attributes, context: nil).size
    }
}
