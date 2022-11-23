//
//  AddItemsView.swift
//  RealmCRUDTest
//
//  Created by John Doe on 23/11/2022.
//

import SwiftUI
import RealmSwift

struct AddItemsView: View {
    

    @ObservedResults(ItemGroup.self) var itemGroups
    @ObservedRealmObject var item: Item
    @ObservedRealmObject var itemGroup: ItemGroup
    @Environment(\.dismiss) private var dismiss
    
    var body: some View {
        
        TextField("Add Item", text: $item.name)
        TextField("Add something", text: $item.itemDescription)
        
      
        
        
        Button ( action: {
            
            $itemGroup.items.append(item)
            
//            $itemGroups.ite append(item)
//            $itemGroup.append(item)
            
            
            dismiss()
        })
        {
            Text("Добавить товарную группу")
        }
        .frame(width: 650, alignment: .center)
        .buttonStyle(.bordered)
    }
}

//struct AddItemsView_Previews: PreviewProvider {
//    static var previews: some View {
//        AddItemsView()
//    }
//}
