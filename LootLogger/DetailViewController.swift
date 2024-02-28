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
}
