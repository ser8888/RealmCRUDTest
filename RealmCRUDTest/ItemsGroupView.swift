//
//  ItemsView.swift
//  RealmCRUDTest
//
//  Created by John Doe on 22/11/2022.
//

import SwiftUI
import RealmSwift
import PhotosUI

struct ItemsGroupView: View {
    
    @ObservedRealmObject var itemGroup: ItemGroup
 //   @ObservedResults(ItemGroup.self) var itemGroups
    
    @State private var isPresented: Bool = false
    
    @State private var selectedItem: PhotosPickerItem? = nil
    @State private var selectedImageData: Data? = nil
    
    @Environment(\.dismiss) private var dismiss
    
    let realm = try! Realm()
    
    var body: some View {
        Text("ItemView")
        
        NavigationView {
            VStack {
 //               Text("ItemView")
                Text("Старые данные")
                NavigationLink {
                    ItemView(itemGroup: itemGroup)
                } label: {
                    Text(itemGroup.name)
                }

           
                
                if let selectedImageData = itemGroup.picture,
                   let uiImage = UIImage(data: selectedImageData) {
                    Image(uiImage: uiImage)
                        .resizable()
                        .scaledToFit()
                        .frame(width: 250, height: 250)
                }
      //          Divider()
                
                Text("Новые данные")
                TextField("Новая группа", text: $itemGroup.name)
                    .textFieldStyle(.roundedBorder)
                    .padding()
                    
                
                // выбор новой фотки
                PhotosPicker(
                    selection: $selectedItem,
                    matching: .images,
                    photoLibrary: .shared()
                ) {
                    Text("Select a photo")
                }
                .onChange(of: selectedItem) { newItem in
                    Task {
        //                                   Retrive selected asset in the form of Data
                        if let data = try? await newItem?.loadTransferable(type: Data.self) {
                            selectedImageData = data
   //                         itemGroup.picture = data
                            
                        }
                    }
                }
                if let selectedImageData,
                   let uiImage = UIImage(data: selectedImageData) {

                    Image(uiImage: uiImage)
                        .resizable()
                        .scaledToFit()
                        .frame(width: 250, height: 250)
                }
                
                Button ( action: {
                    

// fucking nice code
                    let thaweditemGroup = itemGroup.thaw()
                    try! realm.write {
        //                thaweditemGroup?.name = "Uasya"
                        thaweditemGroup?.picture = selectedImageData
                    }
                    
                    
                    
//                    itemGroup.picture = selectedImageData
                    
 //                   let frozenDog = self.myDog.freeze()
                    // ---> pass frozenDog to other viewController

//                    let thawedDog = frozenDog.thaw()
//                    try! realm.write {
//                        thawedDog.age = 102
                    
  //                  var itemGroupthaw  = itemGroup.thaw()
 //                   itemGroup.picture = selectedImageData
                    
 //                   itemGroupthaw?.picture = selectedImageData
//
//                   $itemGroups.append(itemGroupthaw!)

                    
                    
 
         
                    dismiss()
                })
                {
                    Text("Записать изменения")
                }
                .frame(width: 650, alignment: .center)
                .buttonStyle(.bordered)
                
                Spacer()
            }
 //               .navigationTitle("Изменение записи")
            }
            .sheet(isPresented: $isPresented, content: {
  //              CRUDVIew(itemGroup: itemGroup)
            })
            .toolbar {
                ToolbarItem {
                    Button {
                        // action
                        isPresented = true
                    } label: {
                        Image(systemName: "plus")
                    }

                }
        }
           
        }
    
//    func uodateRealm() {
//
//        let realm = Realm()
//        try! realm.write {
////                       itemGroups(itemGroupthaw)
//        }
//    }
    
    }


//struct ItemsView_Previews: PreviewProvider {
//    static var previews: some View {
//
//        ItemsView(itemGroup: ItemGroups )
//    }
//}
