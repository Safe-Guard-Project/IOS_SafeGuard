enum CatastropheEndpoint {
    case getCatastrophe
    case path

    var path: String {
        switch self {
        case .getCatastrophe:
            return "catastrophe" // Adjust the actual path accordingly
        case .path:
            return "catastrophe" // Adjust the actual path accordingly
        }
    }

    var httpMethod: String {
        switch self {
        case .getCatastrophe:
            return "GET"
        case .path:
            return "GET" // or another default value for .path
        }
    }
}
