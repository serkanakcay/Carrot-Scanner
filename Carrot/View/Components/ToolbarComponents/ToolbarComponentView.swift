import SwiftUI

struct ToolbarComponentView: View {
    @State var searchText = ""
    var body: some View {
        HStack {
            // Sol tarafta arama çubuğu
            HStack {
                Image(systemName: "magnifyingglass")
                    .foregroundColor(.gray)
                TextField("Kontrol etmek istediğiniz ürün?", text: $searchText)
                    
                    .frame(maxWidth: .infinity) // TextField'in tüm alanı kaplamasını sağlar
            }
            .padding(2)
            .background(Color(.systemGray6))
            .cornerRadius(5)

            Spacer() // HStack'in diğer bileşenlerine boşluk eklemek için Spacer kullanıyoruz.

            // Sağ tarafta bildirim simgesi
            Button(action: {
                // Bildirim simgesine tıklandığında yapılacak işlem
                print("Bildirimlere tıklandı")
            }) {
                ZStack {
                    Image("Menus")
                        .foregroundColor(.orange)
                    Circle()
                        .fill(Color.red)
                        .frame(width: 10, height: 10)
                        .offset(x: 10, y: -10)
                }
            }
        }
        .padding() // HStack'e yatayda dolgu ekleyerek bileşenlerin ekrana yaslanmasını engelliyoruz
    }
}

#Preview {
    ToolbarComponentView()
}
