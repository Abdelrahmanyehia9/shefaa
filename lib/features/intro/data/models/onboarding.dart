import 'package:shefaa/core/utils/app_assets.dart';

class Onboarding {
  final String title;

  final String description;

  final String image;

  const Onboarding({
    required this.title,
    required this.description,
    required this.image,
  });

  static List<Onboarding> get data => [
    const Onboarding(
      title: "اكتشف *أطباء* ذوي خبرة",
      description:
          "اعثر على أفضل الأطباء المتخصصين واختر الطبيب المناسب لك بكل سهولة وثقة.",
      image: AppAssets.doc1,
    ),
    const Onboarding(
      title: "حجز *المواعيد* بكل سهولة",
      description:
          "احجز موعدك مع طبيبك المفضل في دقائق، واختر الوقت المناسب لك بكل سهولة.",
      image: AppAssets.doc2,
    ),

    const Onboarding(
      title: "تعرّف على *أطبائك*",
      description:
          "اطّلع على خبرات الأطباء وتخصصاتهم وتقييماتهم لتختار الطبيب المناسب بثقة.",
      image: AppAssets.doc4,
    ),
  ];
}
