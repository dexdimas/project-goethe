//
//  PreviewViewController.swift
//  project-goethe
//
//  Created by Andimas Bagaswara on 15/06/20.
//  Copyright © 2020 Andimas Bagaswara. All rights reserved.
//

import UIKit

class PreviewViewController: UIViewController {
    
    var takenPhoto: UIImage?
    var takenColor: UIColor?
    
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var colorView: UIView!
    @IBOutlet weak var colorPreview: UIView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var hexLabel: UILabel!
    
    var colorList: [Color] = []
    var colorTemp: ColorModel?
    
    var helper: CoreDataHelper!
    var colorManager = ColorManager()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Save", style: .plain, target: self, action: #selector(save))
        navigationItem.rightBarButtonItem?.tintColor = .white
        
        helper = CoreDataHelper(context: getViewContext())
        colorManager.delegate = self
        colorManager.fetchColor(colorHex: (takenColor?.toHexString())!)
        
        imageView.contentMode = .scaleAspectFill
        if let availableImage = takenPhoto {
            imageView.image = availableImage
            colorPreview.backgroundColor = takenColor
            colorPreview.layer.borderWidth = 5.0
            colorPreview.layer.borderColor = UIColor.white.cgColor
        }
        
        colorList = helper.fetchAll()
    }
    
    @objc func save() {
        if let newColor = Color.saveTask(context: getViewContext(), colorName: colorTemp!.colorName, colorHex: colorTemp!.colorHex, colorRed: colorTemp!.colorRed, colorGreen: colorTemp!.colorGreen, colorBlue: colorTemp!.colorBlue) {
            colorList.append(newColor)
            
            let alertController = UIAlertController(title: "Saved Successful", message:
                .none, preferredStyle: .alert)
            alertController.addAction(UIAlertAction(title: "OK", style: .default))

            self.present(alertController, animated: true, completion: nil)
        }
    }
    
    /*
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     // Get the new view controller using segue.destination.
     // Pass the selected object to the new view controller.
     }
     */
    
}

extension PreviewViewController: ColorManagerDelegate {
    
    func didUpdateColor(_ colorManager: ColorManager, color: ColorModel) {
        DispatchQueue.main.async {
            self.nameLabel.text = color.colorName
            self.hexLabel.text = color.colorHex
            self.colorTemp = color
        }
    }
    
    func didFailWithError(error: Error) {
        print(error)
    }
}

extension UIColor {
    func toHexString() -> String {
        var r:CGFloat = 0
        var g:CGFloat = 0
        var b:CGFloat = 0
        var a:CGFloat = 0

        getRed(&r, green: &g, blue: &b, alpha: &a)

        let rgb:Int = (Int)(r*255)<<16 | (Int)(g*255)<<8 | (Int)(b*255)<<0

        return NSString(format:"%06x", rgb) as String
    }

    convenience init(red: Int, green: Int, blue: Int) {
        assert(red >= 0 && red <= 255, "Invalid red component")
        assert(green >= 0 && green <= 255, "Invalid green component")
        assert(blue >= 0 && blue <= 255, "Invalid blue component")

        self.init(red: CGFloat(red) / 255.0, green: CGFloat(green) / 255.0, blue: CGFloat(blue) / 255.0, alpha: 1.0)
    }

}
