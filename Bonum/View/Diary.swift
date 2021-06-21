//
//  Diary.swift
//  Bonum
//
//  Created by Alexandre Dias Da Silva on 11/06/2021.
//

import SwiftUI

struct Diary: View {
    
    @EnvironmentObject var userData: UserData
    
    func delete(at offsets: IndexSet) {
        userData.userElementsList.remove(atOffsets: offsets)
        userData.writeJson(tab: userData.userElementsList, filename: "ElementsList")
        userData.userElementsList = readJson(filename: "ElementsList") ?? [DataElement]()
    }
    
    func readJson<MonType: Codable>(filename : String) -> MonType?{
        let decoder = JSONDecoder()
        do{
            if let url = LocalFileManager.instance.getPathForJson(name: filename) {
                let data = try Data(contentsOf: url)
                let result = try decoder.decode(MonType.self, from: data)
                return result
            }
            
            return nil
            
        } catch {
            print(error)
            return nil
        }
        
    }
    
    @State private var showingAddForm = false
    
    //mène à rien
    @State private var timeArea : String = "J"
    var allTimes = ["J", "S", "M", "A"]
    
    var body: some View {
        NavigationView{
            VStack{
                //TODO: Switch J/S/M/A
                Picker("", selection: $timeArea) {
                    ForEach(allTimes, id: \.self) {
                        Text($0)
                    }
                }.pickerStyle(SegmentedPickerStyle())
                .padding()
                
                HStack{
                    Text("Aujourd'hui,").font(.title)
                        .padding()
                    Spacer()
                    
                    Button(action: {
                        showingAddForm = true
                    }) {
                        Image(systemName: "plus")
                            .font(Font.system(.title))
                            .foregroundColor(.orange)
                            .padding()
                    }.sheet(isPresented: $showingAddForm) {
                        AddElement()
                    }
                    
                }
                
                //TODO : display score calculé
                ScoreBonum()
                
                List{
                    ForEach(Array(userData.userElementsList.enumerated()), id: \.1.id) {index, el in
                        
                        NavigationLink(
                            destination: DiaryListDetails(element: userData.userElementsList[index]),
                            label: {
                                HStack{
                                    DiaryListCell(element: userData.userElementsList[index])
                                    
                                    Button {
                                        delete(at: [index])
                                    } label: {Image(systemName: "xmark")
                                    }
                                    .buttonStyle(PlainButtonStyle())
                                    
                                }
                            }
                        )
                    }.onDelete(perform: delete)
                    
                }
            }.navigationBarHidden(true)
            .navigationTitle("Journal")
            .listStyle(PlainListStyle())
        }
    }
}

//struct Diary_Previews: PreviewProvider {
//    static var previews: some View {
//        Diary()
//    }
//}
