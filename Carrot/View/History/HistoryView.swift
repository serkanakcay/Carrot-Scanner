//
//  HistoryView.swift
//  Carrot
//
//  Created by serkan on 17.09.2024.
//

import SwiftUI

struct HistoryView: View {
    var body: some View {
        NavigationStack{
            ZStack{
                LinearGradient(colors: [.bGcolor, .white], startPoint: .bottom, endPoint: .top)
                    .edgesIgnoringSafeArea(/*@START_MENU_TOKEN@*/.all/*@END_MENU_TOKEN@*/)
                VStack(alignment: .center){
                    
                    
                   
                        Image("marks")
                        
                            .fontDesign(.none)
                 
                                .padding()
                    HStack{
                        Text("Negative")
                            .padding(.leading)
                    }
                    VStack{
                        RoundedRectangle(cornerRadius: 10.0)
                            .fill(Color(.bGcolor).opacity(0.7))
                            .frame(maxWidth: .infinity, maxHeight: 70)
                            .overlay {
                                HStack{
                                    Image(systemName: "square.3.layers.3d.down.forward")
                                        .foregroundStyle(.gray)
                                        .font(.title2)
                                    VStack(alignment: .leading){
                                        Text("Enerji")
                                            .font(.title3)
                                        Text("Çok Şekerli")
                                            .font(.caption)
                                            .foregroundStyle(.gray)
                                    }
                                    Spacer() // HStack'teki boşluk
                                    Text("47 gr") // Sağa yaslandı
                                        .foregroundStyle(.gray)
                                    Circle()
                                        .fill(.red)
                                        .frame(width: 25, height: 25) // Sağa yaslandı
                                }
                                .padding(.horizontal)
                            }
                        RoundedRectangle(cornerRadius: 10.0)
                            .fill(Color(.bGcolor).opacity(0.7))
                            .frame(maxWidth: .infinity, maxHeight: 70)
                            .overlay {
                                HStack{
                                    Image(systemName: "square.3.layers.3d.down.forward")
                                        .foregroundStyle(.gray)
                                        .font(.title2)
                                    VStack(alignment: .leading){
                                        Text("Şeker")
                                            .font(.title3)
                                        Text("Çok Şekerli")
                                            .font(.caption)
                                            .foregroundStyle(.gray)
                                    }
                                    Spacer() // HStack'teki boşluk
                                    Text("47 gr") // Sağa yaslandı
                                        .foregroundStyle(.gray)
                                    Circle()
                                        .fill(.red)
                                        .frame(width: 25, height: 25) // Sağa yaslandı
                                }
                                .padding(.horizontal)
                            }
                        RoundedRectangle(cornerRadius: 10.0)
                            .fill(Color(.bGcolor).opacity(0.7))
                            .frame(maxWidth: .infinity, maxHeight: 70)
                            .overlay {
                                HStack{
                                    Image(systemName: "square.3.layers.3d.down.forward")
                                        .foregroundStyle(.gray)
                                        .font(.title2)
                                    VStack(alignment: .leading){
                                        Text("Doymuş Yağ")
                                            .font(.title3)
                                        Text("Çok Şekerli")
                                            .font(.caption)
                                            .foregroundStyle(.gray)
                                    }
                                    Spacer() // HStack'teki boşluk
                                    Text("47 gr") // Sağa yaslandı
                                        .foregroundStyle(.gray)
                                    Circle()
                                        .fill(.red)
                                        .frame(width: 25, height: 25) // Sağa yaslandı
                                }
                                .padding(.horizontal)
                            }
                        RoundedRectangle(cornerRadius: 10.0)
                            .fill(Color(.bGcolor).opacity(0.7))
                            .frame(maxWidth: .infinity, maxHeight: 70)
                            .overlay {
                                HStack{
                                    Image(systemName: "square.3.layers.3d.down.forward")
                                        .foregroundStyle(.gray)
                                        .font(.title2)
                                    VStack(alignment: .leading){
                                        Text("Tuz")
                                            .font(.title3)
                                        Text("Çok Şekerli")
                                            .font(.caption)
                                            .foregroundStyle(.gray)
                                    }
                                    Spacer() // HStack'teki boşluk
                                    Text("47 gr") // Sağa yaslandı
                                        .foregroundStyle(.gray)
                                    Circle()
                                        .fill(.red)
                                        .frame(width: 25, height: 25) // Sağa yaslandı
                                }
                                .padding(.horizontal)
                            }


                    }
                    .padding(.horizontal)

                   
                        
                        Spacer()
                    }
                    .toolbar(content: {
                        Image(systemName: "heart")
                    })
                    
                    
                }
                
            }
        }
    }


#Preview {
    HistoryView()
}
