
import SwiftUI

struct InformationView: View {
    @State var informations: [Information] = []
    @State private var isAddingInformation = false
    @State private var selectedInformation: Information?
    @StateObject private var commentInfoViewModel = CommentInfoViewModel()
    
    var body: some View {
        NavigationView {
            VStack {
                HStack {
                    Text("Blog")
                        .font(.title)
                        .foregroundColor(Color.blue)
                        .padding()
                    
                    Spacer()
                    Button(action: {
                        isAddingInformation = true
                    }) {
                        Image(systemName: "plus.circle.fill")
                            .font(.title)
                            .padding()
                            .frame(width: 20, height: 20)
                            .foregroundColor(Color.blue)
                            .imageScale(.large)
                    }
                    .padding()
                }
                ScrollView {
                    LazyVStack(spacing: 50) { // Ajouter un espacement vertical entre chaque carte
                        ForEach(informations) { info in
                            InformationCardView(information: info)
                                .onTapGesture {
                                    selectedInformation = info
                                }
                        }
                    }
                    .padding(.horizontal, 20) // Ajouter un espacement horizontal global
                    .padding(.top, 16)
                }
                .navigationBarHidden(true)
                
                .onAppear {
                    fetchInformation()
                }
                .sheet(item: $selectedInformation) { info in
                    InformationDetailView(information: info, CommentInfoViewModel: commentInfoViewModel)
                }
                .sheet(isPresented: $isAddingInformation) {
                    AddInfoView()
                }
            }
        }
        
    }
    
    
    
    
    
    
    
    
    struct InformationCardView: View {
        let information: Information
        
        var body: some View {
            VStack(spacing: 8) {
                AsyncImage(url: URL(string: information.image ?? "" )) { phase in
                    switch phase {
                    case .empty:
                        ProgressView()
                    case .success(let image):
                        image
                            .resizable()
                            .aspectRatio(contentMode: .fill)
                            .frame(height: 150)
                            .clipped()
                    case .failure:
                        Image(systemName: "Intro")
                            .resizable()
                            .aspectRatio(contentMode: .fill)
                            .frame(height: 150)
                            .clipped()
                    @unknown default:
                        EmptyView()
                    }
                }
               
                Spacer()
                
                Text(information.titre )
                    .font(.headline)
                    .foregroundColor(.black)
                    .fontWeight(.bold)
                    .padding(.horizontal, 16)
                
                Spacer()
                
                Text(information.descriptionInformation)
                    .font(.subheadline)
                    .foregroundColor(.gray)
                    .padding(.horizontal, 16)
            }
            .padding()
            .overlay(
                RoundedRectangle(cornerRadius: 12)
                    .stroke(Color.blue, lineWidth: 2)
            )
            .cornerRadius(12)
            .shadow(radius: 4)
            .frame(height: 300)
            
        }
    }
    

    
    
    
    struct InformationDetailView: View {
        var information: Information
        @State private var commentText: String = ""
        @State private var comments: [String] = []
        @ObservedObject var CommentInfoViewModel: CommentInfoViewModel
        
        @State private var isShareSheetPresented: Bool = false
        
        var body: some View {
            ScrollView {
                VStack(alignment: .center, spacing: 16) {
                    
                    HStack {
                        Text(information.titre )
                            .font(.headline)
                            .foregroundColor(.blue)
                            .fontWeight(.bold)
                            .padding(.horizontal, 16)
                        
                        Spacer()
                        
                        Button(action: {
                            isShareSheetPresented.toggle()
                        }) {
                            Image(systemName: "square.and.arrow.up")
                                .resizable()
                                .frame(width: 30, height: 30)
                                .foregroundColor(.black)
                                .padding()
                                .background(Color.white)
                                .cornerRadius(10)
                        }
                        .sheet(isPresented: $isShareSheetPresented) {
                            ShareSheet(activityItems: [information.titre , information.descriptionInformation])
                        }
                    }
                    .padding(.horizontal)
                    
                    AsyncImage(url: URL(string: information.image ?? "")) { phase in
                                                    switch phase {
                                                    case .empty:
                                                        ProgressView()
                                                    case .success(let image):
                                                        image
                                                            .resizable()
                                                            .aspectRatio(contentMode: .fill)
                                                            .frame(height: 150)
                                                            .clipped()
                                                    case .failure:
                                                        Image(systemName: "Intro")
                                                            .resizable()
                                                            .aspectRatio(contentMode: .fill)
                                                            .frame(height: 150)
                                                            .clipped()
                                                    @unknown default:
                                                        EmptyView()
                                                    }
                                                }
                        Spacer()
                        
                        
                        titleValueRow(title: "Type de catastrophe :", value: information.typeCatastrophe)
                        titleValueRow(title: "Pays :", value: information.pays)
                        titleValueRow(title: "Region :", value: information.region)
                        titleValueRow(title: "Etat :", value: information.etat)
                        titleValueRow(title: "Date de prevention :", value: formatDate(information.dateDePrevention))
                        titleValueRow(title: "Pourcentage de Fiabilité :", value: "\(information.pourcentageFiabilite )%")
                        
                        Section {
                            VStack(alignment: .leading, spacing: 8) {
                                Text("Description de catastrophe :")
                                    .font(.headline)
                                    .foregroundColor(.black)
                                    .padding(.horizontal)
                                
                                Text(information.descriptionInformation)
                                    .padding(.horizontal)
                                    .foregroundColor(.black)
                                    .frame(maxWidth: .infinity, alignment: .leading)
                                    .border(Color.black)
                                CommentButtonView1()
                                .padding()

                            }
                        }
                        HStack {
                            TextField("Tapez votre commentaire", text: $commentText)
                                .textFieldStyle(RoundedBorderTextFieldStyle())
                                .background(RoundedRectangle(cornerRadius: 10).fill(Color.blue.opacity(0.2)))
                                .padding()
                            
                            Button(action: {
                                CommentInfoViewModel.addComment(descriptionCommentaire: commentText, idInformation: information.id ?? "0")
                                commentText = ""
                                            }) {
                                Image(systemName: "arrow.right.circle.fill")
                                    .resizable()
                                    .frame(width: 30, height: 30)
                                    .foregroundColor(.white)
                                    .padding()
                                    .background(Color.blue)
                                    .cornerRadius(10)
                            }
                        }
                        .padding(.horizontal)
                        
                        
                    }
                    .padding()
                }
                .navigationBarTitle("Détails du Blog", displayMode: .inline)
            }
            struct ShareSheet: UIViewControllerRepresentable {
                let activityItems: [Any]
                let applicationActivities: [UIActivity]? = nil
                
                func makeUIViewController(context: Context) -> UIViewController {
                    let controller = UIActivityViewController(
                        activityItems: activityItems,
                        applicationActivities: applicationActivities
                    )
                    return controller
                }
                
                func updateUIViewController(_ uiViewController: UIViewController, context: Context) {}
            }
            
            private func formatDate(_ date: Date) -> String {
                let formatter = DateFormatter()
                formatter.dateStyle = .medium
                formatter.timeStyle = .none
                return formatter.string(from: date)
            }
            
            private func titleValueRow(title: String, value: String?) -> some View {
                HStack {
                    Text(title)
                        .bold()
                    Spacer()
                    if let unwrappedValue = value, !unwrappedValue.isEmpty {
                        Text(unwrappedValue)
                    } else {
                        Text("N/A")
                            .foregroundColor(.gray)
                    }
                }
                .padding(.horizontal)
            }
        }
    
    
        
        
        
        func fetchInformation() {
            guard let url = URL(string: "http://localhost:9090/information") else {
                print("Invalid URL")
                return
            }
            
            URLSession.shared.dataTask(with: url) { data, response, error in
                if let error = error {
                    print("Error fetching information: \(error)")
                    return
                }
                
                guard let data = data else {
                    print("No data received")
                    return
                }
                
                let decoder = JSONDecoder()
                let dateFormatter = DateFormatter()
                dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSS'Z'"
                dateFormatter.timeZone = TimeZone(identifier: "UTC")
                decoder.dateDecodingStrategy = .formatted(dateFormatter)
                
                do {
                    let informationArray = try decoder.decode([Information].self, from: data)
                    
                    DispatchQueue.main.async {
                        self.informations = informationArray
                    }
                } catch {
                    print("Error decoding information: \(error)")
                    if let jsonString = String(data: data, encoding: .utf8) {
                        print("Received JSON: \(jsonString)")
                    } else {
                        print("Unable to convert JSON data to string")
                    }
                }
            }.resume()
        }
   
        
        
        
        struct MyInformationView_Previews: PreviewProvider {
            static var previews: some View {
                InformationView()
            }
        }
    }
    
