//
//  TabbarView.swift
//  Carrot
//
//  Created by serkan on 17.09.2024.
//

import SwiftUI

struct TabbarView: View {
    var body: some View {
        ZStack {
                   VStack {
                       // TabView üstüne çizgi eklemek için
                       Rectangle()
                           .fill(Color.gray.opacity(0.7))
                           .frame(height: 2)
                           .edgesIgnoringSafeArea(.top)

                       TabView(selection: .constant(3)) {
                           HistoryView()
                               .tabItem {
                                   Image(systemName: "clock.arrow.circlepath")
                                   Text("History")
                               }
                               .tag(1)
                           
                           HistoryView()
                               .tabItem {
                                   Image(systemName: "rectangle.grid.2x2")
                                   Text("Overview")
                               }
                               .tag(2)
                           
                           ScannerView()
                               .tabItem {
                                   VStack {
                                       ZStack {
                                           Circle()
                                               .fill(Color.green)
                                               .frame(width: 40, height: 40)
                                           Image(systemName: "barcode.viewfinder")
                                               .foregroundColor(.white)
                                       }
                                       Text("Scanner")
                                   }
                               }
                               .tag(3)
                           
                           HistoryView()
                               .tabItem {
                                   Image(systemName: "lightbulb")
                                   Text("Lead")
                               }
                               .tag(4)
                           
                           HistoryView()
                               .tabItem {
                                   Image(systemName: "person.crop.circle")
                                   Text("Profile")
                               }
                               .tag(5)
                       }
                       .accentColor(.gray.opacity(0.7))
                   }
               }
           }
       }
#Preview {
    TabbarView()
}
