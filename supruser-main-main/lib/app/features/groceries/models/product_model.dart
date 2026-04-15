// class ProductModleherbal {
//   final String image;
//   final String title;
//   String? discription;
//   final String price;
//   final int? currentTotalItem;
//   final int? currentTotalPrice;

//   final String condition;
//   final String cool;
//   bool? isHerbal;
//   String? ginger;
//   String? lenongrass;
//   String? lemonPeels;
//   String? licorce;
//   String? limonmrytle;
//   String? calories;
//   String? protein;
//   String? fate;
//   String? sugar;
//   String? old;
//   final String discount;
//   final String id;
//   ProductModleherbal copyWith({
//     int? currentTotalItem,
//     int? currentTotalPrice,
//   })
//   ProductModleherbal({
//     required this.image,
//     required this.title,
//     this.discription,
//     this.currentTotalItem,
//     this.currentTotalPrice,
//     required this.price,
//     required this.condition,
//     required this.cool,
//     this.ginger,
//     this.lenongrass,
//     this.lemonPeels,
//     this.licorce,
//     this.limonmrytle,
//     this.calories,
//     this.protein,
//     this.isHerbal,
//     this.fate,
//     this.sugar,
//     this.old,
//     required this.discount,
//     required this.id,
//   });
// }

class ProductModleherbal {
  final String image;
  final String title;
  String? discription;
  String price;
  int currentTotalItem;
  int currentTotalPrice;

  final String condition;
  final String cool;
  bool? isHerbal;
  String? ginger;
  String? lenongrass;
  String? lemonPeels;
  String? licorce;
  String? limonmrytle;
  String? calories;
  String? protein;
  String? fate;
  String? sugar;
  String? old;
  final String discount;
  final String id;

  ProductModleherbal({
    required this.image,
    required this.title,
    this.discription,
    this.currentTotalItem = 0,
    this.currentTotalPrice = 0,
    required this.price,
    required this.condition,
    required this.cool,
    this.ginger,
    this.lenongrass,
    this.lemonPeels,
    this.licorce,
    this.limonmrytle,
    this.calories,
    this.protein,
    this.isHerbal,
    this.fate,
    this.sugar,
    this.old,
    required this.discount,
    required this.id,
  });
  ProductModleherbal copyWith({
    String? id,
    String? title,
    String? price,
    String? image,
    int? currentTotalItem,
    int? currentTotalPrice,
  }) {
    return ProductModleherbal(
      image: image ?? this.image,
      title: title ?? this.title,
      discription: discription,
      price: price ?? this.price,
      currentTotalItem: currentTotalItem ?? this.currentTotalItem,
      currentTotalPrice: currentTotalPrice ?? this.currentTotalPrice,
      condition: condition,
      cool: cool,
      ginger: ginger,
      lenongrass: lenongrass,
      lemonPeels: lemonPeels,
      licorce: licorce,
      limonmrytle: limonmrytle,
      calories: calories,
      protein: protein,
      isHerbal: isHerbal,
      fate: fate,
      sugar: sugar,
      old: old,
      discount: discount,
      id: id ?? this.id,
    );
  }
}

List<ProductModleherbal> myherbalList = [
  ProductModleherbal(
    image:
        'https://freshbasket.com.pk/cdn/shop/files/AlmaraiMilkFullFat1L_1024x1024.jpg?v=1724047979',
    title: "Almaria full fat fresh Milk 2L",
    discription: "Neem & Turm...",
    price: "12.10",
    condition: "Storage Condition",
    cool: "Cool & dry, below 25C",
    ginger: "51%",
    lenongrass: "29%",
    lemonPeels: "10%",
    licorce: "",
    isHerbal: true,
    limonmrytle: "",
    calories: "1 kCal",
    protein: "0.1g",
    fate: "0.1g",
    sugar: "0.1g",
    old: '24',
    discount: '-20%',
    id: 'herbal_1',
  ),
  ProductModleherbal(
    image:
        'https://thefreshandnatural.com/wp-content/uploads/2020/05/CUCUMBER-SAUDI-KG.jpg',
    title: "Cucumber UAE \n1 kg",
    discription: "Neem & Turm...",
    price: "3.10",
    condition: "Storage Condition",
    cool: "Cool & dry, below 25C",
    ginger: "51%",
    lenongrass: "29%",
    lemonPeels: "10%",
    isHerbal: true,
    licorce: "",
    limonmrytle: "",
    calories: "1 kCal",
    protein: "0.1g",
    fate: "0.1g",
    sugar: "0.1g",
    old: '24',
    discount: '-20%',
    id: 'herbal_2',
  ),
  ProductModleherbal(
    image:
        'https://thefreshandnatural.com/wp-content/uploads/2023/05/PHOTO-2023-05-12-21-04-49.jpg',
    title: "Egg  \n1 dozen",
    discription: "Neem & Turm...",
    price: "10.20",
    condition: "Storage Condition",
    cool: "Cool & dry, below 25C",
    ginger: "51%",
    lenongrass: "29%",
    lemonPeels: "10%",
    licorce: "",
    isHerbal: true,
    limonmrytle: "",
    calories: "1 kCal",
    protein: "0.1g",
    fate: "0.1g",
    sugar: "0.1g",
    old: '24',
    discount: '-20%',
    id: 'herbal_3',
  ),
];

List<ProductModleherbal> myRecomendations = [
  ProductModleherbal(
      image:
          'https://media.gettyimages.com/id/173242750/photo/banana-bunch.jpg?s=2048x2048&w=gi&k=20&c=4ScLswWY980TBkoovO1jhQDONHZ7x3kg29JlQGyXs7c=',
      title: "Banana Ecuador  500 g",
      price: "2.60",
      condition: "Storage Condition",
      cool: "Cool & dry, below 25C",
      old: "",
      isHerbal: false,
      discount: "-9%",
      id: "item_1"),
  ProductModleherbal(
      image:
          'https://media.gettyimages.com/id/1322500654/photo/sweet-soft-drink-bottle-on-white-background.jpg?s=2048x2048&w=gi&k=20&c=QBGmDv_cgH78mksh_0A1m8TbeF7WEplth0Hka7YEIvo=',
      title: "Fit Fresh\nOranges juice",
      price: "16.00",
      condition: "Storage Condition",
      cool: "Cool & dry, below 25C",
      isHerbal: false,
      old: "",
      discount: "-9%",
      id: "item_2"),
  ProductModleherbal(
      image:
          'https://themeatzgrocer.com.my/wp-content/uploads/2021/11/IMG_3276.webp',
      title: "Onion Red Indea 900 -1000 g",
      price: "2.60",
      condition: "Storage Condition",
      cool: "Cool & dry, below 25C",
      isHerbal: false,
      old: "",
      discount: "-9%",
      id: "item_3"),
];
List<ProductModleherbal> milkAndYogurt = [
  ProductModleherbal(
      image:
          'https://as2.ftcdn.net/jpg/05/88/75/69/1000_F_588756932_5ZQBUg6KLT3kFAkR4EkRNuAaPCnDVQAS.webp',
      title: "Lay's Cream & Onion Patato...",
      price: "4.25",
      condition: "Storage Condition",
      isHerbal: false,
      cool: "Cool & dry, below 25C",
      old: "5.00",
      discount: "-15%",
      id: "milk_1"),
  ProductModleherbal(
      image:
          'https://www.kleenex.com.my/-/media/Project/KleenexMY/Products/PDP/Facial-Tissue/Daily-care/Vintage/Desktop/Artboard-13.png?h=204&iar=0&w=338&rev=7f4ed10449e24d319ea4b8ad674610df',
      title: "Kleenex Daily Care Facial...",
      price: "9.25",
      condition: "Storage Condition",
      isHerbal: false,
      cool: "Cool & dry, below 25C",
      old: "5.00",
      discount: "-15%",
      id: "milk_2"),
  ProductModleherbal(
      image: 'https://m.media-amazon.com/images/I/71gtvZPieHL._SX679_.jpg',
      title: "Himalaya pure Tulsi & Aloe ...",
      price: "17.40",
      condition: "Storage Condition",
      cool: "Cool & dry, below 25C",
      old: "5.00",
      discount: "-15%",
      id: "milk_3"),
];
List<ProductModleherbal> beverages = [
  ProductModleherbal(
      image:
          'https://media.istockphoto.com/id/1482149278/photo/fresh-avocado-on-white.jpg?s=2048x2048&w=is&k=20&c=N-woJ9oN7lejIWKouYPCYm1D5w8RP6mlZRtnHvUVq4M=',
      title: "Avocado Hass RTE South Am...",
      price: "13.50",
      condition: "Storage Condition",
      isHerbal: false,
      cool: "Cool & dry, below 25C",
      old: "4.00",
      discount: "-12%",
      id: "bev_1"),
  ProductModleherbal(
      image:
          'https://spice-world.co.za/cdn/shop/files/1289_3919_65f580da674e14.34558698_IMG_1410_1080x.png?v=1746779291',
      title: "Osman Chilli Sauce 500ml",
      price: "5.50",
      condition: "Storage Condition",
      cool: "Cool & dry, below 25C",
      old: "4.00",
      discount: "-12%",
      id: "bev_2"),
  ProductModleherbal(
      image:
          "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTWm8nJlEPObT1-XdlBT7CagggnQ4t7pjGFEQ&s",
      title: "Pepsi Can 330ml",
      price: "3.50",
      condition: "Storage Condition",
      isHerbal: false,
      cool: "Cool & dry, below 25C",
      old: "4.00",
      discount: "-12%",
      id: "bev_3"),
];
List<ProductModleherbal> bundleOffers = [
  ProductModleherbal(
      image:
          'https://as1.ftcdn.net/jpg/04/35/65/78/1000_F_435657841_ceDTgNEZAY8lVbwK6ESCmTzfKpNQG1Uj.webp',
      title: "Deter Bundle Pack 5 pieces ",
      price: "28.00",
      condition: "Storage Condition",
      cool: "Cool & dry, below 25C",
      old: "22.00",
      discount: "-18%",
      id: "bundle_1"),
  ProductModleherbal(
      image:
          'https://as1.ftcdn.net/jpg/05/39/60/90/1000_F_539609028_vqdEYa7GROujPxhItIlLV2e7cEEUVFpT.webp',
      title: "Fresh  Apple 1 kg",
      price: "12.50",
      condition: "Storage Condition",
      isHerbal: false,
      cool: "Cool & dry, below 25C",
      old: "22.00",
      discount: "-18%",
      id: "bundle_2"),
  ProductModleherbal(
      image:
          'https://as2.ftcdn.net/jpg/05/37/04/61/1000_F_537046123_s8JVn2NrClPQDOryhSm8jonYZPfIzPRX.webp',
      title: "Fresh Tomatoes per Kg",
      price: "8.00",
      condition: "Storage Condition",
      isHerbal: false,
      cool: "Cool & dry, below 25C",
      old: "22.00",
      discount: "-18%",
      id: "bundle_3"),
];
List<ProductModleherbal> reducedToClear = [
  ProductModleherbal(
      image:
          'https://as2.ftcdn.net/jpg/02/54/92/05/1000_F_254920579_xOIyVqIWxgUi0fSQ8FwBC95YlIVZpuCd.jpg',
      title: "Mix Sweets in Dish, A large variety of Pakistani Mithai",
      price: "35.00",
      condition: "Storage Condition",
      isHerbal: false,
      cool: "Cool & dry, below 25C",
      old: "10.00",
      discount: "-50%",
      id: "clear_1"),
  ProductModleherbal(
      image:
          'https://media.istockphoto.com/id/1436864582/photo/top-view-box-of-ice-cream-with-a-spoon-at-horizontal-composition.jpg?s=2048x2048&w=is&k=20&c=_G62yMlEsOwPNsfA1Bx0ugk3AIKMUMpERYtXdqOGkug=',
      title: "Ice Cream \n 1 Pack",
      price: "15.00",
      condition: "Storage Condition",
      cool: "Cool & dry, below 25C",
      isHerbal: false,
      old: "10.00",
      discount: "-50%",
      id: "clear_2"),
  ProductModleherbal(
      image:
          'https://media.istockphoto.com/id/1349560821/photo/traditional-vanilla-pound-cake-with-orange-extract-bundt-cake.jpg?s=2048x2048&w=is&k=20&c=N4anbVINtIN2Qs95ZBiHIRbena9rDKQaIaohAaWLWCw=',
      title: "2 pound Cake ",
      price: "25.00",
      condition: "Storage Condition",
      isHerbal: false,
      cool: "Cool & dry, below 25C",
      old: "10.00",
      discount: "-50%",
      id: "clear_3"),
];
List<ProductModleherbal> mangoes = [
  ProductModleherbal(
      image:
          "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQkEbYmomBlqAHgrep6gH24ZgGnkRsK0mk9Dw&s",
      title: "Alphonso Mango Premium Box",
      price: "19.20",
      condition: "Storage Condition",
      cool: "Cool & dry, below 25C",
      isHerbal: false,
      old: "24",
      discount: "-20%",
      id: "mango1"),
  ProductModleherbal(
      image:
          "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQkEbYmomBlqAHgrep6gH24ZgGnkRsK0mk9Dw&s",
      title: "Alphonso Mango Premium Box",
      price: "19.20",
      condition: "Storage Condition",
      isHerbal: false,
      cool: "Cool & dry, below 25C",
      old: "24",
      discount: "-20%",
      id: "mango2"),
  ProductModleherbal(
      image:
          "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQkEbYmomBlqAHgrep6gH24ZgGnkRsK0mk9Dw&s",
      title: "Alphonso Mango Premium Box",
      price: "19.20",
      condition: "Storage Condition",
      cool: "Cool & dry, below 25C",
      old: "24",
      isHerbal: false,
      discount: "-20%",
      id: "mango3"),
];
List<ProductModleherbal> mostLoved = [
  ProductModleherbal(
      image:
          "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSSgYoY-mxL8X2G2cF1okBsFDc_EqIjhTsznw&s",
      title: "Alphonso Mango Premium Box",
      price: "19.20",
      condition: "Storage Condition",
      isHerbal: false,
      cool: "Cool & dry, below 25C",
      old: "19.20",
      discount: "-20%",
      id: "loved1"),
  ProductModleherbal(
      image:
          "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSSgYoY-mxL8X2G2cF1okBsFDc_EqIjhTsznw&s",
      title: "Alphonso Mango Premium Box",
      price: "19.20",
      condition: "Storage Condition",
      cool: "Cool & dry, below 25C",
      old: "19.20",
      isHerbal: false,
      discount: "-20%",
      id: "loved2"),
  ProductModleherbal(
      image:
          "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSSgYoY-mxL8X2G2cF1okBsFDc_EqIjhTsznw&s",
      title: "Alphonso Mango Premium Box",
      price: "19.20",
      condition: "Storage Condition",
      cool: "Cool & dry, below 25C",
      isHerbal: false,
      old: "19.20",
      discount: "-20%",
      id: "loved3"),
];
List<ProductModleherbal> liquid = [
  ProductModleherbal(
      image:
          "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTrW9Qy1nHncu5WHJXEY2I2JIpueTABoNECSg&s",
      title: "Omo Active Detergent Liquid 2L",
      price: "25.99",
      isHerbal: false,
      condition: "Storage Condition",
      cool: "Cool & dry, below 25C",
      discount: "-20%",
      id: "liquid1"),
  ProductModleherbal(
      image:
          "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTrW9Qy1nHncu5WHJXEY2I2JIpueTABoNECSg&s",
      title: "Omo Active Detergent Liquid 2L",
      price: "25.99",
      condition: "Storage Condition",
      cool: "Cool & dry, below 25C",
      isHerbal: false,
      discount: "-20%",
      id: "liquid2"),
  ProductModleherbal(
      image:
          "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTrW9Qy1nHncu5WHJXEY2I2JIpueTABoNECSg&s",
      title: "Omo Active Detergent Liquid 2L",
      price: "25.99",
      condition: "Storage Condition",
      cool: "Cool & dry, below 25C",
      isHerbal: false,
      discount: "-20%",
      id: "liquid3"),
];
List<ProductModleherbal> powder = [
  ProductModleherbal(
      image:
          "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQajfjQ7QBehnOBrEorTgSmy7w0cm5Cfa2_Kg&s",
      title: "Ariel Original Detergent Powder 2.5kg",
      price: "19.20",
      old: "24",
      isHerbal: false,
      condition: "Storage Condition",
      cool: "Cool & dry, below 25C",
      discount: "-20%",
      id: "powder1"),
  ProductModleherbal(
      image:
          "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQajfjQ7QBehnOBrEorTgSmy7w0cm5Cfa2_Kg&s",
      title: "Ariel Original Detergent Powder 2.5kg",
      price: "19.20",
      old: "24",
      condition: "Storage Condition",
      isHerbal: false,
      cool: "Cool & dry, below 25C",
      discount: "-20%",
      id: "powder2"),
  ProductModleherbal(
      image:
          "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQajfjQ7QBehnOBrEorTgSmy7w0cm5Cfa2_Kg&s",
      title: "Ariel Original Detergent Powder 2.5kg",
      price: "19.20",
      old: "24",
      condition: "Storage Condition",
      isHerbal: false,
      cool: "Cool & dry, below 25C",
      discount: "-20%",
      id: "powder3"),
];
List<ProductModleherbal> toab = [
  ProductModleherbal(
      image:
          "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSSrX1lI7ToaPINYCMPVfOzG2MmSaFE8WvXIw&s",
      title: "Finish Powerball Dishwasher Tabs (20 pcs)",
      price: "3.50",
      old: "4.00",
      isHerbal: false,
      condition: "Storage Condition",
      cool: "Cool & dry, below 25C",
      discount: "-12%",
      id: "tab1"),
  ProductModleherbal(
      image:
          "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSSrX1lI7ToaPINYCMPVfOzG2MmSaFE8WvXIw&s",
      title: "Finish Powerball Dishwasher Tabs (20 pcs)",
      price: "3.50",
      old: "4.00",
      condition: "Storage Condition",
      cool: "Cool & dry, below 25C",
      isHerbal: false,
      discount: "-12%",
      id: "tab2"),
  ProductModleherbal(
      image:
          "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSSrX1lI7ToaPINYCMPVfOzG2MmSaFE8WvXIw&s",
      title: "Finish Powerball Dishwasher Tabs (20 pcs)",
      price: "3.50",
      old: "4.00",
      condition: "Storage Condition",
      isHerbal: false,
      cool: "Cool & dry, below 25C",
      discount: "-12%",
      id: "tab3"),
];
List<ProductModleherbal> surfaceCleaners = [
  ProductModleherbal(
      image:
          "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQBA_5tGd8AqriWNeJuHb3GtpgwDg6wKNjxpw&s",
      title: "Dettol Surface Cleaner 1L",
      price: "18.00",
      isHerbal: false,
      old: "22.00",
      condition: "Storage Condition",
      cool: "Cool & dry, below 25C",
      discount: "-18%",
      id: "surface1"),
  ProductModleherbal(
      image:
          "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQBA_5tGd8AqriWNeJuHb3GtpgwDg6wKNjxpw&s",
      title: "Dettol Surface Cleaner 1L",
      price: "18.00",
      old: "22.00",
      isHerbal: false,
      condition: "Storage Condition",
      cool: "Cool & dry, below 25C",
      discount: "-18%",
      id: "surface2"),
  ProductModleherbal(
      image:
          "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQBA_5tGd8AqriWNeJuHb3GtpgwDg6wKNjxpw&s",
      title: "Dettol Surface Cleaner 1L",
      price: "18.00",
      old: "22.00",
      condition: "Storage Condition",
      isHerbal: false,
      cool: "Cool & dry, below 25C",
      discount: "-18%",
      id: "surface3"),
];
List<ProductModleherbal> stainRemover = [
  ProductModleherbal(
      image:
          "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcS2tBFi8uRkBdYEyV8aJlZXTKaUaKBlryl93A&s",
      title: "Vanish Oxi Action Powder 500g",
      price: "5.00",
      isHerbal: false,
      old: "10.00",
      condition: "Storage Condition",
      cool: "Cool & dry, below 25C",
      discount: "-50%",
      id: "stain1"),
  ProductModleherbal(
      image:
          "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcS2tBFi8uRkBdYEyV8aJlZXTKaUaKBlryl93A&s",
      title: "Vanish Oxi Action Powder 500g",
      price: "5.00",
      old: "10.00",
      condition: "Storage Condition",
      isHerbal: false,
      cool: "Cool & dry, below 25C",
      discount: "-50%",
      id: "stain2"),
  ProductModleherbal(
      image:
          "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcS2tBFi8uRkBdYEyV8aJlZXTKaUaKBlryl93A&s",
      title: "Vanish Oxi Action Powder 500g",
      price: "5.00",
      old: "10.00",
      condition: "Storage Condition",
      cool: "Cool & dry, below 25C",
      isHerbal: false,
      discount: "-50%",
      id: "stain3"),
];
List<ProductModleherbal> fabricSoftners = [
  ProductModleherbal(
      image:
          "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTo8XrC4NRGPNfV83R5BxqYtvg8xNskiTInTg&s",
      title: "Comfort Fabric Softener Blue 1L",
      price: "4.25",
      old: "5.00",
      condition: "Storage Condition",
      isHerbal: false,
      cool: "Cool & dry, below 25C",
      discount: "-15%",
      id: "fabric1"),
  ProductModleherbal(
      image:
          "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTo8XrC4NRGPNfV83R5BxqYtvg8xNskiTInTg&s",
      title: "Comfort Fabric Softener Blue 1L",
      price: "4.25",
      old: "5.00",
      condition: "Storage Condition",
      isHerbal: false,
      cool: "Cool & dry, below 25C",
      discount: "-15%",
      id: "fabric2"),
  ProductModleherbal(
      image:
          "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTo8XrC4NRGPNfV83R5BxqYtvg8xNskiTInTg&s",
      title: "Comfort Fabric Softener Blue 1L",
      price: "4.25",
      old: "5.00",
      condition: "Storage Condition",
      cool: "Cool & dry, below 25C",
      isHerbal: false,
      discount: "-15%",
      id: "fabric3"),
];
List<ProductModleherbal> items = [
  ProductModleherbal(
      image:
          "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQavcMVvrXn7KoldH8-1IiGNwLbh0mFtskAgA&s",
      title: "Sanita Club Biodegradable",
      price: "25.99",
      isHerbal: false,
      condition: "Storage Condition",
      cool: "Cool & dry, below 25C",
      discount: "-9%",
      id: "item1"),
  ProductModleherbal(
      image:
          "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQavcMVvrXn7KoldH8-1IiGNwLbh0mFtskAgA&s",
      title: "Sanita Club Biodegradable",
      price: "25.99",
      isHerbal: false,
      condition: "Storage Condition",
      cool: "Cool & dry, below 25C",
      discount: "-9%",
      id: "item2"),
  ProductModleherbal(
      image:
          "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQavcMVvrXn7KoldH8-1IiGNwLbh0mFtskAgA&s",
      title: "Sanita Club Biodegradable",
      price: "25.99",
      isHerbal: false,
      condition: "Storage Condition",
      cool: "Cool & dry, below 25C",
      discount: "-9%",
      id: "item3"),
];
List<ProductModleherbal> daipers = [
  ProductModleherbal(
      image:
          "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTycPxb70Yu6ww3l0b85CtvcOYCxa468tgY_g&s",
      title: "Pampers Premium Care Size 3 (58 pcs)",
      price: "25.99",
      isHerbal: false,
      condition: "Storage Condition",
      cool: "Cool & dry, below 25C",
      discount: "-9%",
      id: "101"),
  ProductModleherbal(
      image:
          "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTycPxb70Yu6ww3l0b85CtvcOYCxa468tgY_g&s",
      title: "Pampers Premium Care Size 3 (58 pcs)",
      price: "25.99",
      condition: "Storage Condition",
      cool: "Cool & dry, below 25C",
      isHerbal: false,
      discount: "-9%",
      id: "102"),
  ProductModleherbal(
      image:
          "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTycPxb70Yu6ww3l0b85CtvcOYCxa468tgY_g&s",
      title: "Pampers Premium Care Size 3 (58 pcs)",
      price: "25.99",
      condition: "Storage Condition",
      cool: "Cool & dry, below 25C",
      isHerbal: false,
      discount: "-9%",
      id: "103"),
];
List<ProductModleherbal> babyBath = [
  ProductModleherbal(
      image:
          "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSPeH9Zji50jD_pss2wmvPgQYETYgnv7iFtpA&s",
      title: "Johnson’s Baby Bath 500ml",
      price: "19.20",
      old: "24",
      condition: "Storage Condition",
      isHerbal: false,
      cool: "Cool & dry, below 25C",
      discount: "-20%",
      id: "201"),
  ProductModleherbal(
      image:
          "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSPeH9Zji50jD_pss2wmvPgQYETYgnv7iFtpA&s",
      title: "Johnson’s Baby Bath 500ml",
      price: "19.20",
      isHerbal: false,
      old: "24",
      condition: "Storage Condition",
      cool: "Cool & dry, below 25C",
      discount: "-20%",
      id: "202"),
  ProductModleherbal(
      image:
          "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSPeH9Zji50jD_pss2wmvPgQYETYgnv7iFtpA&s",
      title: "Johnson’s Baby Bath 500ml",
      price: "19.20",
      old: "24",
      condition: "Storage Condition",
      isHerbal: false,
      cool: "Cool & dry, below 25C",
      discount: "-20%",
      id: "203"),
];
List<ProductModleherbal> babyCare = [
  ProductModleherbal(
      image:
          "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQEV5qK-KIb0HWUenN0enHWQsiKM5hlChpLWw&s",
      title: "Johnson’s Baby Lotion 500ml",
      price: "14.50",
      old: "18.00",
      isHerbal: false,
      condition: "Storage Condition",
      cool: "Cool & dry, below 25C",
      discount: "-19%",
      id: "301"),
  ProductModleherbal(
      image:
          "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQEV5qK-KIb0HWUenN0enHWQsiKM5hlChpLWw&s",
      title: "Johnson’s Baby Lotion 500ml",
      price: "14.50",
      old: "18.00",
      condition: "Storage Condition",
      isHerbal: false,
      cool: "Cool & dry, below 25C",
      discount: "-19%",
      id: "302"),
  ProductModleherbal(
      image:
          "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQEV5qK-KIb0HWUenN0enHWQsiKM5hlChpLWw&s",
      title: "Johnson’s Baby Lotion 500ml",
      price: "14.50",
      old: "18.00",
      isHerbal: false,
      condition: "Storage Condition",
      cool: "Cool & dry, below 25C",
      discount: "-19%",
      id: "303"),
];
List<ProductModleherbal> babyFood = [
  ProductModleherbal(
      image:
          "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcR-5W_woOKQPX7F3AkdIIhVt3n2GXkdYnMZ6Q&s",
      title: "Gerber Rice Cereal 227g",
      price: "15.00",
      isHerbal: false,
      old: "18.00",
      condition: "Storage Condition",
      cool: "Cool & dry, below 25C",
      discount: "-17%",
      id: "401"),
  ProductModleherbal(
      image:
          "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcR-5W_woOKQPX7F3AkdIIhVt3n2GXkdYnMZ6Q&s",
      title: "Gerber Rice Cereal 227g",
      price: "15.00",
      isHerbal: false,
      old: "18.00",
      condition: "Storage Condition",
      cool: "Cool & dry, below 25C",
      discount: "-17%",
      id: "402"),
  ProductModleherbal(
      image:
          "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcR-5W_woOKQPX7F3AkdIIhVt3n2GXkdYnMZ6Q&s",
      title: "Gerber Rice Cereal 227g",
      price: "15.00",
      old: "18.00",
      isHerbal: false,
      condition: "Storage Condition",
      cool: "Cool & dry, below 25C",
      discount: "-17%",
      id: "403"),
];

List<ProductModleherbal> forgotList = [
  ProductModleherbal(
      image:
          'https://images.pexels.com/photos/1093038/pexels-photo-1093038.jpeg?auto=compress&cs=tinysrgb&w=1260&h=750&dpr=2',
      title: "Banana Ecuador  500 g",
      price: "2.60",
      condition: "Storage Condition",
      cool: "Cool & dry, below 25C",
      old: "",
      isHerbal: false,
      discount: "-9%",
      id: "Banana_1"),
  ProductModleherbal(
      image:
          'https://as2.ftcdn.net/jpg/09/22/47/81/1000_F_922478174_NXnW2EgbqUaPphCnIxAXcigjUIoAFmZh.jpg',
      title: "Strawberry 500 g",
      price: "46.00",
      condition: "Storage Condition",
      cool: "Cool & dry, below 25C",
      isHerbal: false,
      old: "",
      discount: "-9%",
      id: "banana_2"),
  ProductModleherbal(
      image:
          'https://as1.ftcdn.net/v2/jpg/11/09/89/14/1000_F_1109891497_Duf92wXPuTjSMFK4JPaAayv12yX7QByN.jpg',
      title: "Pomegranate  500 g",
      price: "2.60",
      condition: "Storage Condition",
      cool: "Cool & dry, below 25C",
      isHerbal: false,
      old: "",
      discount: "-9%",
      id: "banana_3"),
  ProductModleherbal(
      image:
          'https://as2.ftcdn.net/jpg/09/36/00/81/1000_F_936008110_gpv6t5cHPXZJ7Y5L32BfPfil0hNX8oFU.jpg',
      title: "Pine Apple  1k g",
      price: "12.260",
      condition: "Storage Condition",
      cool: "Cool & dry, below 25C",
      isHerbal: false,
      old: "",
      discount: "-9%",
      id: "banan_4")
];
