import 'package:suprapp/app/core/constants/app_images.dart';

class BikeModel {
  final String image;
  final String title;
  final String subtitle;
  final String price;
  final String schdule;
  BikeModel(
      {required this.image,
      required this.title,
      required this.subtitle,
      required this.price,
      required this.schdule});
}

List<BikeModel> bike = [
  BikeModel(
      image: AppImages.bikeImage,
      title: "Go Premium 5-hr",
      subtitle: "300 km tak ki savvari",
      price: "INR 1368",
      schdule: "4 mint "),
  BikeModel(
      image: AppImages.bikeImage,
      title: "Go ",
      subtitle: "300 km tak ki savvari",
      price: "INR 1368",
      schdule: "4 mint "),
  BikeModel(
      image: AppImages.bikeImage,
      title: "Go Mini",
      subtitle: "300 km tak ki savvari",
      price: "INR 1368",
      schdule: "4 mint "),
  BikeModel(
      image: AppImages.bikeImage,
      title: "Bike",
      subtitle: "300 km tak ki savvari",
      price: "INR 1368",
      schdule: "4 mint "),
];
