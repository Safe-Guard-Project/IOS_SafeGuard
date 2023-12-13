/*import SwiftUI
import MapKit

struct MapView: View {
    @State private var searchText = ""
    @State private var results = [MKMapItem]()
    @State private var mapSelection: MKMapItem?
    @State private var showDetails = false
    @State private var viewModel = CatastropheViewModel(apiManager: ApiManager.shared)

    var body: some View {
        Map(
            coordinateRegion: .constant(MKCoordinateRegion.centeredOn(viewModel.userLocation ?? CLLocationCoordinate2D(latitude: 0, longitude: 0), latitudinalMeters: 10000, longitudinalMeters: 10000)),

            showsUserLocation: true,
            userTrackingMode: .constant(.follow),
            annotationItems: viewModel.catastrophes,
            annotationContent: { catastrophe in
                MapPin(coordinate: CLLocationCoordinate2D(latitude: catastrophe.latitudeDeCatastrophe, longitude: catastrophe.longitudeDeCatastrophe), tint: .red)
            }
        )
        .onAppear {
            Task {
                await viewModel.fetchCatastrophes()
            }
        }
        .overlay(alignment: .top) {
            HStack {
                HStack {
                    TextField("Search for a location...", text: $searchText)
                        .font(.subheadline)
                        .padding(12)
                        .background(.white)
                        .padding()
                        .shadow(radius: 10)
                        .onChange(of: searchText) {
                            searchPlaces()
                        }
                    Button(action: {
                        // Center on user's location when the button is tapped
                        if let userLocation = viewModel.userLocation {
                            let region = MKCoordinateRegion(center: userLocation, latitudinalMeters: 10000, longitudinalMeters: 10000)
                            mapSelection = nil
                            showDetails = false
                            viewModel.fetchCatastrophes()
                            mapSelection = MKMapItem(placemark: MKPlacemark(coordinate: userLocation))
                            showDetails = true
                        }
                    }) {
                        Image(systemName: "location")
                            .foregroundColor(.blue)
                            .frame(width: 40, height: 40)
                            .background(Color.white)
                            .cornerRadius(22)
                            .shadow(radius: 5)
                    }
                    .padding(.leading, 0)
                }
                .padding(.trailing, 70)
            }
        }
        .onChange(of: mapSelection) { _, newValue in
            showDetails = newValue != nil
        }
        .sheet(isPresented: $showDetails) {
            LocationDetailsView(mapSelection: $mapSelection, show: $showDetails)
                .presentationDetents([.height(340)])
                .presentationBackgroundInteraction(.enabled(upThrough: .height(340)))
                .presentationCornerRadius(12)
        }
        .mapControls {
            MapCompass()
            MapPitchToggle()
        }
        .navigationBarBackButtonHidden(true)
        .navigationBarHidden(true)
    }

    func searchPlaces() {
        let request = MKLocalSearch.Request()
        request.naturalLanguageQuery = searchText
        let search = MKLocalSearch(request: request)
        search.start { response, _ in
            guard let response = response else { return }
            self.results = response.mapItems

            if let firstResult = response.mapItems.first {
                self.mapSelection = firstResult
            }
        }
    }
}

struct MapView_Previews: PreviewProvider {
    static var previews: some View {
        MapView()
    }
}

extension MKCoordinateRegion {
    static func centeredOn(_ center: CLLocationCoordinate2D, latitudinalMeters: CLLocationDistance, longitudinalMeters: CLLocationDistance) -> MKCoordinateRegion {
        return MKCoordinateRegion(
            center: center,
            latitudinalMeters: latitudinalMeters,
            longitudinalMeters: longitudinalMeters
        )
    }
}*/


