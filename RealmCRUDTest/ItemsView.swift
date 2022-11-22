//
//  ItemsView.swift
//  RealmCRUDTest
//
//  Created by John Doe on 22/11/2022.
//

import SwiftUI
import RealmSwift
import PhotosUI

struct ItemsView: View {
    
    @ObservedRealmObject var itemGroup: ItemGroup
    @ObservedResults(ItemGroup.self) var itemGroups
    
    @State private var isPresented: Bool = false
    
    @State private var selectedItem: PhotosPickerItem? = nil
    @State private var selectedImageData: Data? = nil
    
    @Environment(\.dismiss) private var dismiss
    
    var body: some View {
        
        NavigationView {
            VStack {
                Text("Старые данные")
                Text(itemGroup.name)
           
                
                if let selectedImageData = itemGroup.picture,
                   let uiImage = UIImage(data: selectedImageData) {
                    Image(uiImage: uiImage)
                        .resizable()
                        .scaledToFit()
                        .frame(width: 250, height: 250)
                }
                Divider()
                
                Text("Новые данные")
                TextField("Новая группа", text: $itemGroup.name)
                
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
                    

 //                   itemGroup.picture = selectedImageData
                    
                    $itemGroups.append(itemGroup)
                  
                    
 
         
                    dismiss()
                })
                {
                    Text("Записать изменения")
                }
                .frame(width: 650, alignment: .center)
                .buttonStyle(.bordered)
                
            }
                .navigationTitle("Изменение записи")
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
    }


//struct ItemsView_Previews: PreviewProvider {
//    static var previews: some View {
//
//        ItemsView(itemGroup: ItemGroups )
//    }
//}
