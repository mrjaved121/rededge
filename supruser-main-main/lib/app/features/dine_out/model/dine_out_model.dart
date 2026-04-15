import 'package:suprapp/app/core/constants/app_images.dart';

class ImageModel {
  final String image1;
  final String image2;
  final String image3;
  final String image4;
  final String image5;
  final String image6;
  final String image7;
  final String image8;
  ImageModel({
    required this.image1,
    required this.image2,
    required this.image3,
    required this.image4,
    required this.image5,
    required this.image6,
    required this.image7,
    required this.image8,
  });
}

class AnotherDiscription {
  final List<ImageModel> image;
  final String title;
  final String rating;
  final String location;
  final String food;
  final String discount;
  final bool isopen;
  final bool isAlchol;
  final bool isnear;
  AnotherDiscription(
      {required this.image,
      required this.title,
      required this.rating,
      required this.location,
      required this.food,
      required this.discount,
      required this.isopen,
      required this.isnear,
      required this.isAlchol});
}

class NestedItem {
  final String title;
  final String imageUrl;
  final List<AnotherDiscription> anotherDiscription;
  NestedItem({
    required this.title,
    required this.imageUrl,
    required this.anotherDiscription,
  });
}

//!...........sample data ............!//
List<NestedItem> mydinout = [
  NestedItem(
      title: "Trending now",
      imageUrl: AppImages.tranding,
      anotherDiscription: [
        AnotherDiscription(
            image: [
              ImageModel(
                  image1: AppImages.award,
                  image2: AppImages.award,
                  image3: AppImages.award,
                  image4: AppImages.award,
                  image5: AppImages.award,
                  image6: AppImages.award,
                  image7: AppImages.award,
                  image8: AppImages.award)
            ],
            title: "Off The Hook - Yas Mall",
            rating: "4.8",
            location: "Ground Level, Yas Mall, Yas Island",
            food: "Seafood. Avg bill: AED 90/person",
            discount: "25% off on A la carte",
            isopen: true,
            isnear: true,
            isAlchol: false),
        AnotherDiscription(
            image: [
              ImageModel(
                  image1: AppImages.award,
                  image2: AppImages.award,
                  image3: AppImages.award,
                  image4: AppImages.award,
                  image5: AppImages.award,
                  image6: AppImages.award,
                  image7: AppImages.award,
                  image8: AppImages.award)
            ],
            title: "Parisian cafe - Al Khubeirah",
            rating: "4.8",
            location: "Level 2, National Tower Mall",
            food: "Cafe, French. Avg bill: AED 105 / person",
            discount: "20% off on A la carte",
            isopen: true,
            isnear: true,
            isAlchol: false)
      ]),
  NestedItem(
      title: "Award Winning",
      imageUrl: AppImages.award,
      anotherDiscription: [
        AnotherDiscription(
            image: [
              ImageModel(
                  image1: AppImages.award,
                  image2: AppImages.award,
                  image3: AppImages.award,
                  image4: AppImages.award,
                  image5: AppImages.award,
                  image6: AppImages.award,
                  image7: AppImages.award,
                  image8: AppImages.award)
            ],
            title: "Off The Hook - Yas Mall",
            rating: "4.8",
            location: "Ground Level, Yas Mall, Yas Island",
            food: "Seafood. Avg bill: AED 90/person",
            discount: "25% off on A la carte",
            isopen: true,
            isnear: true,
            isAlchol: false),
        AnotherDiscription(
            image: [
              ImageModel(
                  image1: AppImages.award,
                  image2: AppImages.award,
                  image3: AppImages.award,
                  image4: AppImages.award,
                  image5: AppImages.award,
                  image6: AppImages.award,
                  image7: AppImages.award,
                  image8: AppImages.award)
            ],
            title: "Parisian cafe - Al Khubeirah",
            rating: "4.8",
            location: "Level 2, National Tower Mall, Al Khubeirah",
            food: "Cafe, French. Avg bill: AED 105 / person",
            discount: "20% off on A la carte",
            isopen: true,
            isnear: true,
            isAlchol: false)
      ]),
  NestedItem(
      title: "Egg-straordinary Breakfasts",
      imageUrl: AppImages.eggtranding,
      anotherDiscription: [
        AnotherDiscription(
            image: [
              ImageModel(
                  image1: AppImages.award,
                  image2: AppImages.award,
                  image3: AppImages.award,
                  image4: AppImages.award,
                  image5: AppImages.award,
                  image6: AppImages.award,
                  image7: AppImages.award,
                  image8: AppImages.award)
            ],
            title: "Off The Hook - Yas Mall",
            rating: "4.8",
            location: "Ground Level, Yas Mall, Yas Island",
            food: "Seafood. Avg bill: AED 90/person",
            discount: "25% off on A la carte",
            isopen: true,
            isnear: true,
            isAlchol: false),
        AnotherDiscription(
            image: [
              ImageModel(
                  image1: AppImages.award,
                  image2: AppImages.award,
                  image3: AppImages.award,
                  image4: AppImages.award,
                  image5: AppImages.award,
                  image6: AppImages.award,
                  image7: AppImages.award,
                  image8: AppImages.award)
            ],
            title: "Parisian cafe - Al Khubeirah",
            rating: "4.8",
            location: "Level 2, National Tower Mall, Al Khubeirah",
            food: "Cafe, French. Avg bill: AED 105 / person",
            discount: "20% off on A la carte",
            isopen: true,
            isnear: true,
            isAlchol: false)
      ])
];
