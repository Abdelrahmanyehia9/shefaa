import 'package:country_picker/country_picker.dart';
import 'package:equatable/equatable.dart';

class PhoneNumber extends Equatable{
  final Country country;
  final String phone;

  const PhoneNumber({required this.country, required this.phone});

  factory PhoneNumber.fromJson(Map<String, dynamic> json) => PhoneNumber(
    country: Country.parse(json["country_code"]),
    phone: json['phone'],
  );

  Map<String, dynamic> toJson() => {
    "country_code": country.countryCode,
    "phone": phone,
  };

  String get complete => "+${country.phoneCode} $phone";

  @override
  // TODO: implement props
  List<Object?> get props => [country, phone];



}
