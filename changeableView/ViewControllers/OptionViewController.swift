//
//  ViewController.swift
//  changeableView
//
//  Created by Даниил Никулин on 16.10.2020.
//

import UIKit

protocol OptionViewControllerDelegate {
    func changeColor(_ color: UIColor)
}

class OptionViewController: UIViewController, UITextFieldDelegate {
    
    @IBOutlet weak var changeableView: UIView!
    
    @IBOutlet weak var redValue: UILabel!
    @IBOutlet weak var greenValue: UILabel!
    @IBOutlet weak var blueValue: UILabel!
    
    @IBOutlet weak var redSlider: UISlider!
    @IBOutlet weak var greenSlider: UISlider!
    @IBOutlet weak var blueSlider: UISlider!
    
    @IBOutlet weak var redTextField: UITextField!
    @IBOutlet weak var greenTextField: UITextField!
    @IBOutlet weak var blueTextField: UITextField!
    
    
    var delegate: OptionViewControllerDelegate!
    var colorOfView: UIColor!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        changeableView.backgroundColor = colorOfView
        
        sliderValue(sliders: redSlider, greenSlider, blueSlider)
        changeValue(labels: redValue, greenValue, blueValue)
        
        attachSaveButtonToTextFields(redTextField, greenTextField, blueTextField)
    }
    
    @IBAction func changeValueOfLabels(sender: UISlider) {
        
        switch sender {
        case redSlider:
            redValue.text = formatingSlidersValue(slider: redSlider)
        case greenSlider:
            greenValue.text = formatingSlidersValue(slider: greenSlider)
        case blueSlider:
            blueValue.text = formatingSlidersValue(slider: blueSlider)
        default:
            break
        }
        settingColourOfView()
    }

    @IBAction func saveButtonPressed() {
        delegate?.changeColor(changeableView.backgroundColor ?? .white)
        dismiss(animated: true)
    }
}


extension OptionViewController {
    
    private func formatingSlidersValue(slider: UISlider) -> String {
        String(format: "%.2f", slider.value)
    }
    
    private func settingColourOfView() {
        changeableView.backgroundColor = UIColor(red: CGFloat(redSlider.value),
                               green: CGFloat(greenSlider.value),
                               blue: CGFloat(blueSlider.value),
                               alpha: 1)
    }
    
    private func changeValue(labels: UILabel...) {
        labels.forEach { labels in
            switch labels.tag {
            case 0:
                redValue.text = formatingSlidersValue(slider: redSlider)
            case 1:
                greenValue.text = formatingSlidersValue(slider: greenSlider)
            case 2:
                blueValue.text = formatingSlidersValue(slider: blueSlider)
            default:
                break
        }
    }
}
    private func sliderValue(sliders: UISlider...) {
        
        let color = CIColor(color: colorOfView)
        
        sliders.forEach { slider in
            switch slider.tag {
            case 0:
                redSlider.value = Float(color.red)
            case 1:
                greenSlider.value = Float(color.green)
            case 2:
                blueSlider.value = Float(color.blue)
            default:
                break
            }
        }
    }
}

extension OptionViewController {
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesBegan(touches, with: event)
        view.endEditing(true)
    }
    
    
    @objc private func saveTapped() {
        view.endEditing(true)
    }
    
    private func attachSaveButtonToTextFields(_ textFields: UITextField...) {
        
        textFields.forEach { textField in
            let bar = UIToolbar()
            textField.inputAccessoryView = bar
            bar.sizeToFit()
            
            let save = UIBarButtonItem(title:"Save",
                                       style: .done,
                                       target: self,
                                       action: #selector(saveTapped))
            bar.items = [save]
        }
    }
    
    func textFieldDidEndEditing(_ textFields: UITextField) {

        guard
            let value = textFields.text else {
            return

        }
        
        let valueOfTextFields = Float(value)
        
            switch textFields.tag {
            case 0:
                redSlider.setValue(valueOfTextFields!, animated: true)
                changeValue(labels: redValue)
            case 1:
                greenSlider.setValue(valueOfTextFields!, animated: true)
                changeValue(labels: greenValue)
            case 2:
                blueSlider.setValue(valueOfTextFields!, animated: true)
                changeValue(labels: blueValue)
            default: break
            }
            
            settingColourOfView()
    }
}
