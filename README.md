# Network Manager

## Description

This is a little package that I built to use on my personal projects.

The project is full open, so feel free to use :).

If you want either to give any suggestion or to report a bug, please fill an issue. Collaborations through PR are also welcome.

[This package was based on this tutorial from Malcolm Kumwenda](https://medium.com/flawless-app-stories/writing-network-layer-in-swift-protocol-oriented-approach-4fa40ef1f908)

## Usage

1. First, you create your endpoint.


```swift

struct PokemonEndpoint: NetworkRouterEndpoint {
    
    var baseURL: URL {
        return URL(string: "https://pokeapi.co")!
    }
    
    var path: String {
        return "/api/v2/pokemon/\(pokemonCode)"
    }
    
    var method: HTTPMethod {
        return .get
    }
    
    var task: HTTPTask {
        return .request
    }
    
    var pokemonCode: String
    
    init (pokemonName: String) {
        self.pokemonCode = pokemonName
    }
}

```

2. Then, you create your request model, which describes:

-  The Model Type of the data structure which the result data will be transformed into;
-  The Endpoint Type of the endpoint of your request
-  The endpoint to be reached on this request.

```swift

struct PokemonRequest: RequestModel {
    
    typealias ResultModel = PokemonDecodable
    
    typealias EndPoint = PokemonEndpoint
    
    var endpoint: PokemonEndpoint {
        return PokemonEndpoint(pokemonName: pokemonCode)
    }
    
    var pokemonCode: String
    
    init(pokemonName: String) {
        self.pokemonCode = pokemonName
    }
}

```

3. Finally, you create an object that can have access to a NetworkManager object type and execute the request.

```swift

class NetworkLayer {
    
    fileprivate var manager: NetworkManager = NetworkManager()
    
    static let shared: NetworkLayer = NetworkLayer()
    
    private init() {}
}

extension NetworkLayer: PokemonNetworkLayer {
    
    func request(pokemonWithName pokemonName: String, completion: @escaping (Result<Pokemon, Error>) -> Void) {
        
        let requestModel = PokemonRequest(pokemonName: pokemonName)
        
        manager.request(with: requestModel, cahcePolicy: .useProtocolCachePolicy, timeout: 10.0) { (result) in
            
            switch result {
                
                case .success(let model):
                    
                    do {
                        
                        let pokemon = try model.toPokemon()
                        
                        completion(.success(pokemon))
                        
                    } catch {
                        completion(.failure(error))
                    }
                
                case .failure(let error):
                    completion(.failure(error))
            }
        }
    }
}

```