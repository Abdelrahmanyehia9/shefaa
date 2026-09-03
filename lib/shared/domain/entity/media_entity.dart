import 'package:equatable/equatable.dart';
import 'package:shefaa/core/utils/fake_data.dart';

class MediaEntity extends Equatable{

  final String url;
 const MediaEntity({required this.url});

  @override
  // TODO: implement props
  List<Object?> get props => [url];


  static MediaEntity get mock => MediaEntity(url: FakeData.string());
}