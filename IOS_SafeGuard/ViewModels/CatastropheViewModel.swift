
import Foundation
import Combine

class CatastropheViewModel: ObservableObject {
    // Replace this with your actual data
    @Published var catastrophes: [Catastrophe] = [
        Catastrophe(
            _id: "1",
            titre: "Earthquake",
            type: "Earthquake",
            tsunami: 0,
            description: "Major earthquake in a populated area",
            date: Date(),
            radius: 0.0,
            magnitude: 7.5,
            latitudeDeCatastrophe: 0.0,
            longitudeDeCatastrophe: 0.0,
            createdAt: Date(),
            updatedAt: Date()
        ),
        Catastrophe(
            _id: "2",
            titre: "Flood",
            type: "Flood",
            tsunami: 0,
            description: "Flash flood in a coastal region",
            date: Date(),
            radius: 0.0,
            magnitude: 5.8,
            latitudeDeCatastrophe: 0.0,
            longitudeDeCatastrophe: 0.0,
            createdAt: Date(),
            updatedAt: Date()
        ),
        Catastrophe(
            _id: "3",
            titre: "Wildfire",
            type: "Wildfire",
            tsunami: 0,
            description: "Large-scale wildfire in a forested area",
            date: Date(),
            radius: 0.0,
            magnitude: 6.2,
            latitudeDeCatastrophe: 0.0,
            longitudeDeCatastrophe: 0.0,
            createdAt: Date(),
            updatedAt: Date()
        ),
        // Add more static data as needed
    ]

    func getCatastrophes() {
        // You can leave this empty since you are using static data
    }
}

