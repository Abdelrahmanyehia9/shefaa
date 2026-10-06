import 'package:shefaa/core/services/supabase_service.dart';
import 'package:shefaa/features/location/data/models/location.dart';
import 'package:shefaa/features/location/data/models/user_location.dart';

class LocationRemoteDataSource {
  final SupabaseService _supabaseService;

  static const _table = "userlocation";

  LocationRemoteDataSource(this._supabaseService);

  Future<UserLocation> addLocation(Location location) async {
    final data = await _supabaseService.UPSERT(
      table: _table,
      data: location.toJson(),
    );

    return UserLocation.fromJson(data);
  }

  Future<UserLocation> selectLocation({required int locId}) async {
    final data = await _supabaseService.UPDATE(
      idValue: locId,
      table: _table,
      data: {"is_selected": true},
    );
    return UserLocation.fromJson(data);
  }

  Future<List<UserLocation>> getAllLocations() async {
    final data = await _supabaseService.GET<UserLocation>(
      table: _table,
      mapper: UserLocation.fromJson,
    );
    return data;
  }

  Future<void> deleteALocation(int locId) async {
    await _supabaseService.DELETE(
      table: _table,
      filter: (e) => e.eq("id", locId),
    );
  }
}
