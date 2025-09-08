//
//  HomePresenter.swift
//  Recipes App

final class HomePresenter {
    
    weak var view: HomeViewProtocol?

#warning("это что?")
    private var trendingRecipes = ["How to shawrama at home", "How at home", "How to shawrama at home", "How to shawrama at home"]

#warning("это лучше вынести в отдельный enum")
    private var popularCategories = ["Salad", "Breakfast", "Appetizer", "Lunch"]

    private var detailedCategories = ["Chicken and Vegetable wrap", "Chicken and Vegetable wrap", "Chicken and Vegetable wrap", "Chicken and Vegetable wrap"]
    private var recentRecipes = ["Kelewele Ghanian Recipe", "Kelewele Ghanian Recipe", "Kelewele Ghanian Recipe"," Kelewele Ghanian Recipe"]
    
    init(view: HomeViewProtocol) {
        self.view = view
    }
    
    func getTrendingCount() -> Int { trendingRecipes.count }
    func getTrendingItem(at index: Int) -> String { trendingRecipes[index] }
    
    func getCategoriesCount() -> Int { popularCategories.count }
    func getCategory(at index: Int) -> String { popularCategories[index] }
    
    func getDetailedCount() -> Int { detailedCategories.count }
    func getDetailedItem(at index: Int) -> String { detailedCategories[index] }
    
    func getRecentCount() -> Int { recentRecipes.count }
    func getRecentItem(at index: Int) -> String { recentRecipes[index] }
    
    // обработка выбора категории
    func didSelectCategory(at index: Int) {
        // можно добавить логику фильтрации по категории
        print("Selected category: \(popularCategories[index])")
    }
}
