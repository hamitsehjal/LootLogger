//
//  ItemStore.swift
//  LootLogger
//
//  Created by Hamit Sehjal on 2024-02-21.
//

import UIKit

class ItemStore{
    // declaring a property with a initial value
    var allItems=[Item]()
    
    
    // `@discardableResult` annotation means that the caller of the function is free to ignore the result of calling this function
    @discardableResult func createItem()->Item{
        let newItem=Item(random: true)
        
        allItems.append(newItem)
        
        return newItem
    }
    
    // delete an item from the store
    // finds the index of the first occurence of the item
    // remove item at that index
    func removeItem(_ item:Item){
        if let index=allItems.firstIndex(of: item){
            allItems.remove(at: index)
        }
    }
    
    // Reorder items within the store
    func moveItem(from fromIndex:Int,to toIndex:Int){
        if fromIndex==toIndex{
            return
        }
        
        // Get reference to the Object being moved so you can re-insert it
        let movedItem = allItems[fromIndex]
        
        // remove item from the array
        allItems.remove(at: fromIndex)
        
        // Insert item in the array at new location
        allItems.insert(movedItem, at: toIndex)
    }
}
