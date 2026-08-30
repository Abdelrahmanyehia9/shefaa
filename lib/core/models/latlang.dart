class LatLong {
  final double lat;
  final double long;

  const LatLong({required this.lat, required this.long});

  factory LatLong.fromJson(Map<String, dynamic> json) {
    return LatLong(
      lat: (json['lat'] as num).toDouble(),
      long: (json['long'] as num).toDouble(),
    );
  }

  Map<String, dynamic> toJson() {
    return {'lat': lat, 'long': long};
  }
}
