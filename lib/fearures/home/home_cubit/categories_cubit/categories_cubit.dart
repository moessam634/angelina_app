import 'package:bloc/bloc.dart';
import '../../model/data/home_data.dart';
import 'categories_state.dart';

class CategoriesCubit extends Cubit<CategoriesState> {
  CategoriesCubit(this._homeData) : super(CategoriesInitial());
  final HomeData _homeData;

  Future<void> getCategories() async {
    if(!isClosed)emit(CategoriesLoadingState());
    try {
      final categoriesList = await _homeData.getCategories();
      if(!isClosed)   emit(CategoriesSuccessState(data: categoriesList));
    } catch (e) {
      if(!isClosed) emit(CategoriesErrorState(errorMessage: e.toString()));
    }
  }
}
