
import SwiftUI
/*
struct FavoriView: View {
    let courses = [
        Cours(type:"cause" ,image:"cause",description:"Un tsunami est généralement provoqué par un séisme sous-marin, une éruption volcanique ou un glissement de terrain sous-marin, déplaçant brusquement de grandes quantités d eau et générant des vagues dévastatrices."),
        
        
    ]
    
    var body: some View {
        NavigationView {
            VStack {
                HStack {
                    Spacer()
                    Image(systemName: "heart.fill")
                        .resizable()
                        .frame(width: 30, height: 30)
                        .foregroundColor(.blue)
                        .padding(.top, 16)
                }
                .padding(.horizontal)
                
                Text("Liste des Favoris")
                    .font(.title)
                    .fontWeight(.bold)
                    .foregroundColor(.blue)
                    .padding(.top, 8)

                Spacer()

              

                //Text("Aucun élément dans les favoris.")
                   // .font(.body)
                    //.foregroundColor(.gray)
                    //.padding(.bottom, 32)

                Spacer()
                VStack {
                    List {
                        ForEach(courses) { index in
                           FavoriCardView(cours: index)
                                .listRowInsets(EdgeInsets(top: 2, leading: 5, bottom: 4, trailing: 4))
                                .background(Color(UIColor.systemBackground))
                        }
                    }
                    .listStyle(PlainListStyle())
                
                    .navigationBarTitleDisplayMode(.large)

                   
                }
            }
            .navigationBarTitleDisplayMode(.inline)
        }
    }
}

#Preview {
    FavoriView()
}

*/
