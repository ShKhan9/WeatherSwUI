//
//  ContentView.swift
//  WeatherSwUI
//
//  Created by MacBook Pro on 12/13/20.
//  Copyright © 2020 MailMedia. All rights reserved.
//

import SwiftUI
  
struct MainView: View {
    @ObservedObject var vm = MainViewModel()
    @State private var fromServer = true {
        didSet{
            self.vm.getData(self.fromServer)
        }
    }
    var body: some View {
        let bind = Binding<Bool>(
           get:{self.fromServer},
           set:{self.fromServer = $0}
         )
       return GeometryReader { reader in
        VStack {
            HStack {  Text(city).font(.custom("TimesNewRomanPS-ItalicMT", size:21)).foregroundColor(Color.white)
                          Toggle(isOn:bind) {
                            Text("")
                          }
                       }.padding(20).frame(width: reader.size.width, height: 60, alignment: .leading).background(Color(UIColor.link))
            
            HStack {
                ForEach(self.vm.constants,id:\.self) { item in  Text(item).font(.custom("TimesNewRomanPS-BoldMT", size:17))  .frame(maxWidth: .infinity, alignment: .center).foregroundColor(Color.white)
                }
            }.frame(width: reader.size.width, height:50, alignment: .leading).background(Color(UIColor.gray))
            
             BottomView(arr:self.vm.result)
                      
        }
        }.onAppear {
            self.vm.getData(self.fromServer)
        }
    }
}
  
struct BottomView: View {
   var arr = [Main]()
   var body: some View {
    return GeometryReader { reader in
       List {
        ForEach(self.arr) { section  in  Section(header:Text(getDateFromTimeStamp(section.list.first!.dt)).font(.custom("TimesNewRomanPS-BoldMT", size:16))) {
            ForEach(section.list) { item  in
                MainListItem(withItem:item).frame(width: reader.size.width, height:CGFloat(40), alignment: .leading).padding(.leading,-25)
              }
            }
         }
        }.listStyle(GroupedListStyle())
      }
    }
}




struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        MainView()
    }
}

  
