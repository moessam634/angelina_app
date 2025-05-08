import '../../model/models/categories_model.dart';

sealed class CategoriesState {}

final class CategoriesInitial extends CategoriesState {}

final class CategoriesLoadingState extends CategoriesState {}

class CategoriesSuccessState extends CategoriesState {
  final List<CategoriesModel> data;

  CategoriesSuccessState({
    required this.data,
  });
}

final class CategoriesErrorState extends CategoriesState {
  final String errorMessage;

  CategoriesErrorState({required this.errorMessage});
}
