import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shefaa/core/extensions/safe_emit.dart';

class BottomNavigationCubit extends Cubit<int> {
  BottomNavigationCubit() : super(0);
  int selectedPage = 0;
  void init([int? initially]) => changePage(initially);
  void changePage(int? index) {
    if (index == null) return;
    selectedPage = index;
    safeEmit(index);
  }
}
