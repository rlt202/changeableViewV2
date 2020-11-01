//
//  ColorizedViewController.swift
//  changeableView
//
//  Created by Даниил Никулин on 30.10.2020.
//

import UIKit

class ColorizedViewController: UIViewController, OptionViewControllerDelegate {

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let optionVC = segue.destination as! OptionViewController
        optionVC.delegate = self
        optionVC.colorOfView = view.backgroundColor
    }
    
    func changeColor(_ color: UIColor) {
        view.backgroundColor = color
    }
}
