//
//  ItemsViewController.swift
//  LootLogger
//
//  Created by Hamit Sehjal on 2024-02-21.
//

import UIKit

class ItemsViewController: UITableViewController {
    var itemStore:ItemStore!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.rowHeight=UITableView.automaticDimension
        tableView.estimatedRowHeight=65
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        tableView.reloadData()
    }
    // add new item
    @IBAction func addNewItem(_ sender:UIButton){
        
        // create a new item and add it to the allItems property of itemStore
        // also return the newly created item
        let newItem = itemStore.createItem()
        
        if let index = itemStore.allItems.firstIndex(of:newItem){
            let indexPath=IndexPath(row: index, section: 0)
            
            // Insert this new row into the table
            tableView.insertRows(at: [indexPath], with: .automatic)
        }
        
    }
    
    // table view row deletion
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        
        // If table view is asking to commit a delete command...
        if editingStyle == .delete{
            let item = itemStore.allItems[indexPath.row]
            
            // Remove the item from the store
            itemStore.removeItem(item)
            
            // Also, remove that row from the table view with an animation
            tableView.deleteRows(at: [indexPath], with: .automatic)
        }
       
    }
    
    // table view row re-arranging(moving)
    override func tableView(_ tableView: UITableView, moveRowAt sourceIndexPath: IndexPath, to destinationIndexPath: IndexPath) {
        
        // update the model
        itemStore.moveItem(from: sourceIndexPath.row, to: destinationIndexPath.row)
        
    }
    // toggle Editing Mode
    @IBAction func toggleEditingMode(_ sender:UIButton){
//        print("Toggle Editing Mode clicked")
        if isEditing{
            // change text of the button to inform user of state
            sender.setTitle("Edit", for: .normal)
            
            // Turn off the editing mode
            setEditing(false, animated: true)
        }
        else{
            
            // change the text of the button to inform user of state
            sender.setTitle("Done", for: .normal)
            
            // Turn on the editing mode
            setEditing(true, animated: true)
        }
    }
    
    // Number of rows in the Table
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return itemStore.allItems.count
    }

    // Content to display in each Cell
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> ItemCell {
        // create an instance of UITableViewCell with default appearance
//        let cell=UITableViewCell(style: .value1, reuseIdentifier: "UITableViewCell")
        
        // Get a new or recycled cell
        let cell = tableView.dequeueReusableCell(withIdentifier: "ItemCell", for: indexPath) as! ItemCell
        // set the text on the cell with the description of the Item
        // that is at the nth index of items, where n = row this cell
        // will appear on the table view
        let item=itemStore.allItems[indexPath.row]
        cell.nameLabel.text=item.name
        cell.serialNumberLabel.text=item.serialNumber
        cell.valueLabel.text="$\(item.valueInDollars)"
    
        
        return cell
    }
    
    // showItem segue
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // if the triggered segue is 'showItem' segue
        switch segue.identifier{
        case "showItem":
            //Figure out which row was tapped
            if let row = tableView.indexPathForSelectedRow?.row{
                
                // Get the item associated with this row and pass it along
                let item=itemStore.allItems[row]
                let detailViewController=segue.destination as! DetailViewController
                
                detailViewController.item=item
                
            }
        default:
            preconditionFailure("Unexpected Segue Failure")
        }
    }
}
