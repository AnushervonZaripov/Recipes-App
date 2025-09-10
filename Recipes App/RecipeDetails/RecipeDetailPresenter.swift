//
//  RecipeDetailPresenter.swift
//  Recipes App
//
//  Created by Aziza Azizova on 10/09/25.
//

import Foundation

protocol RecipeDetailView: AnyObject {
    func display(recipe: Recipe)
    func showError(_ message: String)
    func render(model: RecipeDetailModel)
}

class RecipeDetailPresenter {
    weak var view: RecipeDetailView?

    func attachView(_ view: RecipeDetailView) {
        self.view = view
    }

    func loadRecipe(id: Int) {
        let endpoint = Endpoint.recipeInformation(id: id, includeNutrition: false)
        guard let url = NetworkManager.shared.createURL(for: endpoint) else {
            view?.showError("Невозможно сформировать URL")
            return
        }

        NetworkManager.shared.makeTask(for: url, apiKey: API.apiKey) { (result: Result<RecipeDetailModel, NetworkError>) in
            DispatchQueue.main.async {
                switch result {
                case .success(let model):
                    self.view?.render(model: model)
                case .failure(let error):
                    let message: String
                    switch error {
                    case .invalidURL:
                        message = "Неверный URL"
                    case .decodingError:
                        message = "Ошибка декодирования данных"
                    case .noData:
                        message = "Нет данных от сервера"
                    case .serverError(let code):
                        message = "Ошибка сервера: \(code)"
                    }
                    self.view?.showError(message)
                }
            }
        }
    }
}
