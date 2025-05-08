import '../../home/model/models/products_model.dart';

abstract class FavoriteState {}

class FavoriteInitial extends FavoriteState {}

class FavoriteLoading extends FavoriteState {}

class FavoriteLoaded extends FavoriteState {
  final List<ProductsModel> allFavorites;
  final List<ProductsModel> filteredFavorites;
  final String searchQuery;

  FavoriteLoaded(
      {required this.allFavorites,
      required this.filteredFavorites,
      this.searchQuery = ''});
}
