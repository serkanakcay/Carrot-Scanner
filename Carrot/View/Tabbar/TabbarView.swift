//
//  TabbarView.swift
//  Carrot
//
//  Created by serkan on 17.09.2024.
//

import SwiftUI

struct TabbarView: View {
    @State private var selectedTab = 1

    var body: some View {
      
            TabView {
                HomeView()
                    .tabItem {
                        Image("Home")
                            .renderingMode(.template)
                        Text("Home")
                    }
                    .tag(0)
                
                FavoriteView()
                    .tabItem {
                        Image("Favorite")
                            .renderingMode(.template)
                        Text("Favorite")
                    }
                    .tag(1)
                
                ScannerView()
                    .tabItem {
                        Image("Scanner")
                        
                        
                    }
                    .tag(2)
                
               HistoryView()
                    .tabItem {
                        Image("Clock")
                            .renderingMode(.template)
                        Text("History")
                    }
                    .tag(3)
                
                ProfileView()
                    .tabItem {
                        Image("profile")
                            .renderingMode(.template)
                        Text("Profile")
                          
                    }
                    .tag(4)
            }
           
            .accentColor(Color.white)
            .font(.footnote)
            
        }
             
         }
     
           
       
#Preview {
    TabbarView()
}
