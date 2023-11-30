import Combine
import Foundation
import CoreData
class CatastropheRepositoryImpl: CatastropheRepository {
    func getCatastrophe() -> AnyPublisher<[Catastrophe]?, Error> {
        // Retrieve the _id from UserDefaults
    

        // Use the retrieved _id
       let getCatasropheEndpoint = CatastropheEndpoint.getCatastrophe.path.description

        return webServiceProvider.callWebService(
            url: NetworkConstants.baseURL + getCatasropheEndpoint,
            method: "GET",
            params: [:]
        )
        .eraseToAnyPublisher()
    }
    
    private let apiService: APIService
    private let webServiceProvider: WebServiceProvider

    required init(apiService: APIService, webServiceProvider: WebServiceProvider) {
           self.apiService = apiService
           self.webServiceProvider = webServiceProvider
       }


   

    

  


}
