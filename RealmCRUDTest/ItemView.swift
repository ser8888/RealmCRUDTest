//
//  ItemView.swift
//  RealmCRUDTest
//
//  Created by John Doe on 23/11/2022.
//

import SwiftUI
import RealmSwift



struct ItemView: View {
    
    @ObservedRealmObject var itemGroup: ItemGroup
    
    @State private var isPresented: Bool = false
    
    var body: some View {
        NavigationView{
            VStack {
                List {
                    ForEach(itemGroup.items) { item in
                        Text(item.name)
                        
                    }
                    .onDelete(perform: $itemGroup.items.remove)
                }
            }
            .sheet(isPresented: $isPresented, content: {
                AddItemsView(item: Item(), itemGroup: itemGroup)
            })
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button {
                        // action
                        isPresented = true
                    } label: {
                        Image(systemName: "plus")
                    }

                }
        }
        }
    }
}

//struct ItemView_Previews: PreviewProvider {
//    static var previews: some View {
//        ItemView()
//    }
//}
