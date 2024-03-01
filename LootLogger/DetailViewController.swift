//
//  DetailViewController.swift
//  LootLogger
//
//  Created by Hamit Sehjal on 2024-02-28.
//

import UIKit

class DetailViewController: UIViewController {
    
    @IBOutlet var nameField: UITextField!
    @IBOutlet var serialNumberField: UITextField!
    @IBOutlet var valueField: UITextField!
    @IBOutlet var dateLabel: UILabel!
    
    let numberFormatter:NumberFormatter={
        let formatter=NumberFormatter()
        formatter.numberStyle = .decimal
        formatter.minimumFractionDigits = 2
        formatter.maximumFractionDigits = 2
        return formatter
    }()
    
    let dateFormatter:DateFormatter={
        let formatter=DateFormatter()
        formatter.dateStyle = .medium
        formatter.timeStyle = .none
        return formatter
    }()
    

    var item:Item!
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        nameField.text=item.name
        serialNumberField.text=item.serialNumber
        valueField.text=numberFormatter.string(from: NSNumber(value: item.valueInDollars))
        dateLabel.text=dateFormatter.string(from: item.dateCreated)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        // "Save" changes to item
        item.name=nameField.text ?? ""
        item.serialNumber=serialNumberField.text
        
        // unwrap valueField using optional binding
        // if that is successful, unwrap the value returned by converting string to number
        // if that worked, assign the value to the item.valueInDollars
        if let valueText = valueField.text,
           let value = numberFormatter.number(from: valueText){
            item.valueInDollars=value.intValue
        }else{
        item.valueInDollars=0
        }
        
    }
}
