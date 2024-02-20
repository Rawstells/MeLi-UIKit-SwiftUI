//
//  ProductsViewModel.swift
//  MercadoLibre-UIKit
//
//  Created by Joan Narvaez on 17/02/24.
//

import Foundation
import Combine

enum SearchProductViewModelOutput: Equatable {
    case none
    case isLoading(Bool)
    case didGetData([ProductResultResponse])
    case errorMessage(String)
}

class ProductsViewModel {
    @Published var products: [ProductResultResponse] = []
    @Published var outputEvents: SearchProductViewModelOutput = .none

    private var repository: ProductsRepositoryProtocol
    private var router: ProductsRouter

    init(repository: ProductsRepositoryProtocol,
          router: ProductsRouter) {
        self.repository = repository
        self.router = router
    }

    @MainActor
    func getProducts(product: String) async {
        do {
            let productResponse: [ProductResultResponse] = try await repository.getProducts(product: product)
            outputEvents = .isLoading(false)
            outputEvents = .didGetData(productResponse)
            products = productResponse
        } catch {
            outputEvents = .isLoading(false)
            outputEvents = .errorMessage("Ha ocurrido un error, reintenta más tarde")
        }
        // save()
    }
    
    func goToProductDescription(product: ProductResultResponse, products: [ProductResultResponse]) {
        router.handle(transition: .showProductDescription(product: product, products: products))
    }

   /* func load() {
        guard let data = UserDefaults.standard.data(forKey: "pokemons"),
              let savedTasks = try? JSONDecoder().decode(PokemonResponse.self, from: data) else {
            productResponse.results = []
            return
        }
        pokemonResponse = savedTasks
    }

    func save() {
        do {
            let data = try JSONEncoder().encode(productResponse)
            UserDefaults.standard.set(data, forKey: "pokemons")
        } catch {
            print(error)
        }
    }
*/
}
