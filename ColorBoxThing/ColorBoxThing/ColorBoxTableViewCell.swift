//
//  ColorBoxTableViewCell.swift
//  ColorBoxThing
//
//  Created by Blaise Schaeffer on 3/29/16.
//  Copyright © 2016 Blaise2s. All rights reserved.
//

import UIKit

class ColorBoxTableViewCell: UITableViewCell {
    @IBOutlet weak var colorView: UIView!
    @IBOutlet weak var titleLable: UILabel!
    @IBOutlet weak var descLable: UILabel!
    
    func configuer(color: ColorBox) {
        titleLable.text = color.name
        descLable.text = color.desc
        
        colorView.backgroundColor = color.color
    }
}