// ApiManager.swift
import Combine
class ApiManager: APIService {
    static let shared = ApiManager()

    private init() {}

    func signUp(user: User) -> AnyPublisher<User?, Error> {
        let signUpEndpoint = UserEndpoints.signUp.path.description
        print("URL: \(NetworkConstants.baseURL + signUpEndpoint)")

        let params: [String: Any] = [
            "UserName": user.UserName,
            "email": user.email,
            "password": user.password,
            "numeroTel": user.numeroTel,
        ]
        print("Params: \(params)")

        return WebServiceProvider.shared.callWebService(url: NetworkConstants.baseURL + signUpEndpoint,
                                                        method: "POST",
                                                        params: params) as AnyPublisher<User?, Error>
    }
        
    
    func getCatastrophes() -> AnyPublisher<[Catastrophe]?, Error> {
           return CatastropheRepositoryImpl().getCatastrophes()
       }
    
    
    
}
