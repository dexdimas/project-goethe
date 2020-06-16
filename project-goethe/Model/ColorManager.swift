//
//  ColorManager.swift
//  project-goethe
//
//  Created by Andimas Bagaswara on 16/06/20.
//  Copyright © 2020 Andimas Bagaswara. All rights reserved.
//

import Foundation

protocol ColorManagerDelegate {
    func didUpdateColor(_ colorManager: ColorManager, color: ColorModel)
    func didFailWithError(error: Error)
}

struct ColorManager {
    let colorURL = "http://www.thecolorapi.com/id?"
    
    var delegate: ColorManagerDelegate?
    
    func fetchColor(colorHex: String) {
        let urlString = "\(colorURL)hex=\(colorHex)"
        print(urlString)
        performRequest(with: urlString)
    }
    
    func performRequest(with urlString: String) {
        if let url = URL(string: urlString) {
            let session = URLSession(configuration: .default)
            let task = session.dataTask(with: url) { (data, response, error) in
                if error != nil {
                    self.delegate?.didFailWithError(error: error!)
                    return
                }
                if let safeData = data {
                    print(safeData)
                    if let color = self.parseJSON(safeData) {
                        self.delegate?.didUpdateColor(self, color: color)
                    }
                }
            }
            task.resume()
        }
    }
    
    func parseJSON(_ colorData: Data) -> ColorModel? {
        let decoder = JSONDecoder()
        do {
            let decodedData = try decoder.decode(ColorData.self, from: colorData)
            let colorName = decodedData.name.value
            let colorHex = decodedData.hex.value
            let colorRed = decodedData.rgb.fraction.r
            let colorGreen = decodedData.rgb.fraction.g
            let colorBlue = decodedData.rgb.fraction.b
            
            let color = ColorModel(colorName: colorName, colorHex: colorHex, colorRed: colorRed, colorGreen: colorGreen, colorBlue: colorBlue)
            return color
            
        } catch {
            delegate?.didFailWithError(error: error)
            return nil
        }
    }
}
