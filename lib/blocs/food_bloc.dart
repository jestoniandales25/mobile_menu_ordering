import 'package:flutter/foundation.dart';
import 'package:mobile_menu_ordering/data/models/food_model.dart';
import 'package:mobile_menu_ordering/data/repositories/food_repository.dart';


enum FoodState { idle, loading, success, error }

class FoodBloc extends ChangeNotifier {
  final FoodRepository _repo;

  FoodBloc(this._repo);

  List<FoodModel> _allFoods = [];
  List<FoodModel> _filteredFoods = [];
  FoodState _state = FoodState.idle;
  String? _error;
  String _selectedCategory = 'all';
  String _searchQuery = '';

  // Getters
  List<FoodModel> get foods => _filteredFoods;
  FoodState get state => _state;
  String? get error => _error;
  bool get isLoading => _state == FoodState.loading;
  String get selectedCategory => _selectedCategory;

  Future<void> loadFoods([String category = 'all']) async {
    _selectedCategory = category;
    _state = FoodState.loading;
    _error = null;
    notifyListeners();

    try {
      _allFoods = await _repo.fetchFoods(category);
      _applySearch();
      _state = FoodState.success;
    } catch (e) {
      _error = e.toString();
      _state = FoodState.error;
    }

    notifyListeners();
  }

  void search(String query) {
    _searchQuery = query.toLowerCase();
    _applySearch();
    notifyListeners();
  }

  void _applySearch() {
    if (_searchQuery.isEmpty) {
      _filteredFoods = List.from(_allFoods);
    } else {
      _filteredFoods = _allFoods.where((food) {
        return food.name.toLowerCase().contains(_searchQuery) ||
            (food.description?.toLowerCase().contains(_searchQuery) ?? false) ||
            (food.country?.toLowerCase().contains(_searchQuery) ?? false);
      }).toList();
    }
  }

  void retry() => loadFoods(_selectedCategory);
}