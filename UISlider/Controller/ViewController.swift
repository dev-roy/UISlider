//
//  ViewController.swift
//  UISlider
//
//  Created by Field Employee on 3/25/20.
//  Copyright © 2020 Field Employee. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    // MARK: - Properties
    @IBOutlet weak var subtotalTextField: UITextField! {
        didSet {
            subtotalTextField?.addDoneCancelToolbar(onDone: (target: self, action: #selector(doneButtonTapped)))
        }
    }
    @IBOutlet weak var tipAmountLabel: UILabel!
    @IBOutlet weak var tipSlider: UISlider!
    @IBOutlet weak var tipPercentage: UISegmentedControl!
    @IBOutlet weak var enterAmountLabel: UILabel!
    @IBOutlet weak var totalLabel: UILabel!
    var amountOfTip: Float = 0.0
    var subtotal: Float = 0.0
    var total: Float = 0.0
    
    // MARK: - Init
    override func viewDidLoad() {
        super.viewDidLoad()
        tipSlider.value = 0
        enterAmountLabel.isHidden = true
    }
    
    // MARK: - Handlers
    @objc func doneButtonTapped() {
        guard let subtotal = subtotalTextField.text, !subtotal.isEmpty else {
            enterAmountLabel.isHidden = false
            return
        }
        self.subtotal = Float(subtotal)!
        subtotalTextField.text = String(format: "$ %.2f", self.subtotal)
        enterAmountLabel.isHidden = true
        subtotalTextField.resignFirstResponder()
        calculateTip(subtotal)
        setSuggestedTip()
        updateTotal()
    }
    
    func calculateTip(_ subtotalString: String) {
        guard let subtotalFloat = Float(subtotalString) else { return }
        amountOfTip = subtotalFloat * tipSlider.value
    }
    
    func setSuggestedTip() {
        tipSlider.value = 0.2
        amountOfTip = subtotal * tipSlider.value
        tipPercentage.selectedSegmentIndex = 2
        tipAmountLabel.text = String(format: "$ %.2f", amountOfTip)
    }

    func updateTotal() {
        total = subtotal + amountOfTip
        totalLabel.text = String(format: "$ %.2f", total)
    }
    
    @IBAction func tipValueChanged(_ sender: Any) {
        amountOfTip = subtotal * tipSlider.value
        tipAmountLabel.text = String(format: "$ %.2f", amountOfTip)
        tipPercentage.selectedSegmentIndex = 3
    }
    
    @IBAction func indexChanged(_ sender: Any) {
        switch tipPercentage.selectedSegmentIndex {
        case 0:
            tipSlider.value = 0
            amountOfTip = subtotal * tipSlider.value
            tipAmountLabel.text = String(format: "$ %.2f", amountOfTip)
            updateTotal()
        case 1:
            tipSlider.value = 0.1
            amountOfTip = subtotal * tipSlider.value
            tipAmountLabel.text = String(format: "$ %.2f", amountOfTip)
            updateTotal()
        case 2:
            tipSlider.value = 0.2
            amountOfTip = subtotal * tipSlider.value
            tipAmountLabel.text = String(format: "$ %.2f", amountOfTip)
            updateTotal()
        case 3:
            tipSlider.value = 0.25
            amountOfTip = subtotal * tipSlider.value
            tipAmountLabel.text = String(format: "$ %.2f", amountOfTip)
            updateTotal()
        default:
            break
        }
    }
}

