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
        NetworkManager.shared.getRecipeDetails(id: id) { result in
            DispatchQueue.main.async {
                switch result {
                case .success(let model):
                    self.view?.render(model: model)
                case .failure(let error):
                    self.view?.showError("Ошибка: \(error)")
                }
            }
        }
    }
}

        
       
