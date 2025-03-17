//
//  HomeView.swift
//  Carrot
//
//  Created by serkan on 13.03.2025.
//

import SwiftUI

struct HomeView: View {
    var body: some View {
        NavigationStack{
            VStack(alignment: .leading, spacing: 15){
                PaywallHomeHeaderView()
                Text("Recommended For You")
                    .font(.headline)
                Spacer()
            }
            .padding(.top, 10)
        
            .toolbar {
        ToolbarItem(placement: .navigationBarTrailing) {
            Button(action: {
          print("Search tapped")
           }) {
           Image(systemName: "magnifyingglass")
                             }
                         }
                ToolbarItem(placement: .navigationBarLeading) {
               Text("Hello, Serkan 👋🏻")
                        .font(.title2)
                                     }
                                 }
                     }
        .accentColor(.white)
    }
      
        
       
    }


#Preview {
    HomeView()
}
