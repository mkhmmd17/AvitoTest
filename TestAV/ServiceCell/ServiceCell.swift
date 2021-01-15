//
//  MainCollectionViewCell.swift
//  TestAV
//
//  Created by muslim on 15.01.2021.
//

import UIKit

final class ServiceCell: UICollectionViewCell {
    
    static let leftMargin: CGFloat = 16
    
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
        serviceTextLabel.text = cellModel.serviceText
        serviceTitleLabel.text = cellModel.serviceTitle
        servicePriceLabel.text = cellModel.servicePrice
        checkmarkImageView.isHidden = !cellModel.isSelected
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

}

extension ServiceCell {
    
    static func cellSize(text: String, attributes: [NSAttributedString.Key: Any]) -> CGSize {
        let cellWidth = UIScreen.main.bounds.width - 16 * 2
        let maxWidth: CGFloat = cellWidth - leftMargin - 52 - 10 - 10 - 10 - 16
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
