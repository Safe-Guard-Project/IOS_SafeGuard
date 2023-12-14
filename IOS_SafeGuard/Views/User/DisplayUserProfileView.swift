import SwiftUI
import UIKit






struct ImagePicker: UIViewControllerRepresentable {
    @Binding var selectedImage: Image?

    class Coordinator: NSObject, UINavigationControllerDelegate, UIImagePickerControllerDelegate {
        @Binding var selectedImage: Image?

        init(selectedImage: Binding<Image?>) {
            _selectedImage = selectedImage
        }

        func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
            if let uiImage = info[.originalImage] as? UIImage {
                selectedImage = Image(uiImage: uiImage)
            }
            picker.dismiss(animated: true, completion: nil)
        }

        func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
            picker.dismiss(animated: true, completion: nil)
        }
    }

    func makeCoordinator() -> Coordinator {
        return Coordinator(selectedImage: $selectedImage)
    }

    func makeUIViewController(context: Context) -> UIImagePickerController {
        let picker = UIImagePickerController()
        picker.delegate = context.coordinator
        return picker
    }

    func updateUIViewController(_ uiViewController: UIImagePickerController, context: Context) {}
}

#if DEBUG
struct ImagePicker_Previews: PreviewProvider {
    static var previews: some View {
        ImagePicker(selectedImage: .constant(nil))
    }
}
#endif
struct DisplayUserProfileView: View {
    let defaults = UserDefaults.standard
    
    private var username: String {
        UserDefaults.standard.string(forKey: "UserName") ?? ""
    }
    
    private var email: String {
        UserDefaults.standard.string(forKey: "email") ?? ""
    }
    
    private var phoneNumber: String {
        UserDefaults.standard.string(forKey: "numeroTel") ?? ""
    }
    @StateObject private var viewModel: DisplayUserProfileViewModel

    @State private var selectedImage: Image?
    @State private var isImagePickerPresented = false
    init() {
          self._viewModel = StateObject(wrappedValue: DisplayUserProfileViewModel())
      }
   
    
    var body: some View {
        NavigationView {
            VStack {
                VStack {
                    GeometryReader { geometry in
                        if let selectedImage = selectedImage {
                            selectedImage
                                .resizable()
                                .aspectRatio(contentMode: .fit)
                                .frame(width: geometry.size.width, height: 100)
                        } else {
                            Image("Person")
                                .resizable()
                                .aspectRatio(contentMode: .fit)
                                .frame(width: geometry.size.width, height: 100)
                                .padding(.bottom, 50)
                        }
                    }
                }
                
                Text("Username:")
                    .font(.headline)
                    .padding(.leading, 16)
                Text(username)
                    .font(.subheadline)
                    .foregroundColor(.gray)
                    .padding(.leading, 16)
                
                Text("Email:")
                    .font(.headline)
                    .padding(.leading, 16)
                Text(email)
                    .font(.subheadline)
                    .foregroundColor(.gray)
                    .padding(.leading, 16)
                
                Text("Phone Number:")
                    .font(.headline)
                    .padding(.leading, 16)
                Text(phoneNumber)
                    .font(.subheadline)
                    .foregroundColor(.gray)
                    .padding(.leading, 16)
                
                Button("Select Image") {
                    isImagePickerPresented.toggle()
                }
                .padding()
                
                .sheet(isPresented: $isImagePickerPresented) {
                    ImagePicker(selectedImage: $selectedImage)
                }
                
                Button("Save") {
                    saveImageToBackend()
                }
                .padding()
                
                NavigationLink(destination: FavoriView()) {
                    Text("Your Favorites")
                        .font(.headline)
                        .foregroundColor(.blue)
                        .padding(.leading, 16)
                }
                NavigationLink(destination: ProfileView()) {
                    Text("Your Blogs")
                        .font(.headline)
                        .foregroundColor(.blue)
                        .padding(.leading, 16)
                }
            }
            .padding(8)
            .onAppear {
                // Fetch user information when the view appears
            }
            .navigationBarTitle("My Profile")
            .navigationBarHidden(true)
            .background(Color("BlueBackground"))
        }
    }
    
    private func saveImageToBackend() {
        guard let uiImage = UIImage.from(selectedImage) else {
            print("Error: Couldn't convert SwiftUI Image to UIImage.")
            return
        }
        
        // Convert UIImage to Data
        guard let imageData = uiImage.jpegData(compressionQuality: 0.8) else {
            print("Error: Couldn't convert UIImage to Data.")
            return
        }
        
        // Call the UserRepository to save the image
        viewModel.saveUserProfileImage(imageData: imageData)
    }
}

extension UIImage {
    static func from(_ image: Image?) -> UIImage? {
        guard let image = image else { return nil }
        #if canImport(UIKit)
        var uiImage: UIImage

        if let uiImageRepresentation = image.asUIImage(),
           let imageData = uiImageRepresentation.pngData(),
           let convertedImage = UIImage(data: imageData) {
            uiImage = convertedImage
        } else {
            // Handle the case where the conversion or pngData() is nil
            print("Error: Unable to convert Image to UIImageRepresentation.")
            // Provide a default UIImage or handle the error as needed
            uiImage = UIImage(systemName: "photo") ?? UIImage()
        }

        return uiImage
        #else
        fatalError("Unsupported platform")
        #endif
    }
}


extension Image {
    func asUIImage() -> UIImage? {
        #if canImport(UIKit)
        let controller = UIHostingController(rootView: self)
        let view = controller.view
        let renderer = UIGraphicsImageRenderer(size: view!.bounds.size)
        return renderer.image { context in
            view!.drawHierarchy(in: view!.bounds, afterScreenUpdates: true)
        }
        #else
        fatalError("Unsupported platform")
        #endif
    }
}
struct DisplayUserProfileView_Previews: PreviewProvider {
    static var previews: some View {
        DisplayUserProfileView()
    }
}

