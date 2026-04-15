import 'package:suprapp/app/core/constants/app_images.dart';

class CarsModel {
  final String image;
  final String title;
  final String subtitle;
  final String price;
  final String schdule;
  CarsModel(
      {required this.image,
      required this.title,
      required this.subtitle,
      required this.price,
      required this.schdule});
}

List<CarsModel> cars = [
  CarsModel(
      image: AppImages.car1,
      title: "Go Premium 5-hr",
      subtitle: "300 km tak ki savvari",
      price: "INR 1368",
      schdule: "4 mint "),
  CarsModel(
      image: AppImages.car2,
      title: "Go ",
      subtitle: "300 km tak ki savvari",
      price: "INR 1368",
      schdule: "4 mint "),
  CarsModel(
      image: AppImages.car1,
      title: "Go Mini",
      subtitle: "300 km tak ki savvari",
      price: "INR 1368",
      schdule: "4 mint "),
  CarsModel(
      image: AppImages.car1,
      title: "Bike",
      subtitle: "300 km tak ki savvari",
      price: "INR 1368",
      schdule: "4 mint "),
];
