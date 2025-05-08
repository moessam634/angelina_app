import 'package:angelinashop/fearures/switcher/cubit/switcher_state.dart';
import 'package:bloc/bloc.dart';

class SwitcherCubit extends Cubit<SwitcherState> {
  SwitcherCubit() : super(SwitcherInitial());
  int currentIndex = 0;

  void changeScreen(value) {
    currentIndex = value;
    emit(SwitcherUpdate());
  }
}
