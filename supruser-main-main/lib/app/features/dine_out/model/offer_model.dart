import 'package:suprapp/app/core/constants/app_images.dart';

class Offer {
  final String title;
  final String subtitle;
  final String image;
  final int durationMonths;

  Offer({
    required this.title,
    required this.subtitle,
    required this.image,
    required this.durationMonths,
  });
}

final offers = [
  Offer(
      title: "Supr Plus AED 15/month",
      subtitle: "Enjoy Supr Plus benefits and save money for AED 15/month",
      image: AppImages.abcd,
      durationMonths: 0),
  Offer(
      title: "6 months free with ADCB",
      subtitle: "Learn more",
      image: AppImages.abcd,
      durationMonths: 6),
  Offer(
      title: "6 months free with Liv",
      subtitle: "Learn more",
      image: AppImages.abcd,
      durationMonths: 6),
  Offer(
      title: "6 months free with Wio",
      subtitle: "Learn more",
      image: AppImages.abcd,
      durationMonths: 6),
  Offer(
      title: "6 months free with FAB",
      subtitle: "Learn more",
      image: AppImages.abcd,
      durationMonths: 6),
  Offer(
      title: "12 months free with HSBC",
      subtitle: "Learn more",
      image: AppImages.abcd,
      durationMonths: 12),
];
