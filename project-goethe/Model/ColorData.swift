//
//  ColorData.swift
//  project-goethe
//
//  Created by Andimas Bagaswara on 16/06/20.
//  Copyright © 2020 Andimas Bagaswara. All rights reserved.
//

import Foundation

struct ColorData: Codable {
    let hex: Hex
    let rgb: Rgb
    let name: Name
}

struct Hex: Codable  {
    let value: String
}

struct Rgb: Codable  {
    let fraction: Fraction
}

struct Fraction: Codable  {
    let r: Float
    let g: Float
    let b: Float
}

struct Name: Codable  {
    let value: String
}
