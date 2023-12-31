

import SwiftUI
import MapKit


struct MapView: View {
    @State private var cameraPosition: MapCameraPosition = .region(.userRegion)
    @State private var searchText = ""
    @State private var results = [MKMapItem]()
    @State private var mapSelection: MKMapItem?
    @State private var showDetails =  false
    @StateObject private var catastropheViewModel = CatastropheViewModel()
    @StateObject private var zoneDeDangerviewModel = ZoneDeDangerViewModel()
    @State private var getDirections = false
    @State private var routeDisplaying = false
    @State private var route: MKRoute?
    @State private var routeDestination: MKMapItem?
    
    var body: some View {
        Map(position: $cameraPosition, selection: $mapSelection){
            //      Marker("My location",systemImage: "paperplane", coordinate: .userLocation)
            //     .tint(.blue)
            Annotation("My location", coordinate: .userLocation){
                ZStack {
                    Circle()
                        .frame (width:32, height: 32)
                        .foregroundColor (.blue.opacity(0.25))
                    Circle()
                        .frame (width: 20, height: 20)
                        .foregroundColor (.white)
                    
                    Circle()
                        .frame (width: 12, height: 12)
                        .foregroundColor (.blue)
                }
            }
            ForEach(results, id: \.self) { item in
                if routeDisplaying {
                    let placemark = item.placemark
                    Marker(placemark.name ?? "", coordinate: placemark.coordinate)
                }else {
                    let placemark = item.placemark
                    Marker(placemark.name ?? "", coordinate: placemark.coordinate)
                    
                }
                
            }
            if let route {
                MapPolyline(route.polyline)
                    .stroke(.blue, lineWidth: 6)
            }
            ForEach(catastropheViewModel.catastrophes, id: \.self) { catastrophe in
                let staticRadius: CGFloat = 10 // Set your desired static radius value

                Annotation("catastrophe", coordinate: .init(latitude: catastrophe.latitudeDeCatastrophe, longitude: catastrophe.longitudeDeCatastrophe)) {
                    Circle()
                        .frame(width: staticRadius * 2, height: staticRadius * 2)
                        .foregroundColor(.red.opacity(0.5))
                }
            

            }
            
          
            
            ForEach(zoneDeDangerviewModel.zone, id: \.self) { zoned in
                Marker("Danger", systemImage: "marker", coordinate: .init(latitude: zoned.latitudeDeZoneDanger, longitude: zoned.longitudeDeZoneDanger))
                    .tint(.red)
            }

        }
        
        .overlay(alignment: .top) {
                       HStack {
                           HStack {
                          

                           TextField("Search for a location...", text: $searchText)
                               .font(.subheadline)
                               .padding (12)
                               .background(.white)
                               .padding()
                               .shadow(radius: 10)
                               .onChange(of: searchText) {
                                   searchPlaces()
                               }
                               .onChange(of: getDirections, {oldValue,newValue in
                                   if newValue {
                                       fetchRoute()
                                   }
                                   
                               })
                               Button(action: {
                                          cameraPosition = .region(.userRegion)
                                      }) {
                                          Image(systemName: "location")
                                            
                                              .foregroundColor(.blue)
                                              .frame(width: 40, height: 40)
                                              .background(Color.white)
                                              .cornerRadius(22)
                                              .shadow(radius: 5)
                                      }

                                      .padding(.leading,0)
                                  }
                    
                           
                           .padding(.trailing, 70)
                       }
                   }
                   .onChange(of: mapSelection, { oldValue, newValue in
                       showDetails = newValue != nil
                   })
                   .sheet(isPresented: $showDetails, content: {
                       LocationDetailsView(mapSelection: $mapSelection, show: $showDetails,getDirections : $getDirections)
                           .presentationDetents ([.height (340)])
                           .presentationBackgroundInteraction(.enabled(upThrough: .height(340)))
                           .presentationCornerRadius (12)
                   })
                       
        
                   .mapControls {
                       MapCompass()
                       MapPitchToggle()

                   
                   }
                   .onAppear {
                       catastropheViewModel.getCatastrophes()
                       zoneDeDangerviewModel.getZoneDeDangers()
                      }
     
       }

    }
           



extension MapView {
    func searchPlaces() {
        let request = MKLocalSearch.Request ()
        request.naturalLanguageQuery = searchText
        request.region = .userRegion
        let search = MKLocalSearch(request: request)
        search.start { response, _ in
            guard let response = response else { return }
            self.results = response.mapItems

            // Navigate to the first search result
            if let firstResult = response.mapItems.first {
                self.mapSelection = firstResult
                self.cameraPosition = .region(.init(center: firstResult.placemark.coordinate, latitudinalMeters: 1000, longitudinalMeters: 1000))
            }
        }
    }
    func fetchRoute() {
        if let mapSelection = mapSelection { // Add the missing condition
            let request = MKDirections.Request()
            request.source = MKMapItem(placemark: .init(coordinate: .userLocation))
            request.destination = mapSelection
            Task {
                let result = try? await MKDirections(request: request).calculate()
                route = result?.routes.first
                routeDestination = mapSelection
                withAnimation(.snappy) {
                    routeDisplaying = true
                    showDetails = false
                    if let rect = route?.polyline.boundingMapRect, routeDisplaying {
                        cameraPosition = .rect(rect) // Update 'MapCameraPosition' to 'cameraPosition'
                    }
                }
            }
        }
    }
}




                                    
                           
                           
                           
                           
extension CLLocationCoordinate2D {
    static var userLocation: CLLocationCoordinate2D {
        return .init(latitude: 36.901000, longitude: 10.190120)
    }
}

extension MKCoordinateRegion {
    static var userRegion: MKCoordinateRegion {
        return .init(center: .userLocation,
                     latitudinalMeters: 10000,
                     longitudinalMeters: 10000)
    }
}


#Preview {
    MapView()
}
