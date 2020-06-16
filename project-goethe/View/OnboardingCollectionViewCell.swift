//
//  OnboardingCollectionViewCell.swift
//  project-goethe
//
//  Created by Andimas Bagaswara on 12/06/20.
//  Copyright © 2020 Andimas Bagaswara. All rights reserved.
//

import UIKit

class OnboardingCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var imageView: UIImageView!
    
    static let identifier = "OnboardingCollectionViewCell"
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    func configureCell(page: OnboardingPage) {
        // set the title and description of the screen
        self.titleLabel.text = page.title
        self.descriptionLabel.text = page.description
        self.imageView.image = page.image
    }

}
