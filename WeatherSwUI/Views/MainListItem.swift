//
//  MainListItem.swift
//  WeatherSwUI
//
//  Created by MacBook Pro on 12/13/20.
//  Copyright © 2020 MailMedia. All rights reserved.
//

import SwiftUI
import Combine

struct MainListItem: View {
    
    @ObservedObject var imageLoader:ImageLoader
    
    @State var image:UIImage = UIImage()
    
    var item:Content
     
    init(withItem con:Content) {
        self.item = con
        imageLoader = ImageLoader(urlString:"https://openweathermap.org/img/wn/" + self.item.weather.first!.icon + "@2x.png")
    }

    var body: some View {
      return GeometryReader { reader in
        HStack {
            Text(getTimeFromTimeStamp(self.item.dt)).frame(maxWidth: .infinity, alignment: .center)
            Image(uiImage: self.image)
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(width:50, height:50)
                .onReceive(self.imageLoader.didChange) { data in
                   self.image = UIImage(data: data) ?? UIImage()
                }.frame(maxWidth: .infinity, alignment: .center)
        Text("\(fromKelvinToCelsius(self.item.main.temp))")  .frame(maxWidth: .infinity, alignment: .center)
        Text("\(self.item.wind.speed, specifier: "%.2f")").frame(maxWidth: .infinity, alignment: .center)
        }
        .frame(width:reader.size.width, height: 50, alignment: .leading)
      }
    }
}
 

class ImageLoader: ObservableObject {
    var didChange = PassthroughSubject<Data, Never>()
    var data = Data() {
        didSet {
            didChange.send(data)
        }
    }

    init(urlString:String) {
        guard let url = URL(string: urlString) else { return }
        let task = URLSession.shared.dataTask(with: url) { data, response, error in
            guard let data = data else { return }
            DispatchQueue.main.async {
                self.data = data
            }
        }
        task.resume()
    }
}
