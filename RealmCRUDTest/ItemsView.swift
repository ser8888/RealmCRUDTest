//
//  ItemsView.swift
//  RealmCRUDTest
//
//  Created by John Doe on 22/11/2022.
//

import SwiftUI
import RealmSwift

struct ItemsView: View {
    
    @ObservedRealmObject var itemGroup: ItemGroup
    @ObservedResults(ItemGroup.self) var itemGroups
    
    @State private var isPresented: Bool = false
    
    var body: some View {
        NavigationView {
            VStack {
                Text(itemGroup.name)
                List {
                    ForEach(itemGroups, id: \.id) { item in
                        Text(item.name)
                        
                    }
                }
                .navigationTitle("View")
            }
            .sheet(isPresented: $isPresented, content: {
                CRUDVIew(itemGroup: itemGroup)
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

//struct ItemsView_Previews: PreviewProvider {
//    static var previews: some View {
//        @ObservedResults(ItemGroup.self) var itemGroups
//        ItemsView(itemGroups: itemGroups)
//    }
//}
