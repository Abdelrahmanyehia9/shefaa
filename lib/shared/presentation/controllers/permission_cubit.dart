import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:shefaa/core/enum/app_permission.dart';
import 'package:shefaa/core/helper/permission_handler.dart';

class PermissionState extends Equatable {
  final PermissionResult result;
  final int requestId;

  const PermissionState(this.result, this.requestId);

  @override
  List<Object?> get props => [result, requestId];
}

class PermissionCubit extends Cubit<PermissionState> {
  final PermissionHandler _handler;
  int _requestId = 0;

  PermissionCubit(this._handler)
      : super(const PermissionState(PermissionResult.denied, 0));

  Future<void> request(AppPermission permission) async {
    final result = await _handler.checkAndRequest(permission.toPermission());
    _requestId++;
    emit(PermissionState(result, _requestId));
  }


  Future<void> openSettings() => _handler.openSettings();
}