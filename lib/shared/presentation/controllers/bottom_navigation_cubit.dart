import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shefaa/core/extensions/safe_emit.dart';

class BottomNavigationCubit extends Cubit<int> {
  BottomNavigationCubit([super.initial = 0]);
  DateTime? _lastBackPress;
  void changePage(int? index) {
    if (index == null) return;
    safeEmit(index);
  }


  void onPopScoped({void Function()? onConfirm , void Function()? onExit}) {
    final selectedPage = state ;
    if (selectedPage != 0) {
      changePage(0);
      return ;
    }
    final now = DateTime.now();
    if (_lastBackPress == null || now.difference(_lastBackPress!) > const Duration(seconds: 2)) {
      _lastBackPress = now;
      onConfirm?.call();
      return ;
    }
    onExit?.call();
    return ;
  }
}
