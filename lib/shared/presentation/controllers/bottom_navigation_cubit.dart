import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shefaa/core/extensions/safe_emit.dart';

class BottomNavigationCubit extends Cubit<int> {
  BottomNavigationCubit([super.initial = 0]);

  void changePage(int? index) {
    if (index == null) return;
    safeEmit(index);
  }
}
